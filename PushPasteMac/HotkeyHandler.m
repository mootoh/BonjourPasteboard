//
//  HotkeyHandler.m
//  PushPasteMac
//
//  Created by Motohiro Takayama on 7/11/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import <Carbon/Carbon.h>
#import "HotkeyHandler.h"

OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData);

@implementation HotkeyHandler

+ (void) setupHotkey
{
   NSLog(@"setupHotkey");
   EventHotKeyRef myHotKeyRef;
   EventHotKeyID myHotKeyID;
   
   EventTypeSpec eventType;
   
   eventType.eventClass=kEventClassKeyboard;
   eventType.eventKind=kEventHotKeyPressed;

   InstallApplicationEventHandler(&myHotKeyHandler,1,&eventType,NULL,NULL);

   myHotKeyID.signature='mhk1';
   myHotKeyID.id=1;
   
   RegisterEventHotKey(49, cmdKey+optionKey, myHotKeyID, GetApplicationEventTarget(), 0, &myHotKeyRef);
}

@end

OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData)
{
   
   EventHotKeyID hkRef;   
   GetEventParameter(anEvent,kEventParamDirectObject,typeEventHotKeyID,NULL,sizeof(hkRef),NULL,&hkRef);
   
   switch (hkRef.id) {
       case 1:
          NSLog(@"Event 1 was triggered!");
          // get clipboard text
          NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
          
         // send to iPhone
         break;
      case 2:
         NSLog(@"Event 2 was triggered!");
         break;
   }

   return noErr;
}