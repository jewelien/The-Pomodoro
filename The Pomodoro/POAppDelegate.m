//
//  POAppDelegate.m
//  The Pomodoro
//
//  Created by Joshua Howland on 6/3/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POAppDelegate.h"
#import "TimerViewController.h"
#import "RoundsViewController.h"
#import "POTimer.h"
#import "POAppearanceController.h"

@implementation POAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    
    TimerViewController *timerViewController = [TimerViewController new];
    timerViewController.tabBarItem.title = @"Timer";
    timerViewController.tabBarItem.image = [UIImage imageNamed:@"timer"];

    
    [POTimer sharedInstance].minutes = 25;
    [POTimer sharedInstance].seconds = 0;
    
    [timerViewController updateTimerLabel];
    
    [POAppearanceController setupDefaultAppearance];
    
    RoundsViewController *roundsViewController = [RoundsViewController new];
    roundsViewController.tabBarItem.image = [UIImage imageNamed:@"rounds"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:roundsViewController];
    roundsViewController.title = @"Rounds";

    
    UITabBarController *tabBarController = [UITabBarController new];
    tabBarController.viewControllers = @[timerViewController, navController];
    self.window.rootViewController = tabBarController;
    
    

    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Round Finished!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Start Next Round" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[POTimer sharedInstance] startTimer];
    }]];
    
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil]];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
