//
//  LJStatus.h
//  LJWeiBo
//
//  Created by qianfeng on 15-8-11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LJUser;
@interface LJStatus : NSObject

/**
 *  微博的内容(文字)
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博的创建时间
 */
@property (nonatomic,copy)NSString *created_at;
/**
 *  微博的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博的转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博的被赞数
 */
@property (nonatomic, assign) int attitudes_count;

/**
 *  微博的单张配图
 */
@property (nonatomic,copy)NSString *thumbnail_pic;

/**
 *  微博的作者
 */
@property (nonatomic, strong) LJUser *user;

/**
 *  被转发微博(也包含了上述可能的所有属性，所以是LJStatus类型)
 */
@property (nonatomic,strong)LJStatus *retweet_status;

+ (instancetype)statusWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
