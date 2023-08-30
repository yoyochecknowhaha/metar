//
//  FNConst.h
//  O2O
//
//  Created by FMC_iOS on 2018/4/18.
//  Copyright © 2018年 FMC_iOS. All rights reserved.
//  配置一些常量

#import <Foundation/Foundation.h>

/**************webView拦截跳转key*****************/

/**************第三方key*****************/


/**************接口数据返回状态*****************/
// 成功状态
UIKIT_EXTERN NSInteger const kSuccess;
// 失败状态
UIKIT_EXTERN NSInteger const kFailure;
// token过期
UIKIT_EXTERN NSInteger const kTokenExpired;

/**************用户偏好设置**************/
// 服务协议
UIKIT_EXTERN NSString *const kServiceKey;
// 隐私协议
UIKIT_EXTERN NSString *const kPrivateKey;
// accessToken
UIKIT_EXTERN NSString *const kAccessTokenKey;
// 查看过引导页标记
UIKIT_EXTERN NSString *const kDidViewGuideKey;
// AppState
UIKIT_EXTERN NSString *const kAppStateUserInfoKey;


/**************普通字符串常量**************/


/********************接口路径***********************/
// 获取验证码
UIKIT_EXTERN NSString *const kGetValidCodePath;
// 获取验证码
UIKIT_EXTERN NSString *const kGetServiceProtocolPath;
// 使用手机 + 验证码登录
UIKIT_EXTERN NSString *const kPhoneNumCodeLoginPath;
// 使用手机 + 密码登录
UIKIT_EXTERN NSString *const kPhoneNumPwdLoginPath;
// 获得基本信息
UIKIT_EXTERN NSString *const kGetUserInfoPath;
// 完善注册信息
UIKIT_EXTERN NSString *const kRegisterInfoPath;
// 忘记密码
UIKIT_EXTERN NSString *const kResetPwdPath;
// 登出系统
UIKIT_EXTERN NSString *const kLogoutPath;
// 获得拍摄结果分页
UIKIT_EXTERN NSString *const kShootResultPath;
// 批量删除拍摄结果
UIKIT_EXTERN NSString *const kDeleteShootResultsPath;
// 获取标定图
UIKIT_EXTERN NSString *const kPaperPath;


/********************通知***********************/
// 新增客户上传图片成功通知
UIKIT_EXTERN NSString *const kAppStateChangedNotification;


/************常用的宏************/

/**
 用户信息单例对象
 */
#define kUserInfo [MTUserInfoModel shareUserInfo]


