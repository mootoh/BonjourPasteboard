//
//  WelcomeViewController.h
//  PushPaste
//
//  Created by Motohiro Takayama on 7/7/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

@class NumberLabel;

@interface WelcomeViewController : UIViewController <UITextFieldDelegate>
{
   IBOutlet NumberLabel *firstNumber;
   IBOutlet NumberLabel *secondNumber;
   IBOutlet NumberLabel *thirdNumber;
   IBOutlet NumberLabel *fourthNumber;
   
   IBOutlet UITextField *textField;
   NumberLabel *currentNumber;
}

@property (nonatomic, retain) NumberLabel *firstNumber;
@end