//
//  NumberLabel.h
//  PushPaste
//
//  Created by mootoh on 7/7/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

@interface NumberLabel : UILabel
{
   IBOutlet NumberLabel *next;
   NSString *number;
   BOOL selected;
}

@property (nonatomic, assign) NumberLabel *next;
@property (nonatomic, retain) NSString *number;
@property (nonatomic) BOOL selected;

@end