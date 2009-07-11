//
//  HotkeyHandler.m
//  PushPasteMac
//
//  Created by Motohiro Takayama on 7/11/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//
//  based on this article: http://cocoasamurai.blogspot.com/2009/03/global-keyboard-shortcuts-with-carbon.html
//

#import <Carbon/Carbon.h>
#import "HotkeyHandler.h"

OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData);

@implementation HotkeyHandler
@synthesize daemon;

- (void) setupHotkey
{
   EventHotKeyRef myHotKeyRef;
   EventHotKeyID myHotKeyID;   
   EventTypeSpec eventType;
   
   eventType.eventClass=kEventClassKeyboard;
   eventType.eventKind=kEventHotKeyPressed;
   
   InstallApplicationEventHandler(&myHotKeyHandler,1,&eventType,self,NULL);
   
   myHotKeyID.signature='mhk1';
   myHotKeyID.id=1;
   
   RegisterEventHotKey(49, cmdKey+optionKey, myHotKeyID, GetApplicationEventTarget(), 0, &myHotKeyRef);
}
@end

OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData)
{
   EventHotKeyID hkRef;
   GetEventParameter(anEvent,kEventParamDirectObject,typeEventHotKeyID,NULL,sizeof(hkRef),NULL,&hkRef);
   HotkeyHandler *hotkey_handler = (HotkeyHandler *)userData;
   
   switch (hkRef.id) {
      case 1:
         // get clipboard text
         // send to iPhone
         [hotkey_handler.daemon trigger];
         break;
      default:
         NSLog(@"other events");
         break;
   }
   
   return noErr;
}