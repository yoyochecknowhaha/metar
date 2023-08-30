//
//  MTSettingController.m
//  metar
//
//  Created by 关山第一渣男 on 2023/8/8.
//

#import "MTSettingController.h"

// controller
#import "MTGuideController.h"
#import "MTCodeLoginController.h"

// data
#import "MTLoginData.h"

@interface MTSettingController () <MTHideNavigationBar>

@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@property (weak, nonatomic) IBOutlet UIView *guideBgView;

@end

@implementation MTSettingController

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.logoutBtn.sui_borderWidth = 1.0f;
    self.logoutBtn.sui_borderColor = gHex(@"763DE5");
    
    [MTLoginData getUserInfoSuccessBlock:^(NSInteger state, NSString *msg, id data) {
        self.companyLabel.text = kUserInfo.company;
        self.phoneLabel.text = kUserInfo.mobile;
    }];
    NSString *versionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *buildVersionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    self.versionLabel.text = [NSString stringWithFormat:@"METAR  V%@.%@", versionString, buildVersionString];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGuideView)];
    [self.guideBgView addGestureRecognizer:tap];
}

- (void)showGuideView {
    MTGuideController *guideController = [[MTGuideController alloc] initWithFromController:MTFromControllerTypeSettingController];
    [self.navigationController pushViewController:guideController animated:YES];
}

- (IBAction)touchLogoutBtn:(UIButton *)logoutBtn {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"您确认想退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action0];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self logout];
    }];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)logout {
    [MTLoginData logoutSuccessBlock:^(NSInteger state, NSString *msg, id data) {
        gKeyWindow.rootViewController = [[MTNavigationController alloc] initWithRootViewController:[[MTCodeLoginController alloc] init]];
    }];
}

- (IBAction)touchDismissBtn:(UIButton *)dismissBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
