//
//  LJAccount.h
//  LJWeiBo
//
//  Created by qianfeng on 15-7-16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface LJAccount : NSObject <NSCoding>
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, strong) NSDate *expiresTime; // 账号的过期时间
// 如果服务器返回的数字很大, 建议用long long(比如主键, ID)
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;


+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
