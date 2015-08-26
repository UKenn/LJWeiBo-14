//
//  LJAccountTool.h
//
//  LJWeiBo
//
//  Created by qianfeng on 15-7-16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LJAccount;

@interface LJAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+ (void)saveAccount:(LJAccount *)account;

/**
 *  返回存储的账号信息
 */
+ (LJAccount *)account;
@end
