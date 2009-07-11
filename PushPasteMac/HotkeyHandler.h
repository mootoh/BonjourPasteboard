//
//  HotkeyHandler.h
//  PushPasteMac
//
//  Created by Motohiro Takayama on 7/11/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Daemon;

@interface HotkeyHandler : NSObject
{
   Daemon *daemon;
}

@property (nonatomic, retain) Daemon *daemon;

- (void) setupHotkey;

@end
