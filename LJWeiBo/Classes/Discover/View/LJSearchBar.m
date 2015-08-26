//
//  LJSearchBar.m
//  LJWeiBo
//
//  Created by qianfeng on 15-7-16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LJSearchBar.h"
#import "UIImage+LJ.h"

@interface LJSearchBar()

@end

@implementation LJSearchBar

+ (instancetype)searchBar
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.background = [UIImage resizableImage:@"searchbar_textfield_background"];
        //创建一个左边的搜索图标imageView
        UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);

        //
        self.leftViewMode = UITextFieldViewModeAlways;
        self.font = [UIFont systemFontOfSize:12];
        self.placeholder = @"搜索";
        //清除小叉
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        //设置手机键盘的return key
        self.returnKeyType = UIReturnKeySearch;
        
        //设置没有输入文字时，回车键不能按
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.leftView.frame = CGRectMake(0, 0, 18, self.frame.size.height);
}
@end
