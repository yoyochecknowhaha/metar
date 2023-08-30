//
//  FNHudHelper.h
//  FengNiao
//
//  Created by 杨先豪 on 2019/7/30.
//  Copyright © 2019 bestone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNHudHelper : NSObject
/**
 在屏幕中部显示提示语
 */
+ (void)showMsgOnMiddle:(NSString *)tip;

@end

NS_ASSUME_NONNULL_END
