//
//  MTForgetPwdController.m
//  metar
//
//  Created by 关山第一渣男 on 2023/7/30.
//

#import "MTForgetPwdController.h"

// view
#import "FNGetCodeView.h"

// data
#import "MTLoginData.h"

@interface MTForgetPwdController () <MTHideNavigationBar>

@property (weak, nonatomic) IBOutlet UIView *codeBgView;
@property (weak, nonatomic) IBOutlet UITextField *accTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *pwd0TF;
@property (weak, nonatomic) IBOutlet UITextField *pwd1TF;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@property (nonatomic, weak) FNGetCodeView *getCodeView;

@end

@implementation MTForgetPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.accTF addTarget:self action:@selector(accTFTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.codeTF addTarget:self action:@selector(codeTFTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd0TF addTarget:self action:@selector(pwdTFTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd1TF addTarget:self action:@selector(pwdTFTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    FNGetCodeView *getCodeView = [FNGetCodeView getCodeView];
    getCodeView.codeType = MTValidCodeTypeForgetPwd;
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

- (IBAction)touchBackBtn:(UIButton *)backBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)accTFTextDidChanged:(UITextField *)tf {
    self.okBtn.enabled = self.accTF.text.length && self.codeTF.text.length && self.pwd0TF.text.length && self.pwd1TF.text.length;
}

- (void)codeTFTextDidChanged:(UITextField *)tf {
    self.okBtn.enabled = self.accTF.text.length && self.codeTF.text.length && self.pwd0TF.text.length && self.pwd1TF.text.length;
}

- (void)pwdTFTextDidChanged:(UITextField *)tf {
    self.okBtn.enabled = self.accTF.text.length && self.codeTF.text.length && self.pwd0TF.text.length && self.pwd1TF.text.length;
    if (tf.text.length > 16) {
        tf.text = [tf.text substringToIndex:16];
        [FNHudHelper showMsgOnMiddle:@"密码不可以超过16位"];
    }
}

- (IBAction)touchEye0Btn:(UIButton *)eye0Btn {
    eye0Btn.selected = !eye0Btn.isSelected;
    self.pwd0TF.secureTextEntry = !eye0Btn.isSelected;
}

- (IBAction)touchEye1Btn:(UIButton *)eye1Btn {
    eye1Btn.selected = !eye1Btn.isSelected;
    self.pwd1TF.secureTextEntry = !eye1Btn.isSelected;
}

- (IBAction)touchOKBtn:(UIButton *)okBtn {
    if (![self.accTF.text sui_validateMobile]) {
        [FNHudHelper showMsgOnMiddle:@"请输入正确手机号!"];
        return;
    }
    if (!self.codeTF.text.length) {
        [FNHudHelper showMsgOnMiddle:@"请输入验证码!"];
        return;
    }
    if (![self.pwd0TF.text isEqualToString:self.pwd1TF.text]) {
        [FNHudHelper showMsgOnMiddle:@"两次密码输入不一致，请重新输入!"];
        return;
    }
    if (![self.pwd0TF.text sui_isValidPassword]) {
        [FNHudHelper showMsgOnMiddle:@"密码长度为8-16位，必须包含大小写字母、数字和特殊字符!"];
        return;
    }
    if (![self.pwd1TF.text sui_isValidPassword]) {
        [FNHudHelper showMsgOnMiddle:@"密码长度为8-16位，必须包含大小写字母、数字和特殊字符!"];
        return;
    }
    [MTLoginData resetPwdWithPhoneNum:self.accTF.text code:self.codeTF.text pwd0:self.pwd0TF.text pwd1:self.pwd1TF.text successBlock:^(NSInteger state, NSString *msg, id data) {
        [FNHudHelper showMsgOnMiddle:@"重置完成"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
