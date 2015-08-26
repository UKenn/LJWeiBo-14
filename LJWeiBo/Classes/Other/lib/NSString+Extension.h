//
//  NSString+Extension.h
//  QQ聊天
//
//  Created by qianfeng on 15-7-4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**
 *  返回字符串所占尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
//[messageModel.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:textMaxSize]

- (NSString *)DocumentDir;
@end
