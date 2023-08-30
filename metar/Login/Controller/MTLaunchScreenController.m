//
//  MTLaunchScreenController.m
//  metar
//
//  Created by 关山第一渣男 on 2023/7/31.
//

#import "MTLaunchScreenController.h"

// controller
#import "MTCodeLoginController.h"
#import "MTHomeController.h"
#import "MTGuideController.h"

// helper
#import "ZDAcctInfoHelper.h"

// model
#import "ZDAcctInfoModel.h"

// data
#import "MTLoginData.h"

@interface MTLaunchScreenController ()

@property (nonatomic, strong) ZDAcctInfoModel *acctInfo;

@end

@implementation MTLaunchScreenController

- (ZDAcctInfoModel *)acctInfo {
    if (!_acctInfo) {
        _acctInfo = [ZDAcctInfoHelper acctInfo];
    }
    return _acctInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    BOOL isDidViewGuide = [FNUserDefault fn_boolForKey:kDidViewGuideKey];
    if (isDidViewGuide) {
        if (self.acctInfo.acct.length && self.acctInfo.pwd.length && [FNUserDefault fn_stringForKey:kAccessTokenKey].length) {
            [MTLoginData loginWithPhoneNum:self.acctInfo.acct pwd:self.acctInfo.pwd successBlock:^(NSInteger state, NSString *msg, id data) {
                gKeyWindow.rootViewController = [[MTNavigationController alloc] initWithRootViewController:[[MTHomeController alloc] init]];
            }];
        } else {
            gKeyWindow.rootViewController = [[MTNavigationController alloc] initWithRootViewController:[[MTCodeLoginController alloc] init]];
        }
    } else {
        gKeyWindow.rootViewController = [[MTNavigationController alloc] initWithRootViewController:[[MTGuideController alloc] initWithFromController:MTFromControllerTypeLaunchScreenController]];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
