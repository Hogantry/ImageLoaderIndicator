//
//  AppDelegate.m
//  ImageLoaderIndicator
//
//  Created by DFZ on 15/11/25.
//  Copyright © 2015年 DFZ. All rights reserved.
//

#import "AppDelegate.h"
#import "DFZMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 初始化跟控制器
    DFZMainViewController *mainVC = [[DFZMainViewController alloc] init];
    self.window.rootViewController = mainVC;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
