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
   NSLog(@"NumberButton init");

   if (self = [super initWithFrame:aRect]) {
      next = nil;
   }
   return self;
}

- (void) dealloc
{
   if (number) [number release];
   [super dealloc];
}

- (void) drawRect:(CGRect) aRect
{
   [super drawRect:aRect];
   NSLog(@"drawRect");
}

- (BOOL) becomeFirstResponder
{
   NSLog(@"become");
   return [super becomeFirstResponder];
}

@end