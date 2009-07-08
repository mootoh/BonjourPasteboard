//
//  NumberLabel.m
//  PushPaste
//
//  Created by mootoh on 7/7/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import "NumberLabel.h"

@implementation NumberLabel
@synthesize next, number, selected;

/*
- (id) initWithFrame:(CGRect) aRect
{
   if (self = [super initWithFrame:aRect]) {
      next = nil;
      selected = NO;
   }
   return self;
}
*/

- (void) dealloc
{
   if (number) [number release];
   [super dealloc];
}

- (void) drawRect:(CGRect) aRect
{
   [super drawRect:aRect];
   if (selected) {
      self.textColor = [UIColor whiteColor];
      self.backgroundColor = [UIColor blackColor];
   } else {
      self.textColor = [UIColor blackColor];
      self.backgroundColor = [UIColor blueColor];
   }
}

@end