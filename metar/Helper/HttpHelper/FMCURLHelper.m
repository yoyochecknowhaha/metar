//
//  FMCURLHelper.m
//  O2O
//
//  Created by FMC_iOS on 2018/4/17.
//  Copyright © 2018年 FMC_iOS. All rights reserved.
//

#import "FMCURLHelper.h"
#import "FMCStatusHelper.h"

@implementation FMCURLHelper

+ (NSString *)baseURL {
    if([FMCStatusHelper status] == App_Status_Develop) {
        return @"http://121.41.122.216:38180";
    } else {
        return @"https://zdtx123.com/";
    }
    
//    智店-测试环境
//    https://yuntest.zdtx123.com/
//
//
//    智店-生产环境
//    https://www.zdtx123.com/
//
//
//    智店-生产环境(内测)
//    https://www.zdtx123.com/canary/
    
}

+ (NSString *)getURLWithPath:(NSString *)path {
    return [NSString stringWithFormat:@"%@%@",[self baseURL], path];
}
@end
