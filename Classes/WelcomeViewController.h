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
   IBOutlet UILabel *pasteLabel;
   NumberLabel *numberLabels[4];
   NumberLabel *currentNumber;
   
   NSString *passcode;
   
   NSNetServiceBrowser *browser;
   NSMutableArray *services;   

   NSInputStream  *istream;
   NSOutputStream *ostream;
}

@property (nonatomic, retain) NSMutableArray *services;
@property (nonatomic, retain) NSString *passcode;

- (void) setCurrent:(NumberLabel *) numberLabel;
- (IBAction) negotiateWithPeers;

@end