//
//  MTShootModel.m
//  metar
//
//  Created by 关山第一渣男 on 2023/8/7.
//

#import "MTShootModel.h"

@implementation MTShootModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
                @"ID" : @"id",
            };
}

@end
