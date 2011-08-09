//
//  GHAppDelegate.m
//  SampleProject
//
//  Created by Oliver Letterer on 09.08.11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "GHAppDelegate.h"
#import "SampleViewController.h"

@implementation GHAppDelegate
@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    SampleViewController *viewController = [[SampleViewController alloc] init];
    self.window.rootViewController = viewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
