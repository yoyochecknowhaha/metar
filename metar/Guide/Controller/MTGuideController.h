//
//  MTGuideController.h
//  metar
//
//  Created by 关山第一渣男 on 2023/7/24.
//

#import "MTBaseController.h"

typedef NS_ENUM(NSUInteger, MTFromControllerType) {
    MTFromControllerTypeLaunchScreenController,
    MTFromControllerTypeSettingController,
};

NS_ASSUME_NONNULL_BEGIN

@interface MTGuideController : MTBaseController

- (instancetype)initWithFromController:(MTFromControllerType)fromController;

@end

NS_ASSUME_NONNULL_END
