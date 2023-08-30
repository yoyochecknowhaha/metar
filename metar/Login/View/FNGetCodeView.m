//
//  FNGetCodeView.m
//  FengNiao
//
//  Created by 杨先豪 on 2019/7/30.
//  Copyright © 2019 bestone. All rights reserved.
//

#import "FNGetCodeView.h"

// view
#import "MTValidCodeView.h"

@interface FNGetCodeView () <MTValidCodeViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation FNGetCodeView

- (void)dealloc {
    NSLog(@"%s", __func__);
    [gNotiCenter removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (instancetype)getCodeView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (IBAction)touchBtn {
    if (![self.phoneNumberTF.text sui_validateMobile]) {
        [FNHudHelper showMsgOnMiddle:@"请输入正确的手机号"];
        return;
    }
    MTValidCodeView *validCodeView = [MTValidCodeView validCodeView];
    validCodeView.delegate = self;
    [validCodeView showWithParentView:gKeyWindow];
}

#pragma mark - MTValidCodeViewDelegate
- (void)validCodeViewSuccess:(MTValidCodeView *)validCodeView {
    [self sendCode];
}

- (void)sendCode {
    if (self.isValidCheckBtnState) {
        if (self.checkBtnState) {
            [self getValidCode];
        } else {
            [FNHudHelper showMsgOnMiddle:@"请先同意《服务协议》和《隐私政策》"];
        }
    } else {
        [self getValidCode];
    }
}


- (void)getValidCode {
    if (![self.phoneNumberTF.text sui_validateMobile]) {
        [FNHudHelper showMsgOnMiddle:@"请输入正确的手机号"];
        return;
    }
    self.btn.enabled = NO;
    [MTLoginData getValidCodeWithPhoneNumber:self.phoneNumberTF.text codeType:self.codeType successBlock:^(NSInteger state, NSString *msg, id data) {
        if (state == kSuccess) {
            [FNHudHelper showMsgOnMiddle:@"验证码已发送"];
            [self.codeTF becomeFirstResponder];
            [self downCount];
        } else {
            [FNHudHelper showMsgOnMiddle:msg];
            self.btn.enabled = YES;
        }
    } failureBlock:^(NSInteger state, NSError *error, id cacheData) {
        self.btn.enabled = YES;
    }];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self.btn setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)downCount {
    __block NSInteger counter = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"downCount - %zd", counter);
        [self.btn setTitle:[NSString stringWithFormat:@"%zds后重新发送", counter] forState:UIControlStateNormal];
        if (counter == 0) {
            [self stopTimerWithTitle:@"重新获取"];
        }
        counter--;
    }];
}

- (void)stopTimerWithTitle:(NSString *)title {
    self.btn.enabled = YES;
    [self.timer invalidate];
    self.timer = nil;
    [self.btn setTitle:title forState:UIControlStateNormal];
}

@end
