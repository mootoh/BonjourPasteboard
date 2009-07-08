//
//  NumberLabel.h
//  PushPaste
//
//  Created by mootoh on 7/7/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

@class WelcomeViewController;

@interface NumberLabel : UILabel
{
   IBOutlet NumberLabel *next;
   NSString *number;
   BOOL selected;
   WelcomeViewController *welcomeViewController;
}

@property (nonatomic, assign) NumberLabel *next;
@property (nonatomic, retain) NSString *number;
@property (nonatomic) BOOL selected;
@property (nonatomic, retain) WelcomeViewController *welcomeViewController;

- (void) select;
- (void) deselect;

@end