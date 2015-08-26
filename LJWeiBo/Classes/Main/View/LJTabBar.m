//
//  LJTabBar.m
//  LJWeiBo
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LJTabBar.h"
#import "UIImage+LJ.h"
#import "LJTabBarButton.h"

@interface LJTabBar()
@property (nonatomic,strong)NSMutableArray *tabBarButtons;
@property (nonatomic,weak)LJTabBarButton *selectedButton;
@property (nonatomic,weak)UIButton *plusButton;

@end
@implementation LJTabBar

- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //如果小于ios7.0可以设置
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        
        //添加中间加号按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateNormal];
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        plusButton.tag = 100;
        [self addSubview:plusButton];
        self.plusButton = plusButton;
        
    }
    return self;
}


- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    //1 创建按钮
    LJTabBarButton *button = [[LJTabBarButton alloc]init];
    [self addSubview:button];
    // 添加按钮到按钮数组中
    [self.tabBarButtons addObject:button];
    //2 设置按钮数据(item 实质是一个模型，封装数据使用setter方法来设置数据)
    button.item = item;
    //3 添加按钮点击事件
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    //4 进入默认选中第一个按钮
    if(self.tabBarButtons.count == 1)
    {
        [self buttonClick:button];
    }
    
    
}

- (void)buttonClick:(LJTabBarButton *)button
{
    //通知代理 （不能放在设置按钮状态之后写，因为，设置完按钮状态时，selected已经被重新复制）
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFromIndex:toIndex:)]) {
        [self.delegate tabBar:self didSelectButtonFromIndex:self.selectedButton.tag toIndex:button.tag];
    }
    //设置按钮状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

//布局子视图，因为这是个自定义的tabbar可能会有很多和按钮加进来
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置加号按钮的center
    self.plusButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height *0.5);
    
    //按钮frame数据
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width/self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    for (int index = 0 ;index <self.tabBarButtons.count; index ++)
    {
        //1 取出按钮
        LJTabBarButton *button = self.tabBarButtons[index];
        
        //2 设置frame
        CGFloat buttonX = index * buttonW;
        if (index >1) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //3 设置tag值()
        button.tag = index;
    }
}

@end
