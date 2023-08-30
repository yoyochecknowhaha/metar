//
//  MTPaperView.m
//  metar
//
//  Created by 关山第一渣男 on 2023/8/21.
//

#import "MTPaperView.h"

// data
#import "MTHomeData.h"

@interface MTPaperView () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, assign, getter=isDidSetupUI) BOOL didSetupUI;

@end

@implementation MTPaperView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.scrollView.delegate = self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.isDidSetupUI) return;
    [self setupUI];
}

- (void)setupUI {
    // 图片
    UIImageView *paper0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper0"]];
    [self.scrollView addSubview:paper0];
    [paper0 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.top);
        make.left.equalTo(self.scrollView.left);
        make.bottom.equalTo(self.scrollView.bottom);
        make.width.equalTo(self.bgView.width);
        make.height.equalTo(self.bgView.height);
    }];
    
    UIImageView *paper1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper1"]];
    [self.scrollView addSubview:paper1];
    [paper1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.top);
        make.left.equalTo(paper0.right);
        make.bottom.equalTo(self.scrollView.bottom);
        make.right.equalTo(self.scrollView.right);
        make.width.equalTo(self.bgView.width);
    }];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = 2;
    pageControl.currentPage = 0;
    [self.bgView addSubview:pageControl];
    [pageControl makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.centerX);
        make.bottom.equalTo(self.bgView.bottom).offset(-10);
    }];
    self.pageControl = pageControl;
    
    // 文字
    YYLabel *label = [[YYLabel alloc] init];
    label.numberOfLines = 0;
    [self addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.bottom).offset(20);
        make.left.equalTo(self.left).offset(20);
        make.right.equalTo(self.right).offset(-20);
        make.height.equalTo(@(80));
    }];
    NSMutableAttributedString *attStr0 = [[NSMutableAttributedString alloc] initWithString:@"请根据物体大小，选择合适尺寸的标定图进行打印，并放在物体的四周辅助拍摄，请尽量保持标定图贴近物体，确保每张拍摄的图片都包含部分标定图。"];
    attStr0.yy_font = [UIFont qmui_mediumSystemFontOfSize:16];
    attStr0.yy_color = UIColor.whiteColor;
    
    
    NSMutableAttributedString *attStr1 = [[NSMutableAttributedString alloc] initWithString:@"点击下载标定图"];
    attStr1.yy_font = [UIFont qmui_mediumSystemFontOfSize:16];
    attStr1.yy_color = gHex(@"22F1FF");
    [attStr1 yy_setTextHighlightRange:attStr1.yy_rangeOfAll color:nil backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [self requestPaper];
    }];
    [attStr0 appendAttributedString:attStr1];
    label.attributedText = attStr0;
    
    // 拍摄按钮
    UIButton *btn = [[UIButton alloc] init];
    [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    btn.sui_cornerRadius = 25;
    [btn setBackgroundColor:gHex(@"763DE5")];
    [btn setTitle:@"开始拍摄" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont qmui_mediumSystemFontOfSize:16];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self addSubview:btn];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.bottom).offset(20);
        make.left.equalTo(self.left).offset(20);
        make.right.equalTo(self.right).offset(-20);
        make.height.equalTo(@(50));
    }];
    
    self.didSetupUI = YES;
}

- (void)start {
    if ([self.delegate respondsToSelector:@selector(paperViewDidRemoved)]) {
        [self.delegate paperViewDidRemoved];
    }
    [self removeFromSuperview];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.sui_contentOffsetX / self.bgView.sui_width;
}

- (void)requestPaper {
    [MTHomeData getPaperSuccessBlock:^(NSInteger state, NSString *msg, NSArray *data) {
        NSString *url = [data[0] sui_stringForKey:@"url"];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url] options:@{} completionHandler:^(BOOL success) {
            
        }];
    }];
}

+ (instancetype)paperView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

@end
