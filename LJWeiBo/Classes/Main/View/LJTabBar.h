//
//  LJTabBar.h
//  LJWeiBo
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJTabBar;
@protocol LJTabBarDelegate <NSObject>

//从选中的按钮跳转到需要跳转的按钮，通过两个tag值来进行
- (void)tabBar:(LJTabBar *)tabBar didSelectButtonFromIndex:(NSInteger)fromIdex toIndex:(NSInteger)toIndex;

@end

@interface LJTabBar : UIView
@property (nonatomic,weak)id <LJTabBarDelegate> delegate;
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
@end
