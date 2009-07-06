//
//  PushPasteAppDelegate.m
//  PushPaste
//
//  Created by Motohiro Takayama on 7/7/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

#import "PushPasteAppDelegate.h"
#import "PushPasteViewController.h"

@implementation PushPasteAppDelegate

@synthesize window;
@synthesize viewController;

- (void) loadSetting
{
   
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   // if launched from APN
   //   show preview
   //   ask what app to kick
   //   kick that app or exit
   //
   // load setting
   // if initial execution
   //   show welcome screen
   //   ask password if not exist
   //   save password
   //   search for Mac app via Bonjour
   //   show guidance to launch Mac side app
   //   wait for Mac app to start
   //   recieve password from Mac app
   //   verify password
   //   send {ok:UUID or ng} to Mac app
   //   waiting for response
   //   show "OK" if recieved success
   //   put down initial flag
   //
   // regist to APN
   // [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];

   [window addSubview:viewController.view];
   [window makeKeyAndVisible];
}

- (void)dealloc
{
   [viewController release];
   [window release];
   [super dealloc];
}

@end