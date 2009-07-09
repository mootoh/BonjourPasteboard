//
//  WelcomeViewController.m
//  PushPaste
//
//  Created by Motohiro Takayama on 7/7/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import "WelcomeViewController.h"
#import "NumberLabel.h"

@interface WelcomeViewController (Private)
- (void) updateNumbers;
- (void) negotiateWithPeers;
- (void) findPeers;
- (void) setupStreams;
- (void) sendPasscode;
@end

@implementation WelcomeViewController

@synthesize services, passcode;

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
   if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
   }
   return self;
}
*/

//  ask password if not exist
- (void)viewWillAppear:(BOOL)animated
{
   for (int i=0; i<4; i++) {
      NumberLabel *nl = [[NumberLabel alloc] initWithFrame:CGRectMake(20+64*i + 8*i, 90, 64, 90)];
      nl.font = [UIFont systemFontOfSize:64];
      nl.textAlignment = UITextAlignmentCenter;
      nl.opaque = YES;
      nl.userInteractionEnabled = YES;
      nl.text = @"*";
      nl.welcomeViewController = self;
      numberLabels[i] = nl;
      [self.view addSubview:nl];
   }

   for (int i=0; i<3; i++)
      numberLabels[i].next = numberLabels[i+1];
   numberLabels[3].next = nil;

   [numberLabels[0] select];
   currentNumber = numberLabels[0];

   [self updateNumbers];

   textField_.delegate = self;
   [textField_ becomeFirstResponder];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
   [super viewDidLoad];
}

- (void) viewWillDisappear:(BOOL)animated
{
   [super viewWillDisappear:animated];
   [istream close];
   [ostream close];
   //[service stop];
}

- (void)dealloc
{
   if (istream) [istream release];
   if (ostream) [ostream release];
   [super dealloc];
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   NSAssert(currentNumber != nil, @"currentNumber should point valid instance.");
   currentNumber.number = string;
   currentNumber.text = string;
   currentNumber = currentNumber.next;
   if (currentNumber == nil) {
      NSLog(@"no next");
      // do some finalization
      // finish text input
      [textField resignFirstResponder];
      
      self.passcode = [NSString stringWithFormat:@"%@%@%@%@",
         numberLabels[0].text,
         numberLabels[1].text,
         numberLabels[2].text,
         numberLabels[3].text];
      // wait for Mac side
      [self findPeers];
   } else {
      [currentNumber select];
   }
   [self.view setNeedsDisplay];
   return NO; // discard it
}

- (void) setCurrent:(NumberLabel *) numberLabel
{
   currentNumber = numberLabel;
   [currentNumber selected];
   currentNumber.text = @"*";

   for (int i=0; i<4; i++) {
      NumberLabel *nl = numberLabels[i];
      if (nl == numberLabel) continue;
      if (nl.selected)
         [nl deselect];
   }
   [textField_ becomeFirstResponder];
}

- (void) negotiateWithPeers
{
   [self setupStreams];
   [self sendPasscode];
   
   //   save password
   //   search for Mac app via Bonjour
   
   //   show guidance to launch Mac side app
   //   wait for Mac app to start
   //   recieve password from Mac app
   //   verify password
   //   send {ok:UUID or ng} to Mac app
   //   waiting for response
   //   show "OK" if recieved success
   //   put down initial flag   
}

@end

@implementation WelcomeViewController (Private)

- (void) updateNumbers
{
   for (int i=0; i<4; i++)
      [numberLabels[i] setNeedsDisplay];
}

- (void) findPeers
{
   browser = [[NSNetServiceBrowser alloc] init];
   services = [[NSMutableArray array] retain];
   [browser setDelegate:self];
   [browser searchForServicesOfType:@"_wwdcpic._tcp." inDomain:@""];
}

#pragma mark netServiceBrowser

// This object is the delegate of its NSNetServiceBrowser object. We're only interested in services-related methods, so that's what we'll call.
- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
   NSLog(@"found");
   aNetService.delegate = self;
   [services addObject:aNetService];
   [aNetService resolveWithTimeout:5.0];

   NSLog(@"service name = %@", aNetService.name);
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
   NSLog(@"removed");
   [services removeObject:aNetService];
   aNetService.delegate = nil;
   
//  if ([navigationController.topViewController isKindOfClass:[RemoteShortcutsIPhoneViewController class]]) {
//      RemoteShortcutsIPhoneViewController *rsipvc = (RemoteShortcutsIPhoneViewController *)navigationController.topViewController;
//      if ([aNetService isEqual:rsipvc.service]) {
//         [navigationController popViewControllerAnimated:YES];
//      }
//   }
//   [self updatePeers];
}

- (void) setupStreams
{
   NSNetService *service = [services objectAtIndex:0];
   [service getInputStream:&istream outputStream:&ostream];
   [istream retain];
   [ostream retain];
   [istream setDelegate:self];
   [ostream setDelegate:self];
   [istream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                      forMode:NSDefaultRunLoopMode];
   [ostream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                      forMode:NSDefaultRunLoopMode];
   [istream open];
   [ostream open];
}

- (void) sendPasscode
{
   NSLog(@"sendPasscode: %@", passcode);

   NSInteger wrote = [ostream write:[passcode UTF8String] maxLength:4];
   if (wrote != 4)
      NSLog(@"something wrong is happened at copy, written size = %d", wrote);
}
@end