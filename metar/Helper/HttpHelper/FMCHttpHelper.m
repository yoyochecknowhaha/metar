//
//  FMCHttpHelper.m
//  O2O
//
//  Created by FMC_iOS on 2018/4/17.
//  Copyright © 2018年 FMC_iOS. All rights reserved.
//

#import "FMCHttpHelper.h"
// sdk
#import <MBProgressHUD.h>

typedef NS_ENUM(NSUInteger, HttpRequestType) {
    HttpRequestTypeGET = 0,
    HttpRequestTypePOST,
    HttpRequestTypePUT,
    HttpRequestTypeDELETE,
    HttpRequestTypePATCH
};

@interface FMCHttpHelper ()

@property (nonatomic, strong) NSMutableDictionary *hudDicts;

@end

@implementation FMCHttpHelper

singleM(HttpHelper)

- (NSMutableDictionary *)hudDicts {
    if (!_hudDicts) {
        _hudDicts = [NSMutableDictionary dictionary];
    }
    return _hudDicts;;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 5.f;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"1" forHTTPHeaderField:@"tenant-id"];
        NSString *accessToken = [FNUserDefault fn_objectForKey:kAccessTokenKey];
        if (kUserInfo.accessToken.length) {
            [requestSerializer setValue:kUserInfo.accessToken forHTTPHeaderField:@"Authorization"];
        } else if ([accessToken length]) {
            [requestSerializer setValue:accessToken forHTTPHeaderField:@"Authorization"];
        } else {
            [requestSerializer setValue:@"Bearer test1" forHTTPHeaderField:@"Authorization"];
        }
//        NSString *versionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//        NSString *buildString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//        [requestSerializer setValue:[NSString stringWithFormat:@"iPhone/%@.%@", versionString, buildString] forHTTPHeaderField:@"appverify"];
        _manager.requestSerializer = requestSerializer;
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableIndexSet *responseCodes = [NSMutableIndexSet indexSet];
        [responseCodes addIndex:200];
        [responseCodes addIndex:304];
        [responseCodes addIndex:800];
        responseSerializer.acceptableStatusCodes = responseCodes;
        [_manager setResponseSerializer:responseSerializer];
    }
    return _manager;
}

+ (instancetype)request {
    return [[self alloc] init];
}

- (void)cancelRequest {
    [self.manager.operationQueue cancelAllOperations];
}

- (void)get:(NSString *)url params:(NSMutableDictionary *)params isShowHud:(BOOL)isShowHud success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    if (isShowHud) {
        MBProgressHUD *hud = self.hudDicts[url];
        if (!hud) {
            hud = [MBProgressHUD showHUDAddedTo:gKeyWindow animated:YES];
            self.hudDicts[url] = hud;
        } else {
            hud.removeFromSuperViewOnHide = YES;
            [gKeyWindow addSubview:hud];
            [hud showAnimated:YES];
        }
    }
    [self requestMethod:HttpRequestTypeGET url:url params:params success:successHandler failure:failureHandler];
}

- (void)post:(NSString *)url params:(NSMutableDictionary *)params isShowHud:(BOOL)isShowHud success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    if (isShowHud) {
        MBProgressHUD *hud = self.hudDicts[url];
        if (!hud) {
            hud = [MBProgressHUD showHUDAddedTo:gKeyWindow animated:YES];
            self.hudDicts[url] = hud;
        } else {
            hud.removeFromSuperViewOnHide = YES;
            [gKeyWindow addSubview:hud];
            [hud showAnimated:YES];
        }
    }
    [self requestMethod:HttpRequestTypePOST url:url params:params success:successHandler failure:failureHandler];
}

- (void)put:(NSString *)url params:(NSMutableDictionary *)params isShowHud:(BOOL)isShowHud success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    if (isShowHud) {
        MBProgressHUD *hud = self.hudDicts[url];
        if (!hud) {
            hud = [MBProgressHUD showHUDAddedTo:gKeyWindow animated:YES];
            self.hudDicts[url] = hud;
        } else {
            hud.removeFromSuperViewOnHide = YES;
            [gKeyWindow addSubview:hud];
            [hud showAnimated:YES];
        }
    }
    [self requestMethod:HttpRequestTypePUT url:url params:params success:successHandler failure:failureHandler];
}

- (void)shanchu:(NSString *)url params:(NSMutableDictionary *)params isShowHud:(BOOL)isShowHud success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    if (isShowHud) {
        MBProgressHUD *hud = self.hudDicts[url];
        if (!hud) {
            hud = [MBProgressHUD showHUDAddedTo:gKeyWindow animated:YES];
            self.hudDicts[url] = hud;
        } else {
            hud.removeFromSuperViewOnHide = YES;
            [gKeyWindow addSubview:hud];
            [hud showAnimated:YES];
        }
    }
    [self requestMethod:HttpRequestTypeDELETE url:url params:params success:successHandler failure:failureHandler];
}

