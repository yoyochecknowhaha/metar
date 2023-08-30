//
//  BSAnimationView.h
//  Boss
//
//  Created by 杨先豪 on 2021/8/20.
//  弹框动画基本类

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSAnimationView : UIView

- (void)showWithParentView:(UIView *)parentView;
- (void)animation;
- (void)touchCoverBtn;

@end

NS_ASSUME_NONNULL_END
