//
//  ZDAcctInfoHelper.m
//  ZhiDian
//
//  Created by 杨先豪 on 2020/3/11.
//  Copyright © 2020 bestone. All rights reserved.
//

#import "ZDAcctInfoHelper.h"

@implementation ZDAcctInfoHelper

/// 获取用户账号密码
+ (ZDAcctInfoModel *)acctInfo {
    NSLog(@"getAcctInfo-%@", [NSThread currentThread]);
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"accountInfo.data"];
    ZDAcctInfoModel *acctInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return acctInfo;
}

/// 存储用户账号密码
+ (void)saveAcctInfo:(ZDAcctInfoModel *)acctInfo {
    NSLog(@"saveAcctInfo-%@", [NSThread currentThread]);
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"accountInfo.data"];
    [NSKeyedArchiver archiveRootObject:acctInfo toFile:filePath];
}

+ (void)clearAcctInfo {
    [self saveAcctInfo:nil];
}

@end
