//
//  MTRegisterInfoController.m
//  metar
//
//  Created by 关山第一渣男 on 2023/7/30.
//

#import "MTRegisterInfoController.h"

// view
#import "MTHomeController.h"
#import "MTPwdLoginController.h"

// data
#import "MTLoginData.h"

@interface MTRegisterInfoController () <MTHideNavigationBar, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *companyTF;
@property (weak, nonatomic) IBOutlet UITextField *cateTF;
@property (weak, nonatomic) IBOutlet UITextField *pwd0TF;
@property (weak, nonatomic) IBOutlet UITextField *pwd1TF;
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (nonatomic, copy, readwrite) NSString *phoneNum;
@property (nonatomic, assign, getter=isCanSkip) BOOL canSkip;

@end

@implementation MTRegisterInfoController

- (instancetype)init {
    if (self = [super init]) {
        self.canSkip = YES;
    }
    return self;
}

- (instancetype)initWithPhoneNum:(NSString *)phoneNum canSkip:(BOOL)canSkip {
    if (self = [super init]) {
        self.phoneNum = phoneNum;
        self.canSkip = canSkip;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.skipBtn.hidden = !self.canSkip;
    self.backBtn.hidden = self.canSkip;
    
    [self.companyTF addTarget:self action:@selector(companyTFTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.cateTF addTarget:self action:@selector(cateTFTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd0TF addTarget:self action:@selector(pwdTFTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd1TF addTarget:self action:@selector(pwdTFTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (IBAction)touchBackBtn:(UIButton *)backBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)companyTFTextDidChanged:(UITextField *)tf {
    self.okBtn.enabled = self.companyTF.text.length && self.cateTF.text.length && self.pwd0TF.text.length && self.pwd1TF.text.length;
    if (tf.text.length > 32) {
        tf.text = [tf.text substringToIndex:32];
    }
}

- (void)cateTFTextDidChanged:(UITextField *)tf {
    self.okBtn.enabled = self.companyTF.text.length && self.cateTF.text.length && self.pwd0TF.text.length && self.pwd1TF.text.length;
    if (tf.text.length > 32) {
        tf.text = [tf.text substringToIndex:32];
    }
}

- (void)pwdTFTextDidChanged:(UITextField *)tf {
    self.okBtn.enabled = self.companyTF.text.length && self.cateTF.text.length && self.pwd0TF.text.length && self.pwd1TF.text.length;
    if (tf.text.length > 16) {
        tf.text = [tf.text substringToIndex:16];
        [FNHudHelper showMsgOnMiddle:@"密码不可以超过16位"];
    }
}

- (IBAction)touchSkipBtn:(UIButton *)skipBtn {
    gKeyWindow.rootViewController = [[MTNavigationController alloc] initWithRootViewController:[[MTHomeController alloc] init]];
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
    if (!self.companyTF.text.length) {
        [FNHudHelper showMsgOnMiddle:@"请输入公司名称!"];
        return;
    }
    if (!self.cateTF.text.length) {
        [FNHudHelper showMsgOnMiddle:@"请输入品类!"];
        return;
    }
    if (![self.pwd0TF.text isEqualToString:self.pwd1TF.text]) {
        [FNHudHelper showMsgOnMiddle:@"两次密码输入不一致，请重新输入!"];
        return;
    }
    if (![self.pwd0TF.text sui_isValidPassword]) {
        [FNHudHelper showMsgOnMiddle:@"请输入长度为8-16位，必须包含大小写字母、数字和特殊字符的密码!"];
        return;
    }
    if (![self.pwd1TF.text sui_isValidPassword]) {
        [FNHudHelper showMsgOnMiddle:@"请输入长度为8-16位，必须包含大小写字母、数字和特殊字符的密码!"];
        return;
    }
    [MTLoginData registerInfoWithCompanyName:self.companyTF.text cate:self.cateTF.text pwd0:self.pwd0TF.text pwd1:self.pwd1TF.text successBlock:^(NSInteger state, NSString *msg, id data) {
        gKeyWindow.rootViewController = [[MTNavigationController alloc] initWithRootViewController:[[MTPwdLoginController alloc] initWithPhoneNum:self.phoneNum]];
    }];
}


@end
