//
//  UIBarButtonItem+LJ.h
//  LJWeiBo
//
//  Created by qianfeng on 15-7-16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LJ)
/**
 *  快速创建一个BarButtonItem
 * @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon  target:self action:(SEL)action;
@end
