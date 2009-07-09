//
//  PushPasteAppDelegate.h
//  PushPaste
//
//  Created by Motohiro Takayama on 7/7/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PushPasteViewController;

@interface PushPasteAppDelegate : NSObject <UIApplicationDelegate>
{
   UIWindow *window;
   PushPasteViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PushPasteViewController *viewController;

@end