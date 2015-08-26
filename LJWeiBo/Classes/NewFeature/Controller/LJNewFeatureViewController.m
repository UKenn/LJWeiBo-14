//
//  LJNewFeatureViewController.m
//  LJWeiBo
//
//  Created by qianfeng on 15-7-16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LJNewFeatureViewController.h"
#import "LJTabBarViewController.h"
#import "UIImage+LJ.h"

@interface LJNewFeatureViewController()<UIScrollViewDelegate>
@property (nonatomic,weak)UIScrollView *scrollView;
@property (nonatomic,weak)UIPageControl *pageControl;
@end
@implementation LJNewFeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupScrollView];
    [self setupPageControl];
   
}

- (void)setupScrollView
{
    //0 添加一个背景图片
    //    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"new_feature_background"]];
    
    //1 创建一个滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    //2 创建滚动内容
    for (int index = 0; index < 3; index ++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",index + 1];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.frame = CGRectMake(scrollView.frame.size.width * index, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        [scrollView addSubview:imageView];
        // 在最后一个图片上面添加按钮
        if (index == 3 - 1) {
            [self setupLastImageView:imageView];
        }
    }
    //3 滚动范围
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    // 禁止回弹
    scrollView.bounces = NO;
    scrollView.delegate = self;
    self.scrollView = scrollView;
}

- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(155, 580, 60, 20)];
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor orangeColor];
    pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
}
/**
 *  添加内容到最后一个图片
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 0.让imageView能跟用户交互
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 2.设置frame
    CGFloat centerX = imageView.frame.size.width * 0.5;
    CGFloat centerY = imageView.frame.size.height * 0.6;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    
    // 3.设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    // 4.添加checkbox
    UIButton *checkbox = [[UIButton alloc] init];
    //默认打钩，便于推广产品
    checkbox.selected = YES;
    [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkbox.bounds = CGRectMake(0, 0, 200, 50);
    CGFloat checkboxCenterX = centerX;
    CGFloat checkboxCenterY = imageView.frame.size.height * 0.5;
    checkbox.center = CGPointMake(checkboxCenterX, checkboxCenterY);
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    //    checkbox.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    checkbox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    //    checkbox.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [imageView addSubview:checkbox];
}

/**
 *  开始微博
 */
- (void)start
{
    // 显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    // 切换窗口的根控制器
    self.view.window.rootViewController = [[LJTabBarViewController alloc] init];
}

- (void)checkboxClick:(UIButton *)checkbox
{
    checkbox.selected = !checkbox.isSelected;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x/scrollView.frame.size.width);
}
@end
