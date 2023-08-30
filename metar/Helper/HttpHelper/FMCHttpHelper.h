//
//  FMCHttpHelper.h
//  O2O
//
//  Created by FMC_iOS on 2018/4/17.
//  Copyright © 2018年 FMC_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNSingle.h"

typedef void (^requestSuccessBlock)(NSInteger state, NSString *msg, id data);
typedef void (^requestFailureBlock)(NSInteger state, NSError *error, id cacheData);

@interface FMCHttpHelper : NSObject

singleH(HttpHelper)

@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (nonatomic, assign, getter=isNotShowHUD) BOOL notShowHUD;  // default is NO to mean that show HUD
@property (nonatomic, assign, getter=isNotAllowShowLoginController) BOOL notAllowShowLoginController;

+ (instancetype)request;
- (void)cancelRequest;
- (void)post:(NSString *)url params:(NSMutableDictionary *)params isShowHud:(BOOL)isShowHud success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler;
- (void)get:(NSString *)url params:(NSMutableDictionary *)params isShowHud:(BOOL)isShowHud success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler;
- (void)put:(NSString *)url params:(NSMutableDictionary *)params isShowHud:(BOOL)isShowHud success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler;
- (void)shanchu:(NSString *)url params:(NSMutableDictionary *)params isShowHud:(BOOL)isShowHud success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler;
- (void)uploadImages:(NSArray<UIImage *> *)images compressionQuality:(CGFloat)compressionQuality url:(NSString *)url params:(NSDictionary *)params isShowHud:(BOOL)isShowHud success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler;


//- (void)addToken;
//- (void)put:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler;
//- (void)delete:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler;
//- (void)patch:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler;

@end
