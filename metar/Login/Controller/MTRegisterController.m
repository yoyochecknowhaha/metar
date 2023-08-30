//
//  MTRegisterController.m
//  metar
//
//  Created by 关山第一渣男 on 2023/7/30.
//

#import "MTRegisterController.h"

// controller
#import "MTHomeController.h"
#import "MTRegisterInfoController.h"

// view
#import "FNGetCodeView.h"

@interface MTRegisterController () <MTHideNavigationBar>

@property (weak, nonatomic) IBOutlet UIView *codeBgView;
@property (weak, nonatomic) IBOutlet UITextField *accTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (nonatomic, weak) FNGetCodeView *getCodeView;

@end

@implementation MTRegisterController

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

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.getCodeView stopTimerWithTitle:@"获取验证码"];
}

- (void)textFieldTextDidChanged:(UITextField *)tf {
    self.registerBtn.enabled = self.accTF.text.length && self.codeTF.text.length;
}

- (IBAction)touchRegisterBtn:(UIButton *)sender {
    if (![self.accTF.text sui_validateMobile]) {
        [FNHudHelper showMsgOnMiddle:@"请输入正确的手机号"];
        return;
    }
    [MTLoginData loginWithPhoneNum:self.accTF.text code:self.codeTF.text registeredCheck:YES successBlock:^(NSInteger state, NSString *msg, id data) {
        [MTLoginData getUserInfoSuccessBlock:^(NSInteger state, NSString *msg, id data) {
            if ([kUserInfo.pwdFlag integerValue] == 1) {
                gKeyWindow.rootViewController = [[MTNavigationController alloc] initWithRootViewController:[[MTHomeController alloc] init]];
            } else {
                MTRegisterInfoController *registerInfoController = [[MTRegisterInfoController alloc] initWithPhoneNum:self.accTF.text canSkip:NO];
                [self.navigationController pushViewController:registerInfoController animated:YES];
            }
        }];
    }];
}

- (IBAction)touchLoginBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
