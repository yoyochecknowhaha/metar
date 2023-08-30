//
//  FNHudHelper.m
//  FengNiao
//
//  Created by 杨先豪 on 2019/7/30.
//  Copyright © 2019 bestone. All rights reserved.
//

#import "FNHudHelper.h"

// sdk
#import <MBProgressHUD.h>

@implementation FNHudHelper

/**
 在屏幕中部显示提示语
 */
+ (void)showMsgOnMiddle:(NSString *)tip {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:gKeyWindow animated:YES];
        hud.contentColor = UIColor.whiteColor;
        hud.bezelView.color = UIColor.blackColor;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.text = tip;
        hud.detailsLabel.font = gFont(16);
        [hud hideAnimated:YES afterDelay:3.f];
    });
}

@end
