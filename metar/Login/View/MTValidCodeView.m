//
//  MTValidCodeView.m
//  metar
//
//  Created by 关山第一渣男 on 2023/8/1.
//

#import "MTValidCodeView.h"

// view
#import "WMZCodeView.h"

@interface MTValidCodeView ()

@property (nonatomic, strong) WMZCodeView *codeView;

@end

@implementation MTValidCodeView

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.codeView) return;
    //使用方法
    uWeakSelf
    self.codeView = [[WMZCodeView shareInstance] addCodeViewWithType:CodeTypeImage withImageName:@"A" witgFrame:self.bounds withBlock:^(BOOL success) {
        if (success) {
            if ([weakSelf.delegate respondsToSelector:@selector(validCodeViewSuccess:)]) {
                [weakSelf.delegate validCodeViewSuccess:weakSelf];
                [weakSelf touchCoverBtn];
            }
        }
    }];
   [self addSubview:self.codeView];
}


- (void)showWithParentView:(UIView *)parentView {
    [super showWithParentView:parentView];
    [parentView addSubview:self];
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(parentView);
        make.left.equalTo(parentView.left).offset(15);
        make.right.equalTo(parentView.right).offset(-15);
        make.height.equalTo(@(360));
    }];
    [self layoutIfNeeded];
    [self animation];
}

+ (instancetype)validCodeView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

@end
