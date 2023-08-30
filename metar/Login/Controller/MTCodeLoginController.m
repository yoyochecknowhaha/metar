//
//  MTLoginController.m
//  metar
//
//  Created by 关山第一渣男 on 2023/7/26.
//

#import "MTCodeLoginController.h"

// controller
#import "ZDWebViewController.h"
#import "MTRegisterInfoController.h"
#import "MTHomeController.h"
#import "MTPwdLoginController.h"
#import "MTRegisterController.h"

// view
#import "FNGetCodeView.h"

@interface MTCodeLoginController () <MTHideNavigationBar>

@property (weak, nonatomic) IBOutlet UIView *codeBgView;
@property (weak, nonatomic) IBOutlet UITextField *accTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *boxBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, weak) FNGetCodeView *getCodeView;

@property (nonatomic, copy, readwrite) NSString *serviceUrlString;
@property (nonatomic, copy, readwrite) NSString *privateUrlString;

@end

@implementation MTCodeLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.accTF addTarget:self action:@selector(textFieldTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.codeTF addTarget:self action:@selector(textFieldTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    FNGetCodeView *getCodeView = [FNGetCodeView getCodeView];
    getCodeView.codeType = MTValidCodeTypeLogin;
    getCodeView.phoneNumberTF = self.accTF;
    getCodeView.codeTF = self.codeTF;
    [self.codeBgView addSubview:getCodeView];
    self.getCodeView = getCodeView;
    [getCodeView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.codeBgView);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    // 请求服务隐私协议
    self.serviceUrlString = [FNUserDefault fn_objectForKey:kServiceKey];
    self.privateUrlString = [FNUserDefault fn_objectForKey:kPrivateKey];
    if (!self.serviceUrlString.length && !self.privateUrlString) {
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [self requestServiceProtocol];
                    break;
            }
        }];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)requestServiceProtocol {
    [MTLoginData getServiceProtocolSuccessBlock:^(NSInteger state, NSString *msg, NSArray *dataList) {
        for (NSDictionary *dict in dataList) {
            if ([dict[@"type"] integerValue] == 1) {
                self.serviceUrlString = dict[@"url"];
            } else if ([dict[@"type"] integerValue] == 2) {
                self.privateUrlString = dict[@"url"];
            }
        }
        [FNUserDefault fn_setObject:self.serviceUrlString forKey:kServiceKey];
        [FNUserDefault fn_setObject:self.privateUrlString forKey:kPrivateKey];
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.getCodeView stopTimerWithTitle:@"获取验证码"];
}

- (void)textFieldTextDidChanged:(UITextField *)tf {
    self.loginBtn.enabled = self.accTF.text.length && self.codeTF.text.length;
}

- (IBAction)touchRegisterBtn:(UIButton *)registerBtn {
    [self.navigationController pushViewController:[[MTRegisterController alloc] init] animated:YES];
}

- (IBAction)touchLoginBtn:(UIButton *)loginBtn {
    if (![self.accTF.text sui_validateMobile]) {
        [FNHudHelper showMsgOnMiddle:@"请输入正确的手机号"];
        return;
    }
    if (!self.boxBtn.isSelected) {
        [FNHudHelper showMsgOnMiddle:@"请先同意《服务协议》和《隐私政策》"];
        return;
    }
    [MTLoginData loginWithPhoneNum:self.accTF.text code:self.codeTF.text registeredCheck:NO successBlock:^(NSInteger state, NSString *msg, id data) {
        [MTLoginData getUserInfoSuccessBlock:^(NSInteger state, NSString *msg, id data) {
            if ([kUserInfo.pwdFlag integerValue] == 1) {
                gKeyWindow.rootViewController = [[MTNavigationController alloc] initWithRootViewController:[[MTHomeController alloc] init]];
            } else {
                MTRegisterInfoController *registerInfoController = [[MTRegisterInfoController alloc] init];
                [self.navigationController pushViewController:registerInfoController animated:YES];
            }
        }];
    }];
}

- (IBAction)touchPwdLoginBtn:(UIButton *)pwdLoginBtn {
    gKeyWindow.rootViewController = [[MTNavigationController alloc] initWithRootViewController:[[MTPwdLoginController alloc] init]];
}

- (IBAction)touchBoxBtn:(UIButton *)boxBtn {
    boxBtn.selected = !boxBtn.isSelected;
}

- (IBAction)touchServiceBtn:(UIButton *)serviceBtn {
    ZDWebViewController *webViewController = [[ZDWebViewController alloc] initWithUrlStr:self.serviceUrlString];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)touchPrivateBtn:(UIButton *)privateBtn {
    ZDWebViewController *webViewController = [[ZDWebViewController alloc] initWithUrlStr:self.privateUrlString];
    [self.navigationController pushViewController:webViewController animated:YES];
}



@end
