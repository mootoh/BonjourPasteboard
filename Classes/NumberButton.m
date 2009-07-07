//
//  NumberButton.m
//  PushPaste
//
//  Created by mootoh on 7/7/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import "NumberButton.h"

@implementation NumberButton
@synthesize next, number;

- (id) initWithFrame:(CGRect) aRect
{
   if (self = [super initWithFrame:aRect]) {
      next = nil;
      NSLog(@"NumberButton init");
   }
   return self;
}

- (void) dealloc
{
   [super dealloc];
}

- (void) drawRect:(CGRect) aRect
{
   [super drawRect:aRect];
   NSLog(@"view did load");
   self.backgroundColor = [UIColor blackColor];
}

@end