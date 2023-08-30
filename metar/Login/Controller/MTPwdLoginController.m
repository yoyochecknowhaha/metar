//
//  MTPwdLoginController.m
//  metar
//
//  Created by 关山第一渣男 on 2023/7/30.
//

#import "MTPwdLoginController.h"

// controller
#import "MTCodeLoginController.h"
#import "ZDWebViewController.h"
#import "MTHomeController.h"
#import "MTRegisterInfoController.h"
#import "MTForgetPwdController.h"
#import "MTRegisterController.h"

// data
#import "MTLoginData.h"

@interface MTPwdLoginController () <MTHideNavigationBar>

@property (weak, nonatomic) IBOutlet UITextField *accTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *boxBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, copy, readwrite) NSString *serviceUrlString;
@property (nonatomic, copy, readwrite) NSString *privateUrlString;
@property (nonatomic, copy, readwrite) NSString *phoneNum;

@end

@implementation MTPwdLoginController

- (instancetype)initWithPhoneNum:(NSString *)phoneNum {
    if (self = [super init]) {
        self.phoneNum = phoneNum;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.accTF.text = self.phoneNum;
    
    [self.accTF addTarget:self action:@selector(textFieldTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.codeTF addTarget:self action:@selector(textFieldTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 请求服务隐私协议
    self.serviceUrlString = [FNUserDefault fn_objectForKey:kServiceKey];
    self.privateUrlString = [FNUserDefault fn_objectForKey:kPrivateKey];
    if (!self.serviceUrlString.length && !self.privateUrlString) {
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
}

- (void)textFieldTextDidChanged:(UITextField *)tf {
    self.loginBtn.enabled = self.accTF.text.length && self.codeTF.text.length;
}

- (IBAction)touchRegisterBtn:(UIButton *)registerBtn {
    [self.navigationController pushViewController:[[MTRegisterController alloc] init] animated:YES];
}

- (IBAction)touchEyeBtn:(UIButton *)eyeBtn {
    eyeBtn.selected = !eyeBtn.isSelected;
    self.codeTF.secureTextEntry = !eyeBtn.isSelected;
}

- (IBAction)touchForgetPwdBtn:(UIButton *)forgetPwdBtn {
    MTForgetPwdController *forgetPwdController = [[MTForgetPwdController alloc] init];
    [self.navigationController pushViewController:forgetPwdController animated:YES];
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
    [MTLoginData loginWithPhoneNum:self.accTF.text pwd:self.codeTF.text successBlock:^(NSInteger state, NSString *msg, id data) {
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

- (IBAction)touchCodeLoginBtn:(UIButton *)codeLoginBtn {
    gKeyWindow.rootViewController = [[MTNavigationController alloc] initWithRootViewController:[[MTCodeLoginController alloc] init]];
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
