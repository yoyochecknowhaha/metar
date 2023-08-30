//
//  FNUserDefault.h
//  FengNiao
//
//  Created by 杨先豪 on 2019/8/1.
//  Copyright © 2019 bestone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNUserDefault : NSObject

+ (void)fn_setObject:(nullable id)value forKey:(NSString *)defaultName;

+ (void)fn_setBool:(BOOL)value forKey:(NSString *)defaultName;

+ (void)fn_setInteger:(NSInteger)value forKey:(NSString *)defaultName;

+ (void)fn_setFloat:(float)value forKey:(NSString *)defaultName;

+ (void)fn_setDouble:(double)value forKey:(NSString *)defaultName;

+ (nullable id)fn_objectForKey:(NSString *)defaultName;

+ (BOOL)fn_boolForKey:(NSString *)defaultName;

+ (NSInteger)fn_integerForKey:(NSString *)defaultName;

+ (float)fn_floatForKey:(NSString *)defaultName;

+ (double)fn_doubleForKey:(NSString *)defaultName;

+ (nullable NSString *)fn_stringForKey:(NSString *)defaultName;

+ (nullable NSArray *)fn_arrayForKey:(NSString *)defaultName;

+ (nullable NSDictionary<NSString *, id> *)fn_dictionaryForKey:(NSString *)defaultName;

+ (nullable NSData *)fn_dataForKey:(NSString *)defaultName;

+ (nullable NSArray<NSString *> *)fn_stringArrayForKey:(NSString *)defaultName;

@end

NS_ASSUME_NONNULL_END
