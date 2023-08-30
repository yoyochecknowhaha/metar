//
//  FMCStatusHelper.h
//  O2O
//
//  Created by FMC_iOS on 2018/4/17.
//  Copyright © 2018年 FMC_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, App_Status) {
    App_Status_Develop,     //测试版本
    App_Status_Product,     //发布版本
};

@interface FMCStatusHelper : NSObject

+ (App_Status)status;

@end
