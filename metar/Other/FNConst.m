//
//  FNConst.m
//  O2O
//
//  Created by FMC_iOS on 2018/4/18.
//  Copyright © 2018年 FMC_iOS. All rights reserved.
//

#import "FNConst.h"

/**************webView拦截跳转key*****************/

/**************第三方key*****************/


/**************接口数据返回状态*****************/
// 成功状态
NSInteger const kSuccess = 0;
// 失败状态
NSInteger const kFailure = !kSuccess;
// token过期
NSInteger const kTokenExpired = -401;

/**************用户偏好设置**************/
// 服务协议
NSString *const kServiceKey = @"kServiceKey";
// 隐私协议
NSString *const kPrivateKey = @"kPrivateKey";
// accessToken
NSString *const kAccessTokenKey = @"kAccessTokenKey";
// 查看过引导页标记
NSString *const kDidViewGuideKey = @"kDidViewGuideKey";
// AppState
NSString *const kAppStateUserInfoKey = @"kAppStateUserInfoKey";


/**************普通字符串常量**************/


/********************接口路径*************************/
// 获取验证码
NSString *const kGetValidCodePath = @"/app-api/member/auth/send-sms-code";
// 获取验证码
NSString *const kGetServiceProtocolPath = @"/app-api/system/protocol/list-by-product-line-terminal-type";
// 使用手机 + 验证码登录
NSString *const kPhoneNumCodeLoginPath = @"/app-api/member/auth/sms-login";
// 使用手机 + 密码登录
NSString *const kPhoneNumPwdLoginPath = @"/app-api/member/auth/login";
// 获得基本信息
NSString *const kGetUserInfoPath = @"/app-api/member/user/get";
// 完善注册信息
NSString *const kRegisterInfoPath = @"/app-api/member/user/update-register-info";
// 忘记密码
NSString *const kResetPwdPath = @"/app-api/member/auth/forget-password";
// 登出系统
NSString *const kLogoutPath = @"/app-api/member/auth/logout";
// 获得拍摄结果分页
NSString *const kShootResultPath = @"/app-api/member/shoot-result/page";
// 批量删除拍摄结果
NSString *const kDeleteShootResultsPath = @"/app-api/member/shoot-result/delete-by-ids";
// 获取标定图
NSString *const kPaperPath = @"/app-api/system/calibration-chart/list-by-product-line-version";


/********************通知***********************/
NSString *const kAppStateChangedNotification = @"kAppStateChangedNotification";
