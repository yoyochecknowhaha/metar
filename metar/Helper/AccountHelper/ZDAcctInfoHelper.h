//
//  ZDAcctInfoHelper.h
//  ZhiDian
//
//  Created by 杨先豪 on 2020/3/11.
//  Copyright © 2020 bestone. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZDAcctInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZDAcctInfoHelper : NSObject

/// 获取用户账号密码
+ (ZDAcctInfoModel *)acctInfo;
/// 存储用户账号密码
+ (void)saveAcctInfo:(nullable ZDAcctInfoModel *)acctInfo;
/// 情况账号密码
+ (void)clearAcctInfo;

@end

NS_ASSUME_NONNULL_END
