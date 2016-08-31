//
//  AppDelegate.m
//  Study training
//
//  Created by Andrey on 7/9/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "AppDelegate.h"

#import "SAPViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = window;
    
    SAPViewController *controller = [SAPViewController new];
    
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
//    
//    window.rootViewController = navigationController;
    
    window.rootViewController = controller;
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    }

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    }

@end
