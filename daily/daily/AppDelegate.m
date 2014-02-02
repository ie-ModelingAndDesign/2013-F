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
@synthesize title;


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
    [[items objectAtIndex:0] setTitle:@"日記閲覧"];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.7 green:0.7 blue:1.0 alpha:0.8], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateSelected];


    [[items objectAtIndex:1] setTitle:@"日記作成"];
   
    UIImage *img_mae = [UIImage imageNamed:@"tab_background@2x.png"];  // リサイズ前UIImage
    UIImage *img_ato;  // リサイズ後UIImage
    CGFloat width = 320;  // リサイズ後幅のサイズ
    CGFloat height = 49;  // リサイズ後高さのサイズ
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [img_mae drawInRect:CGRectMake(0, 0, width, height)];
    img_ato = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [[UITabBar appearance] setBackgroundImage:img_ato];

    UIImage *img_mae1 = [UIImage imageNamed:@"tab_icon1-o@2x.png"];  // リサイズ前UIImage
    UIImage *img_ato1;  // リサイズ後UIImage
    UIImage *img_mae2 = [UIImage imageNamed:@"tab_icon1@2x.png"];  // リサイズ前UIImage
    UIImage *img_ato2;  // リサイズ後UIImage
    UIImage *img_mae3 = [UIImage imageNamed:@"tab_icon2-o@2x.png"];  // リサイズ前UIImage
    UIImage *img_ato3;  // リサイズ後UIImage
    UIImage *img_mae4 = [UIImage imageNamed:@"tab_icon2@2x.png"];  // リサイズ前UIImage
    UIImage *img_ato4;  // リサイズ後UIImage

    CGFloat width1 = 40;  // リサイズ後幅のサイズ
    CGFloat height1 = 30;  // リサイズ後高さのサイズ
    UIGraphicsBeginImageContext(CGSizeMake(width1, height1));
    [img_mae1 drawInRect:CGRectMake(0, 0, width1, height1)];
    img_ato1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(CGSizeMake(width1, height1));
    [img_mae2 drawInRect:CGRectMake(0, 0, width1, height1)];
    img_ato2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(CGSizeMake(width1, height1));
    [img_mae3 drawInRect:CGRectMake(0, 0, width1, height1)];
    img_ato3 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(CGSizeMake(width1, height1));
    [img_mae4 drawInRect:CGRectMake(0, 0, width1, height1)];
    img_ato4 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[items objectAtIndex:0] setFinishedSelectedImage:img_ato4 withFinishedUnselectedImage:img_ato3];
    
    [[items objectAtIndex:1] setFinishedSelectedImage:img_ato2 withFinishedUnselectedImage:img_ato1];
    
  
    
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
