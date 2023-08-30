//
//  MTCollectionViewCell.m
//  metar
//
//  Created by 关山第一渣男 on 2023/8/7.
//

#import "MTShootResultCell.h"

// model
#import "MTShootModel.h"

@interface MTShootResultCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIButton *circleBtn;
@property (weak, nonatomic) IBOutlet UIView *coverView;

@end

@implementation MTShootResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupAppearance];
}

- (void)setShoot:(MTShootModel *)shoot {
    _shoot = shoot;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:shoot.thumbnail]];
    self.titleLabel.text = shoot.name;
    self.dateLabel.text = [NSString convertTimestampToDateString:[shoot.createTime doubleValue]];
    if ([shoot.status integerValue] == 1) {
        self.btn.hidden = NO;
        [self.btn setImage:[UIImage imageNamed:@"upload"] forState:UIControlStateNormal];
    } else if ([shoot.status integerValue] == 2) {
        self.btn.hidden = NO;
        [self.btn setImage:[UIImage imageNamed:@"uploading"] forState:UIControlStateNormal];
    } else if ([shoot.status integerValue] == 3) {
        self.btn.hidden = YES;
    }
    
    if (shoot.isEditing) {
        self.circleBtn.hidden = NO;
        if (shoot.isCanSelected) {
            self.coverView.hidden = YES;
            if (shoot.isSelected) {
                [self.circleBtn setImage:[UIImage imageNamed:@"circle_check"] forState:UIControlStateNormal];
                self.bgView.sui_borderColor = gHex(@"763DE5");
                self.bgView.sui_borderWidth = 2.0f;
            } else {
                [self.circleBtn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
                self.bgView.sui_borderColor = UIColor.whiteColor;
                self.bgView.sui_borderWidth = 0.0f;
            }
        } else {
            self.coverView.hidden = NO;
            self.coverView.alpha = 0.5;
            [self.circleBtn setImage:[UIImage imageNamed:@"circle_disable"] forState:UIControlStateNormal];
            self.bgView.sui_borderColor = UIColor.whiteColor;
            self.bgView.sui_borderWidth = 0.0f;
        }
    } else {
        self.circleBtn.hidden = YES;
        self.coverView.hidden = YES;
        self.bgView.sui_borderColor = UIColor.whiteColor;
        self.bgView.sui_borderWidth = 0.0f;
    }
}

- (IBAction)touchCircleBtn:(UIButton *)circleBtn {
    if (!self.shoot.isCanSelected) return;
    self.shoot.selected = !self.shoot.isSelected;
    if ([self.delegate respondsToSelector:@selector(shootResultCellSelectStateDidChanged:)]) {
        [self.delegate shootResultCellSelectStateDidChanged:self];
    }
}

- (void)setupAppearance {
    self.layer.cornerRadius = 8.0;
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowRadius = 4.0;
    self.layer.shadowOffset = CGSizeMake(0, 0);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = 8.0;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
}

@end
