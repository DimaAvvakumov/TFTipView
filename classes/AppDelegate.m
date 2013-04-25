//
//  AppDelegate.m
//  TipView
//
//  Created by Dima Avvakumov on 25.04.13.
//  Copyright (c) 2013 Dima Avvakumov. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TFTipView.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // TFTipView settings
    NSMutableDictionary *preset = [NSMutableDictionary dictionaryWithCapacity: 10];
    [preset setObject:[UIColor whiteColor] forKey:TFTipViewParamTextColor];
    [preset setObject:@"{7.0, 6.0, 5.0, 6.0}" forKey:TFTipViewParamTextInsets];
    [preset setObject:[UIFont fontWithName:@"Arial" size:12.0] forKey:TFTipViewParamTextFont];
    [preset setObject:[NSNumber numberWithFloat:500.0] forKey:TFTipViewParamTextMaxWidth];
    [preset setObject:@"{14.0, 7.0}" forKey:TFTipViewParamArrowSize];
    [preset setObject:[NSNull null] forKey:TFTipViewParamTextShadowColor];
    [preset setObject:@"{0, 2}" forKey:TFTipViewParamTextShadowOffset];
    [preset setObject:[NSNumber numberWithFloat:2.0] forKey:TFTipViewParamTextShadowBlur];
    [preset setObject:[NSNumber numberWithFloat:5.0] forKey:TFTipViewParamCornerRadius];
    [preset setObject:[UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:0.75] forKey:TFTipViewParamBackgroundColor];
    [preset setObject:[NSNumber numberWithFloat:-4.0] forKey:TFTipViewParamVerticalOffset];
    [TFTipView setPreset: preset forStyle: TFTipViewStyleDefault];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
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
