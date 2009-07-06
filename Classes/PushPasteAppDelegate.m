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


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
