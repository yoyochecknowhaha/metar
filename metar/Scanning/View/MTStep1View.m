//
//  MTStep1View.m
//  metar
//
//  Created by 关山第一渣男 on 2023/8/21.
//

#import "MTStep1View.h"

@interface MTStep1View ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation MTStep1View

- (void)awakeFromNib {
    [super awakeFromNib];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"请将手机移动到物品的背面并保持十字准星对准物品的中心，然后点击屏幕确认。"];
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.000000]} range:NSMakeRange(0, 10)];
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:159/255.0 green:119/255.0 blue:236/255.0 alpha:1.000000]} range:NSMakeRange(10, 2)];
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.000000]} range:NSMakeRange(12, 24)];
    self.label.attributedText = string;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

+ (instancetype)step1View {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

@end
