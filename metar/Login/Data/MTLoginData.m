//
//  MTLoginData.m
//  metar
//
//  Created by 关山第一渣男 on 2023/7/26.
//

#import "MTLoginData.h"

// helper
#import "ZDAcctInfoHelper.h"

// model
#import "ZDAcctInfoModel.h"

@implementation MTLoginData

/// 获取验证码
+ (void)getValidCodeWithPhoneNumber:(NSString *)phoneNumber codeType:(MTValidCodeType)codeType successBlock:(requestSuccessBlock)successBlock failureBlock:(requestFailureBlock)failureBlock {
    FMCHttpHelper *helper = [[FMCHttpHelper alloc] init];
    NSString *url = [FMCURLHelper getURLWithPath:kGetValidCodePath];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = phoneNumber;
    params[@"scene"] = @(codeType);
    [helper post:url params:params isShowHud:YES success:^(NSInteger state, NSString *msg, id data) {
        successBlock(state, msg, data);
    } failure:^(NSInteger state, NSError *error, id cacheData) {
        failureBlock(state, error, cacheData);
    }];
}

/// 根据产品线类型和终端类型获得系统协议列表
+ (void)getServiceProtocolSuccessBlock:(requestSuccessBlock)successBlock {
    FMCHttpHelper *helper = [[FMCHttpHelper alloc] init];
    NSString *url = [FMCURLHelper getURLWithPath:kGetServiceProtocolPath];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"productLineType"] = @(1);
    params[@"terminalType"] = @(31);
    [helper get:url params:params isShowHud:YES success:^(NSInteger state, NSString *msg, id data) {
        successBlock(state, msg, data);
    } failure:^(NSInteger state, NSError *error, id cacheData) {
    }];
}

/// 使用手机 + 验证码登录
+ (void)loginWithPhoneNum:(NSString *)phoneNum code:(NSString *)code registeredCheck:(BOOL)registeredCheck successBlock:(requestSuccessBlock)successBlock {
    FMCHttpHelper *helper = [[FMCHttpHelper alloc] init];
    NSString *url = [FMCURLHelper getURLWithPath:kPhoneNumCodeLoginPath];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = phoneNum;
    params[@"code"] = code;
    if (registeredCheck) {
        params[@"needMobileRegisteredCheck"] = @"1";
    }
    [helper post:url params:params isShowHud:YES success:^(NSInteger state, NSString *msg, NSDictionary *data) {
        kUserInfo.accessToken = data[@"accessToken"];
        [FNUserDefault fn_setObject:data[@"accessToken"] forKey:kAccessTokenKey];
        successBlock(state, msg, data);
    } failure:^(NSInteger state, NSError *error, id cacheData) {
    }];
}

/// 使用手机 + 密码登录
+ (void)loginWithPhoneNum:(NSString *)phoneNum pwd:(NSString *)pwd successBlock:(requestSuccessBlock)successBlock {
    FMCHttpHelper *helper = [[FMCHttpHelper alloc] init];
    NSString *url = [FMCURLHelper getURLWithPath:kPhoneNumPwdLoginPath];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = phoneNum;
    params[@"password"] = pwd;
    [helper post:url params:params isShowHud:YES success:^(NSInteger state, NSString *msg, NSDictionary *data) {
        kUserInfo.accessToken = data[@"accessToken"];
        [FNUserDefault fn_setObject:data[@"accessToken"] forKey:kAccessTokenKey];
        successBlock(state, msg, data);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 子线程存储用户账号密码
            [ZDAcctInfoHelper saveAcctInfo:[ZDAcctInfoModel acctInfoWithAcct:phoneNum pwd:pwd]];
        });
    } failure:^(NSInteger state, NSError *error, id cacheData) {
    }];
}

/// 获得基本信息
+ (void)getUserInfoSuccessBlock:(requestSuccessBlock)successBlock {
    FMCHttpHelper *helper = [[FMCHttpHelper alloc] init];
    NSString *url = [FMCURLHelper getURLWithPath:kGetUserInfoPath];
    [helper get:url params:nil isShowHud:YES success:^(NSInteger state, NSString *msg, NSDictionary *data) {
        kUserInfo.ID = data[@"id"];
        kUserInfo.nickname = data[@"nickname"];
        kUserInfo.avatar = data[@"avatar"];
        kUserInfo.mobile = data[@"mobile"];
        kUserInfo.company = data[@"company"];
        kUserInfo.category = data[@"category"];
        kUserInfo.pwdFlag = data[@"pwdFlag"];
        kUserInfo.protocolFlag = data[@"protocolFlag"];
        successBlock(state, msg, data);
    } failure:^(NSInteger state, NSError *error, id cacheData) {
    }];
}

/// 完善注册信息
+ (void)registerInfoWithCompanyName:(NSString *)companyName cate:(NSString *)cate pwd0:(NSString *)pwd0 pwd1:(NSString *)pwd1 successBlock:(requestSuccessBlock)successBlock {
    FMCHttpHelper *helper = [[FMCHttpHelper alloc] init];
    NSString *url = [FMCURLHelper getURLWithPath:kRegisterInfoPath];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"company"] = companyName;
    params[@"category"] = cate;
    params[@"password"] = pwd0;
    params[@"confirmedPassword"] = pwd1;
    [helper put:url params:params isShowHud:YES success:^(NSInteger state, NSString *msg, id data) {
        successBlock(state, msg, data);
    } failure:^(NSInteger state, NSError *error, id cacheData) {
    }];
}

/// 忘记密码
+ (void)resetPwdWithPhoneNum:(NSString *)PhoneNum code:(NSString *)code pwd0:(NSString *)pwd0 pwd1:(NSString *)pwd1 successBlock:(requestSuccessBlock)successBlock {
    FMCHttpHelper *helper = [[FMCHttpHelper alloc] init];
    NSString *url = [FMCURLHelper getURLWithPath:kResetPwdPath];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = PhoneNum;
    params[@"code"] = code;
    params[@"password"] = pwd0;
    params[@"confirmedPassword"] = pwd1;
    [helper post:url params:params isShowHud:YES success:^(NSInteger state, NSString *msg, id data) {
        successBlock(state, msg, data);
    } failure:^(NSInteger state, NSError *error, id cacheData) {
    }];
}

/// 登出系统
+ (void)logoutSuccessBlock:(requestSuccessBlock)successBlock {
    FMCHttpHelper *helper = [[FMCHttpHelper alloc] init];
    NSString *url = [FMCURLHelper getURLWithPath:kLogoutPath];
    [helper post:url params:nil isShowHud:YES success:^(NSInteger state, NSString *msg, id data) {
        kUserInfo.userId = nil;
        kUserInfo.accessToken = nil;
        kUserInfo.expiresTime = nil;
        kUserInfo.refreshToken = nil;
        kUserInfo.ID = nil;
        kUserInfo.nickname = nil;
        kUserInfo.avatar = nil;
        kUserInfo.mobile = nil;
        kUserInfo.company = nil;
        kUserInfo.category = nil;
        kUserInfo.pwdFlag = nil;
        kUserInfo.protocolFlag = nil;
        successBlock(state, msg, data);
    } failure:^(NSInteger state, NSError *error, id cacheData) {
    }];
}

@end
