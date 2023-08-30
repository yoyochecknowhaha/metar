//
//  FNGetCodeView.h
//  FengNiao
//
//  Created by 杨先豪 on 2019/7/30.
//  Copyright © 2019 bestone. All rights reserved.
//

#import <UIKit/UIKit.h>

// data
#import "MTLoginData.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNGetCodeView : UIView

- (void)stopTimerWithTitle:(NSString *)title;
+ (instancetype)getCodeView;
@property (nonatomic, strong) UITextField *phoneNumberTF;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) MTValidCodeType codeType;
@property (nonatomic, assign, getter=isValidCheckBtnState) BOOL validCheckBtnState;
@property (nonatomic, assign, getter=isCheckBtnState) BOOL checkBtnState;

@end

NS_ASSUME_NONNULL_END
