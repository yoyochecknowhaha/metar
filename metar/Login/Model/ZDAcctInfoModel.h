//
//  ZDAcctInfoModel.h
//  ZhiDian
//
//  Created by 杨先豪 on 2020/3/10.
//  Copyright © 2020 bestone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDAcctInfoModel : NSObject <NSCoding>

/// 账号
@property (nonatomic, copy, readwrite) NSString *acct;
/// 密码
@property (nonatomic, copy, readwrite) NSString *pwd;

+ (instancetype)acctInfoWithAcct:(NSString *)acct pwd:(NSString *)pwd;

@end

NS_ASSUME_NONNULL_END
