//
//  LJAccountTool.m
//  LJWeiBo
//
//  Created by qianfeng on 15-7-16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LJAccountTool.h"
#import "LJAccount.h"

#define LJAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"LJAccount.data"]

@implementation LJAccountTool
+ (void)saveAccount:(LJAccount *)account
{
    // 计算账号的过期时间
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    
    [NSKeyedArchiver archiveRootObject:account toFile:LJAccountFile];
}

+ (LJAccount *)account
{
    // 取出账号
    LJAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:LJAccountFile];
    
    // 判断账号是否过期
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresTime] == NSOrderedAscending) { // 还没有过期
        return account;
    } else { // 过期
        return nil;
    }
}
@end
