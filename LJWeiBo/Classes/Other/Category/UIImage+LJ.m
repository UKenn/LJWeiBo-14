//
//  UIImage+MJ.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#endif

#import "UIImage+LJ.h"

@implementation UIImage (LJ)
+ (UIImage *)imageWithName:(NSString *)name
{
    if (iOS7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        if (image == nil) { // 没有_os7后缀的图片
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    
    // 非iOS7
    return [UIImage imageNamed:name];
}


+ (UIImage *)resizableImage:(NSString *)imageName
{
    UIImage *normal = [UIImage imageNamed:imageName];
    CGFloat width = normal.size.width * 0.5;
    CGFloat height = normal.size.height * 0.5;
    return  [normal resizableImageWithCapInsets:UIEdgeInsetsMake(height,width,height,width) resizingMode:UIImageResizingModeStretch];
}
@end
