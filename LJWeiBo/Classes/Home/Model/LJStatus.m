//
//  LJStatus.m
//  LJWeiBo
//
//  Created by qianfeng on 15-8-11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LJStatus.h"
#import "LJUser.h"

@implementation LJStatus
+ (instancetype)statusWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.idstr = dict[@"idstr"];
        self.text = dict[@"text"];
        self.source = dict[@"source"];
        self.reposts_count = [dict[@"reposts_count"] intValue];
        self.comments_count = [dict[@"comments_count"] intValue];
        self.user = [LJUser userWithDict:dict[@"user"]];
    }
    return self;
}
@end
