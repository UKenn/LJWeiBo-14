//
//  LJTabBarButton.m
//  LJWeiBo
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LJTabBarButton.h"
#import "UIImage+LJ.h"
#import "LJBadgeButton.h"

@interface LJTabBarButton ()
@property (nonatomic,weak)LJBadgeButton *badgeButton;

@end

@implementation LJTabBarButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置图片和文字居中，以防止拉伸
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //选中时橙色 248 139 0
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
//        [self setTitleColor:[UIColor colorWithRed:236/255.0 green:126/255.0 blue:0 alpha:1] forState:UIControlStateSelected];
        //如果小于ios7.0可以设置
//        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
        
        //设置提醒按钮
        LJBadgeButton *badgeButton = [[LJBadgeButton alloc]init];
        
        //自动跟随父视图变化位置，（我的位置在右上，就设置左下）
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}
//点中按钮，保持高亮状态
-(void)setHighlighted:(BOOL)highlighted
{
    
}

//设置按钮内部imageView的大小
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * 0.6);
}

//设置按钮内部label的大小
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height * 0.6, contentRect.size.width, contentRect.size.height * 0.4);
}

//设置按钮数据
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    //监听属性值
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

//销毁时自动调用，当item销毁不用时，需要移除监听器
- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}
//当监听的值改变时，会自动调用这个方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 1 设置文字
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    // 2 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    // 3 设置提醒数字 以及按钮的位置
    
    self.badgeButton.badgeValue = self.item.badgeValue;
    
    CGFloat badgeY = 0;
      
#warning (#‵′)！这里self.frame 为空,需要初始化时设置按钮的autoresizingMask，tabbarButton多大，提醒按钮会自动跟随父视图变化位置
    CGFloat badgeX =self.frame.size.width - self.badgeButton.frame.size.width - 10;
    CGRect badgeFrame = self.badgeButton.frame;
    badgeFrame.origin.x = badgeX;
    badgeFrame.origin.y = badgeY;
    self.badgeButton.frame = badgeFrame;
}
@end
