//
//  NumberButton.h
//  PushPaste
//
//  Created by mootoh on 7/7/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

@interface NumberButton : UIButton
{
   IBOutlet NumberButton *next;
   NSString *number;
}

@property (nonatomic, assign) NumberButton *next;
@property (nonatomic, retain) NSString *number;

@end