//
//  MTRegisterInfoController.h
//  metar
//
//  Created by 关山第一渣男 on 2023/7/30.
//

#import "MTBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTRegisterInfoController : MTBaseController

- (instancetype)initWithPhoneNum:(NSString *)phoneNum canSkip:(BOOL)canSkip;

@end

NS_ASSUME_NONNULL_END
