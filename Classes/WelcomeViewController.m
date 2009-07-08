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
@end

@implementation WelcomeViewController
@synthesize firstNumber;

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
   if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
   }
   return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
   [super viewDidLoad];
   
   currentNumber = firstNumber;

   firstNumber.opaque = YES;
   firstNumber.next = secondNumber;
   secondNumber.next = nil;
   firstNumber.backgroundColor = [UIColor blueColor];
   
   textField.delegate = self;
   [textField becomeFirstResponder];
   [self.view addSubview:firstNumber];
   [self updateCurrentNumber];
}

- (void) clicked
{
   NSLog(@"cl");
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
   [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
   [super dealloc];
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   NSAssert(currentNumber != nil, @"currentNumber should point valid instance.");
   currentNumber.selected = NO;
   currentNumber.number = string;
   currentNumber.text = string;
   currentNumber = currentNumber.next;
   if (currentNumber == nil) {
      // do some finalization
      NSLog(@"no next");
   } else {
      currentNumber.selected = YES;
   }
   [self.view setNeedsDisplay];
   return NO;
}

@end

@implementation WelcomeViewController (Private)

- (void) updateCurrentNumber
{
   currentNumber.selected = YES;
   [currentNumber setNeedsDisplay];
}

@end