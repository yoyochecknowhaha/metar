//
//  FNUserDefault.m
//  FengNiao
//
//  Created by 杨先豪 on 2019/8/1.
//  Copyright © 2019 bestone. All rights reserved.
//

#import "FNUserDefault.h"

@implementation FNUserDefault

+ (void)fn_setObject:(nullable id)value forKey:(NSString *)defaultName {
    [gUserDefaults setObject:value forKey:defaultName];
    [gUserDefaults synchronize];
}

+ (void)fn_setBool:(BOOL)value forKey:(NSString *)defaultName {
    [gUserDefaults setBool:value forKey:defaultName];
    [gUserDefaults synchronize];
}

+ (void)fn_setInteger:(NSInteger)value forKey:(NSString *)defaultName {
    [gUserDefaults setInteger:value forKey:defaultName];
    [gUserDefaults synchronize];
}

+ (void)fn_setFloat:(float)value forKey:(NSString *)defaultName {
    [gUserDefaults setFloat:value forKey:defaultName];
    [gUserDefaults synchronize];
}

+ (void)fn_setDouble:(double)value forKey:(NSString *)defaultName {
    [gUserDefaults setDouble:value forKey:defaultName];
    [gUserDefaults synchronize];
}

+ (nullable id)fn_objectForKey:(NSString *)defaultName {
    return [gUserDefaults objectForKey:defaultName];
}

+ (BOOL)fn_boolForKey:(NSString *)defaultName {
    return [gUserDefaults boolForKey:defaultName];
}

+ (NSInteger)fn_integerForKey:(NSString *)defaultName {
    return [gUserDefaults integerForKey:defaultName];
}

+ (float)fn_floatForKey:(NSString *)defaultName {
    return [gUserDefaults floatForKey:defaultName];
}

+ (double)fn_doubleForKey:(NSString *)defaultName {
    return [gUserDefaults doubleForKey:defaultName];
}

+ (nullable NSString *)fn_stringForKey:(NSString *)defaultName {
    return [gUserDefaults stringForKey:defaultName];
}

+ (nullable NSArray *)fn_arrayForKey:(NSString *)defaultName {
    return [gUserDefaults arrayForKey:defaultName];
}

+ (nullable NSDictionary<NSString *, id> *)fn_dictionaryForKey:(NSString *)defaultName {
    return [gUserDefaults dictionaryForKey:defaultName];
}

+ (nullable NSData *)fn_dataForKey:(NSString *)defaultName {
    return [gUserDefaults dataForKey:defaultName];
}

+ (nullable NSArray<NSString *> *)fn_stringArrayForKey:(NSString *)defaultName {
    return [gUserDefaults stringArrayForKey:defaultName];
}

@end
