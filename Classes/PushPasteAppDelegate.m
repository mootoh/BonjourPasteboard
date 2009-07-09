//
//  PushPasteAppDelegate.m
//  PushPaste
//
//  Created by Motohiro Takayama on 7/7/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

#import "PushPasteAppDelegate.h"
#import "PushPasteViewController.h"
#import "WelcomeViewController.h"

#define PP_PASSWORD @"password"

@implementation PushPasteAppDelegate

@synthesize window, viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   // if launched from APN
   //   show preview
   //   ask what app to kick
   //   kick that app or exit

   // load password
   NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:PP_PASSWORD];
   // if initial execution
   if (password == nil) {
      //  ask password if not exist
      //  show welcome screen
      WelcomeViewController *welcome_view_controller = [[WelcomeViewController alloc] initWithNibName:@"WelcomeView" bundle:nil];
      [window addSubview:welcome_view_controller.view];
   }

   //
   // register to APN
   // [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];

   //[window addSubview:viewController.view];
   [window makeKeyAndVisible];
   return YES;
}

- (void)dealloc
{
   [viewController release];
   [window release];
   [super dealloc];
}

@end