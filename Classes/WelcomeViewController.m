//
//  WelcomeViewController.m
//  PushPaste
//
//  Created by Motohiro Takayama on 7/7/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import "WelcomeViewController.h"
#import "NumberButton.h"

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
   firstNumber.opaque = YES;
   //firstNumber.next = secondNumber;
   [firstNumber setTitle:@"first" forState:UIControlStateNormal];
   secondNumber.next = nil;
   [firstNumber addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchDown];
   firstNumber.backgroundColor = [UIColor blueColor];
   
   [firstNumber becomeFirstResponder];
   [self.view addSubview:firstNumber];
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


@end
