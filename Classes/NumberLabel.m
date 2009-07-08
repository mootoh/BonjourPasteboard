//
//  NumberLabel.m
//  PushPaste
//
//  Created by mootoh on 7/7/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import "NumberLabel.h"

@implementation NumberLabel
@synthesize next, number, selected, welcomeViewController;

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

- (void) select
{
   NSAssert(!selected, @"check flag");
   
   self.textColor = [UIColor blackColor];
   self.backgroundColor = [UIColor blueColor];
   selected = YES;
}

- (void) deselect
{
   NSAssert(selected, @"check flag");
   
   self.textColor = [UIColor whiteColor];
   self.backgroundColor = [UIColor blueColor];
   selected = NO;
}

/*
- (void) drawRect:(CGRect) aRect
{
   [super drawRect:aRect];
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   NSLog(@"touchesBegin");
   [welcomeViewController setCurrent:self];
}

@end