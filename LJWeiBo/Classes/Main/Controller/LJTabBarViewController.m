//
//  LJTabBarViewController.m
//  LJWeiBo
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LJTabBarViewController.h"
#import "LJHomeViewController.h"
#import "LJMessageViewController.h"
#import "LJDiscoverViewController.h"
#import "LJNavigationController.h"
#import "LJMeViewController.h"
#import "UIImage+LJ.h"
#import "LJTabBar.h"

#import "PlusViewController.h"

@interface LJTabBarViewController ()<LJTabBarDelegate>
/**
 *  自定义的tabbar
 */
@property (nonatomic,weak)LJTabBar *customTabBar;

@end

@implementation LJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化tabbar
    [self setupTabBar];
    //初始化所有子控制器
    [self setupAllChildViewControllers];
    
    UIButton *plusButton = (UIButton *)[self.view viewWithTag:100];
    [plusButton addTarget:self action:@selector(plusAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)plusAction:(UIButton *)button
{
    NSLog(@"2343");
    PlusViewController *vc = [PlusViewController plusWithButton];
    vc.view.backgroundColor = [UIColor purpleColor];
    vc.view.center = CGPointMake(187.5, 667/2 + 667);
    [self presentViewController:vc animated:YES completion:^{
        [UIView animateWithDuration:1 animations:^{
            vc.view.center = CGPointMake(187.5, 667/2);
        }];
    }];
}

//
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSLog(@"%@",self.tabBar.subviews);
    for (UIView *child in self.tabBar.subviews) {
#warning 删除系统tabbarButton
        //自定义的tabbar是view  删除的是控件类型的，view不算？！
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
- (void)setupTabBar
{
    LJTabBar *customTabBar = [[LJTabBar alloc]init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar  = customTabBar;
    
}

#pragma mark 自定义tabbar的协议方法
/**
 *  监听tabbar的改变
 *
 *  @param tabBar   自定义的tabbar
 *  @param fromIdex 原来选中的按钮
 *  @param toIndex  将要跳转的按钮
 */
- (void)tabBar:(LJTabBar *)tabBar didSelectButtonFromIndex:(NSInteger)fromIdex toIndex:(NSInteger)toIndex
{
//    NSLog(@"%ld-- %ld",(long)fromIdex,(long)toIndex);
    //这个属性是选中的控制器编号
    self.selectedIndex = toIndex;
    
}
- (void)setupAllChildViewControllers
{
    //首页
    LJHomeViewController *home = [[LJHomeViewController alloc]init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    //消息
    LJMessageViewController *message = [[LJMessageViewController alloc]init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    //广场
    LJDiscoverViewController *discover = [[LJDiscoverViewController alloc]init];
    discover.tabBarItem.badgeValue = @"new";
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    //我
    LJMeViewController *me = [[LJMeViewController alloc]init];
    me.tabBarItem.badgeValue = @"5";
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}
//初始化控制器
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //相当于导航栏和标签栏都为这个标题
    //1 设置控制器属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    //2 设置选中的图片，并且除去渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageWithName:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //3 添加导航控制器
    LJNavigationController *childVcNav = [[LJNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:childVcNav];
    //4 添加tabbar按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

@end
