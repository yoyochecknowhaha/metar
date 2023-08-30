//
//  MTUserInfoModel.h
//  metar
//
//  Created by 关山第一渣男 on 2023/7/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTUserInfoModel : NSObject

singleH(UserInfo)

@property (nonatomic, copy, readwrite, nullable) NSString *userId;
@property (nonatomic, copy, readwrite, nullable) NSString *accessToken;
@property (nonatomic, copy, readwrite, nullable) NSString *expiresTime;
@property (nonatomic, copy, readwrite, nullable) NSString *refreshToken;
@property (nonatomic, copy, readwrite, nullable) NSString *ID;
@property (nonatomic, copy, readwrite, nullable) NSString *nickname;
@property (nonatomic, copy, readwrite, nullable) NSString *avatar;
@property (nonatomic, copy, readwrite, nullable) NSString *mobile;
@property (nonatomic, copy, readwrite, nullable) NSString *company;
@property (nonatomic, copy, readwrite, nullable) NSString *category;
@property (nonatomic, copy, readwrite, nullable) NSString *pwdFlag;
@property (nonatomic, copy, readwrite, nullable) NSString *protocolFlag;

@end

NS_ASSUME_NONNULL_END
