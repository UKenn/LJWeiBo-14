//
//  PlusViewController.m
//  LJWeiBo
//
//  Created by qianfeng on 15-7-17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PlusViewController.h"

@interface PlusViewController()

@end

@implementation PlusViewController

+ (instancetype)plusWithButton
{
    return [[self alloc]initWithButton];
}

- (instancetype)initWithButton
{
    self = [super init];
    if (self) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 667-30, 375, 30);
        button.backgroundColor = [UIColor greenColor];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];

    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
}

- (void)buttonClick:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
