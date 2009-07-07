//
//  WelcomeViewController.h
//  PushPaste
//
//  Created by Motohiro Takayama on 7/7/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

@class NumberButton;

@interface WelcomeViewController : UIViewController
{
   IBOutlet UIButton *firstNumber;
   IBOutlet NumberButton *secondNumber;
   IBOutlet NumberButton *thirdNumber;
   IBOutlet NumberButton *fourthNumber;
}

@property (nonatomic, retain) UIButton *firstNumber;
@end