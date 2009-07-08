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
   IBOutlet UITextField *textField_;
   NumberLabel *numberLabels[4];
   NumberLabel *currentNumber;
}

- (void) setCurrent:(NumberLabel *) numberLabel;

@end