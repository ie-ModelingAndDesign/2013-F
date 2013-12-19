//
//  AppDelegate.m
//  daily
//
//  Created by Daisuke YOKOJI on 2013/12/07.
//  Copyright (c) 2013年 Daisuke YOKOJI. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize str;
@synthesize moji;
@synthesize read;
@synthesize readday;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
 
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    // UITabBarControllerのインスタンスを作ります
    UITabBarController *tabBarController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    
    // UITabBarControllerに管理させるUIViewControllerを作成します．
    // 今回は２つのUIViewControllerを管理してみましょう
    UIViewController *controller1 = [[Readdaily alloc] initWithNibName:nil bundle:nil];
    UIViewController *controller2 = [[Selectdays alloc] initWithNibName:nil bundle:nil];
    
    // UITabBarControllerに設定するための前準備です
    NSArray *controllers = [NSArray arrayWithObjects:[[UINavigationController alloc] initWithRootViewController:controller1], [[UINavigationController alloc] initWithRootViewController:controller2], nil];
    
    // UIViewControllerを設定します
    [tabBarController setViewControllers:controllers];
    
    // UITabBarControllerのタブのタイトルを設定しています
    NSArray *items = tabBarController.tabBar.items;
    [[items objectAtIndex:0] setTitle:@"view1"];
    [[items objectAtIndex:1] setTitle:@"view2"];
    
    // 起動後にはじめに表示するViewControllerに設定します
    self.window.rootViewController = tabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
     return YES;
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

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