- (void)uploadImages:(NSArray<UIImage *> *)images compressionQuality:(CGFloat)compressionQuality url:(NSString *)url params:(NSMutableDictionary *)params isShowHud:(BOOL)isShowHud success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    if (isShowHud) {
        MBProgressHUD *hud = self.hudDicts[url];
        if (!hud) {
            hud = [MBProgressHUD showHUDAddedTo:gKeyWindow animated:YES];
            self.hudDicts[url] = hud;
        } else {
            hud.removeFromSuperViewOnHide = YES;
            [gKeyWindow addSubview:hud];
            [hud showAnimated:YES];
        }
    }
    if (![url containsString:@".json"]) {
        NSString *token = @"token";
        NSString *versionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSString *buildString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        NSString *appverify = [NSString stringWithFormat:@"iPhone/%@.%@", versionString, buildString];
        url = [NSString stringWithFormat:@"%@%@token=%@&appverify=%@", url, [url sui_containsString:@"?"] ? @"&" : @"?", token, appverify];
    }
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接图片
        for (NSInteger i = 0; i < images.count; i++) {
            // 1. 将图片转成data
            NSData *imageData = UIImageJPEGRepresentation(images[i], compressionQuality);
            // 2. 生成字段名
            NSString *name = [NSString stringWithFormat:@"image%zd.jpg", i];
            // 3. 拼接参数
            [formData appendPartWithFileData:imageData name:@"file" fileName:name mimeType:@"image/jpeg"];
        }
    } error:nil];
    // 发送请求
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"image/png", @"text/text", nil];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [self.manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, NSData * _Nullable responseObject, NSError * _Nullable error) {
        if (isShowHud) {
            MBProgressHUD *hud = self.hudDicts[url];
            if (hud) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [hud hideAnimated:YES];
                });
            }
        }
        if (responseObject) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSInteger state = [jsonDict sui_integerForKey:@"retcode"];
            NSString *msg = [jsonDict sui_stringForKey:@"retmsg"];
            if (!error && (state == kSuccess)) {
                // 成功
                successHandler(state, msg, jsonDict);
            } else if (!error && (state != kSuccess)) {
                failureHandler(state, error, nil);
                if (isShowHud) {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:gKeyWindow animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text = msg;
                    hud.label.numberOfLines = 0;
                    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
                    [hud hideAnimated:YES afterDelay:0.1f * msg.length];
                }
            } else {
                // 失败
                failureHandler(state, error, nil);
                NSString *message = msg.length ? msg : @"亲，您的手机网络不给力哦！请稍后重试！";
                if (isShowHud) {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:gKeyWindow animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text = message;
                    hud.label.numberOfLines = 0;
                    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
                    [hud hideAnimated:YES afterDelay:0.15f * message.length];
                }
            }
        } else {
            failureHandler(error.code, error, nil);
            NSString *message = @"亲，您的手机网络不给力哦！请稍后重试！";
            if (isShowHud) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:gKeyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = message;
                hud.label.numberOfLines = 0;
                hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
                [hud hideAnimated:YES afterDelay:0.15f * message.length];
            }
        }
    }];
    [uploadTask resume];
}

