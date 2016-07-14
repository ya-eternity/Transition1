//
//  AppDelegate.m
//  Transition1
//
//  Created by bmxd-002 on 16/7/14.
//  Copyright © 2016年 bmxd-002. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureNavgationBar];
    return YES;
}

- (void)configureNavgationBar
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [UINavigationBar appearance].shadowImage = [UIImage new];
    [UINavigationBar appearance].translucent = YES;
    
    NSShadow *shadow = [NSShadow new];
    shadow.shadowOffset = CGSizeMake(0, 2);
    shadow.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    
    [UINavigationBar appearance].titleTextAttributes = @{
                                                         NSForegroundColorAttributeName:[UIColor whiteColor],
                                                         NSShadowAttributeName:shadow
                                                         };
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
