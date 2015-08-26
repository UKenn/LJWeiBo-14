//
//  LJNavigationController.m
//  LJWeiBo
//
//  Created by qianfeng on 15-7-16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LJNavigationController.h"

@interface LJNavigationController ()

@end

@implementation LJNavigationController

/**
 *  第一次使用这个类的时候会调用（一个类只会调用一次）
 */
+(void)initialize
{
    //1 设置导航栏主题
    [self setupNavTheme];
    //2 设置导航栏按钮主题
    [self setupBarButtonItemtheme];
    
}
/**
 *  设置导航栏主题
 */
+ (void)setupNavTheme
{
    UINavigationBar *NavBar = [UINavigationBar appearance];
    //    if(!iOS7){
    //        [NavBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    //        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    //    }
    //设置标题属性
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:19];
    [NavBar setTitleTextAttributes:textAttributes];
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemtheme
{
     UIBarButtonItem *item = [UIBarButtonItem appearance];
    //设置背景
//    [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
//    [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    //设置文字
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttributes forState:UIControlStateHighlighted];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  只要push控制器，就隐藏底部标签栏， （拦截）
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