- (void)requestMethod:(HttpRequestType)requestType url:(NSString *)url params:(NSMutableDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    NSString *rawUrl = url;
//    if (![url containsString:@".json"]) {
//        NSString *token = [FNUserDefault fn_stringForKey:kTokenKey];
//        NSString *versionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//        NSString *buildString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//        NSString *appverify = [NSString stringWithFormat:@"iPhone/%@.%@", versionString, buildString];
//        url = [NSString stringWithFormat:@"%@&token=%@&appverify=%@", url, token, appverify];
//    }
    NSLog(@"\nrequest:\nurl:%@\nparams:%@", url, params);
    NSString *accessToken = [FNUserDefault fn_objectForKey:kAccessTokenKey];
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    headers[@"tenant-id"] = @"1";
    if (kUserInfo.accessToken.length) {
        headers[@"Authorization"] = [NSString stringWithFormat:@"Bearer %@", kUserInfo.accessToken];
        NSLog(@"accessToken : %@", kUserInfo.accessToken)
    } else if (accessToken.length) {
        headers[@"Authorization"] = [NSString stringWithFormat:@"Bearer %@", accessToken];
        NSLog(@"accessToken : %@", accessToken)
    } else {
        headers[@"Authorization"] = @"Bearer test1";
    }
    switch (requestType) {
        case HttpRequestTypeGET: {
            [self.manager GET:url parameters:params headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self successWithUrl:rawUrl task:task responseObject:responseObject successHandler:successHandler failureHandler:failureHandler];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self failureWithUrl:rawUrl task:task error:error failureHandler:failureHandler];
            }];
            break;
        }
        case HttpRequestTypePOST: {
            [self.manager POST:url parameters:params headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self successWithUrl:rawUrl task:task responseObject:responseObject successHandler:successHandler failureHandler:failureHandler];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self failureWithUrl:rawUrl task:task error:error failureHandler:failureHandler];
            }];
            break;
        }
        case HttpRequestTypePUT: {
            [self.manager PUT:url parameters:params headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self successWithUrl:rawUrl task:task responseObject:responseObject successHandler:successHandler failureHandler:failureHandler];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self failureWithUrl:rawUrl task:task error:error failureHandler:failureHandler];
            }];
            break;
        }
        case HttpRequestTypeDELETE: {
            [self.manager DELETE:url parameters:params headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self successWithUrl:rawUrl task:task responseObject:responseObject successHandler:successHandler failureHandler:failureHandler];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self failureWithUrl:rawUrl task:task error:error failureHandler:failureHandler];
            }];
            break;
        }
        case HttpRequestTypePATCH: {
            [self.manager PATCH:url parameters:params headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self successWithUrl:rawUrl task:task responseObject:responseObject successHandler:successHandler failureHandler:failureHandler];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self failureWithUrl:rawUrl task:task error:error failureHandler:failureHandler];
            }];
            break;
        }
    }
}


#pragma mark - 成功处理
- (void)successWithUrl:(NSString *)url task:(NSURLSessionDataTask *)task responseObject:(id)responseObject successHandler:(requestSuccessBlock)successHandler failureHandler:(requestFailureBlock)failureHandler {
//    sleep(3);
    NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
    NSDictionary * headerFields = response.allHeaderFields;
    NSLog(@"\n****************\nurl:%@\nheaderFields = %@", response.URL, headerFields);
    NSThread *thread = [NSThread currentThread];
    if (![thread isMainThread]) {
        NSLog(@"successWithTask->**********网络回调不在主线程!**********");
    }
//    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)task.response;
//    NSInteger state = resp.statusCode;
    MBProgressHUD *hud = self.hudDicts[url];
    if (hud) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    }
    NSError *err = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&err];
    if (err) {
        NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString * str2 = [str stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        str2 = [str2 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        str2 = [str2 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonDict = [NSJSONSerialization JSONObjectWithData:[str2 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    }
    NSInteger state = [jsonDict sui_integerForKey:@"code"];
    NSString *msg = [jsonDict sui_stringForKey:@"msg"];
    id data = [jsonDict sui_objectForKey:@"data"];
    if (state == kSuccess) {
        successHandler(state, msg, data);
    } else {
        [FNHudHelper showMsgOnMiddle:msg];
        failureHandler(state, nil, nil);
    }
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // 数据缓存
//        [FNUserDefault fn_setObject:jsonDict forKey:url];
//    });
}

#pragma mark - 失败处理
- (void)failureWithUrl:(NSString *)url task:(NSURLSessionDataTask *)task error:(NSError *)error failureHandler:(requestFailureBlock)failureHandler {
    NSThread *thread = [NSThread currentThread];
    if (![thread isMainThread]) {
        NSLog(@"failureWithTask->**********网络回调不在主线程!**********");
    }
    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)task.response;
    NSInteger state = resp.statusCode;
//    id cacheData = [FNUserDefault fn_objectForKey:url];
//    failureHandler(state, error, cacheData);
    failureHandler(state, error, nil);
    MBProgressHUD *hud = self.hudDicts[url];
    [hud hideAnimated:YES];
    NSString *message = nil;
    if (state == 401) {
        message = @"登录已过期，请重新登录";
//        gKeyWindow.rootViewController = [[BSLoginController alloc] init];;
    } else {
        message = @"亲，您的手机网络不给力，或者系统正在升级中，请稍后重试。";
    }
    MBProgressHUD *newHud = [MBProgressHUD showHUDAddedTo:gKeyWindow animated:YES];
    newHud.mode = MBProgressHUDModeText;
    newHud.label.text = message;
    newHud.label.numberOfLines = 0;
    newHud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [newHud hideAnimated:YES afterDelay:0.15f * message.length];
}

@end
