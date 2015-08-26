//
//  LJWeiboTool.m
//  LJWeiBo
//
//  Created by qianfeng on 15-7-16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//


#import "LJWeiboTool.h"
#import "LJTabBarViewController.h"
#import "LJNewFeatureViewController.h"

@implementation LJWeiboTool
+ (void)chooseRootController
{
    NSString *key = @"CFBundleVersion";
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        // 显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        //设置主窗口的根视图控制器必须让主窗口先显示出来，这句[self.window makeKeyAndVisible];在AppDelegate 中要先写，否则跟视图控制器设置失败
        [UIApplication sharedApplication].keyWindow.rootViewController = [[LJTabBarViewController alloc] init];
    } else { // 新版本
        [UIApplication sharedApplication].keyWindow.rootViewController = [[LJNewFeatureViewController alloc] init];
        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}
@end
