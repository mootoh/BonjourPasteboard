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
- (void) updateCurrentNumber;
- (void) updateNumbers;
@end

@implementation WelcomeViewController

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
   if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
   }
   return self;
}
*/

- (void)viewWillAppear:(BOOL)animated
{
   for (int i=0; i<4; i++) {
      NumberLabel *nl = [[NumberLabel alloc] initWithFrame:CGRectMake(20+64*i, 90, 64, 90)];
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

- (void)dealloc
{
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
      // wait for Mac side
      NSLog(@"pass code is %@%@%@%@",
            numberLabels[0].text,
            numberLabels[1].text,
            numberLabels[2].text,
            numberLabels[3].text);
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

@end

@implementation WelcomeViewController (Private)

- (void) updateCurrentNumber
{
   currentNumber.selected = YES;
   [currentNumber setNeedsDisplay];
}

- (void) updateNumbers
{
   for (int i=0; i<4; i++)
      [numberLabels[i] setNeedsDisplay];
}

@end