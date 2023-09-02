//
//  MTStep2View.m
//  metar
//
//  Created by 关山第一渣男 on 2023/8/21.
//

#import "MTStep2View.h"

@implementation MTStep2View

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

+ (instancetype)step2View {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

@end
