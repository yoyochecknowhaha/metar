//
//  MTPlaneScanningView.m
//  metar
//
//  Created by 关山第一渣男 on 2023/8/22.
//

#import "MTCoachingOverlayView.h"

@interface MTCoachingOverlayView ()

@property (weak, nonatomic) IBOutlet YYAnimatedImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *titleBgView;

@end

@implementation MTCoachingOverlayView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleBgView.hidden = YES;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    if (!imageName.length) return;
    self.imageView.image = [YYImage imageNamed:imageName];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleBgView.hidden = !title.length;
    self.titleLabel.text = title;
}

+ (instancetype)coachingOverlayView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

@end
