//
//  AppDelegate.m
//  Study training
//
//  Created by Andrey on 7/9/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "AppDelegate.h"

#import "SAPCollectionViewController.h"

#import "UIWindow+SAPExtensions.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    
    UIColor *themeColor = [UIColor colorWithRed:0.01 green:0.41 blue:0.22 alpha:1.0];
    self.themeColor = themeColor;
    window.tintColor = themeColor;
    
    SAPCollectionViewController *controller = [SAPCollectionViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];

    window.rootViewController = navigationController;
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
