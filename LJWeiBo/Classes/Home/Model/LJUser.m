//
//  LJUser.m
//  LJWeiBo
//
//  Created by qianfeng on 15-8-11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LJUser.h"

@implementation LJUser
+ (instancetype)userWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.idstr = dict[@"idstr"];
        self.name = dict[@"name"];
        self.profile_image_url = dict[@"profile_image_url"];
        // KVC :　会将字典的 所有 key-value(键值对) 赋值给模型对应的属性
        //        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
