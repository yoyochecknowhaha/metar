//
//  BSAnimationView.m
//  Boss
//
//  Created by 杨先豪 on 2021/8/20.
//

#import "BSAnimationView.h"

@interface BSAnimationView ()

@property (nonatomic, weak) UIButton *coverBtn;

@end

@implementation BSAnimationView

- (void)dealloc {
    NSLog(@"%s", __func__);
    [self.layer removeAllAnimations];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)animation {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 0.25;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.autoreverses = NO;
    //removedOnCompletion为NO保证app切换到后台动画再切回来时动画依然执行
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fromValue = @(0.0);
    scaleAnimation.toValue = @(1.0);
    [self.layer addAnimation:scaleAnimation forKey:@"scale-layer"];
}

- (void)showWithParentView:(UIView *)parentView {
    [self showCoverWithParentView:parentView];
}

- (void)showCoverWithParentView:(UIView *)parentView {
    UIButton *coverBtn = [[UIButton alloc] init];
    [coverBtn addTarget:self action:@selector(touchCoverBtn) forControlEvents:UIControlEventTouchUpInside];
    coverBtn.backgroundColor = [UIColor blackColor];
    coverBtn.alpha = 0.5f;
    [parentView addSubview:coverBtn];
    self.coverBtn = coverBtn;
    [coverBtn makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(parentView);
    }];
}

- (void)touchCoverBtn {
    [self.coverBtn removeFromSuperview];
    [self removeFromSuperview];
}

@end
