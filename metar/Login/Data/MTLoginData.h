//
//  MTLoginData.h
//  metar
//
//  Created by 关山第一渣男 on 2023/7/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MTValidCodeType) {
    MTValidCodeTypeLogin = 1,       // 手机号登录(注册)
    MTValidCodeTypeForgetPwd,       // 忘记密码
    MTValidCodeTypeModifyPhoneNum,  // 修改手机号
    MTValidCodeTypeResetPwd         // 重置密码
};

@interface MTLoginData : NSObject

/// 获取验证码
+ (void)getValidCodeWithPhoneNumber:(NSString *)phoneNumber codeType:(MTValidCodeType)codeType successBlock:(requestSuccessBlock)successBlock failureBlock:(requestFailureBlock)failureBlock;

/// 根据产品线类型和终端类型获得系统协议列表
+ (void)getServiceProtocolSuccessBlock:(requestSuccessBlock)successBlock;

/// 使用手机 + 验证码登录
+ (void)loginWithPhoneNum:(NSString *)phoneNum code:(NSString *)code registeredCheck:(BOOL)registeredCheck successBlock:(requestSuccessBlock)successBlock;

/// 使用手机 + 密码登录
+ (void)loginWithPhoneNum:(NSString *)phoneNum pwd:(NSString *)pwd successBlock:(requestSuccessBlock)successBlock;

/// 获得基本信息
+ (void)getUserInfoSuccessBlock:(requestSuccessBlock)successBlock;

/// 完善注册信息
+ (void)registerInfoWithCompanyName:(NSString *)companyName cate:(NSString *)cate pwd0:(NSString *)pwd0 pwd1:(NSString *)pwd1 successBlock:(requestSuccessBlock)successBlock;

/// 忘记密码
+ (void)resetPwdWithPhoneNum:(NSString *)PhoneNum code:(NSString *)code pwd0:(NSString *)pwd0 pwd1:(NSString *)pwd1 successBlock:(requestSuccessBlock)successBlock;

/// 登出系统
+ (void)logoutSuccessBlock:(requestSuccessBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
