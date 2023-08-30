//
//  MTGuideController.m
//  metar
//
//  Created by 关山第一渣男 on 2023/7/24.
//

#import "MTGuideController.h"

// controller
#import "MTCodeLoginController.h"

@interface MTGuideController () <UIScrollViewDelegate, MTHideNavigationBar>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, assign) MTFromControllerType fromController;

@end

@implementation MTGuideController

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (instancetype)initWithFromController:(MTFromControllerType)fromController {
    if (self = [super init]) {
        self.fromController = fromController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.scrollView.delegate = self;
    
    // 第1张图片
    UIImageView *imageView0 = [[YYAnimatedImageView alloc] initWithImage:[YYImage imageNamed:@"guide0.gif"]];
    [self.scrollView addSubview:imageView0];
    [imageView0 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.top);
        make.left.equalTo(self.scrollView.left);
//        make.right.equalTo(self.scrollView.right);
        make.bottom.equalTo(self.scrollView.bottom);
        make.width.equalTo(self.view.width);
        make.height.equalTo(self.view.height);
    }];

    UILabel *titleLabel0 = [[UILabel alloc] init];
    [imageView0 addSubview:titleLabel0];
    titleLabel0.text = @"调整拍摄环境灯光";
    titleLabel0.textColor = UIColor.whiteColor;
    titleLabel0.font = [UIFont boldSystemFontOfSize:20];
    [titleLabel0 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView0.top).offset(SCREEN_HEIGHT * 0.15);
        make.centerX.equalTo(imageView0.centerX);
    }];
    
    UILabel *tipLabel0 = [[UILabel alloc] init];
    [imageView0 addSubview:tipLabel0];
    tipLabel0.text = @"注意事项 1";
    tipLabel0.textColor = UIColor.whiteColor;
    tipLabel0.font = [UIFont systemFontOfSize:14];
    [tipLabel0 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imageView0.bottom).offset(-SCREEN_HEIGHT * 0.28);
        make.centerX.equalTo(imageView0.centerX);
    }];
    
    UIButton *btn00 = [[UIButton alloc] init];
    [imageView0 addSubview:btn00];
    btn00.userInteractionEnabled = NO;
    [btn00 setImage:[UIImage imageNamed:@"check_white"] forState:UIControlStateNormal];
    [btn00 setTitle:@"  确保环境灯光均匀充足，没有阴影遮挡" forState:UIControlStateNormal];
    btn00.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn00 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView0.centerX);
        make.top.equalTo(tipLabel0.bottom).offset(10);
    }];
    
    UIButton *btn01 = [[UIButton alloc] init];
    [imageView0 addSubview:btn01];
    btn01.userInteractionEnabled = NO;
    [btn01 setImage:[UIImage imageNamed:@"check_white"] forState:UIControlStateNormal];
    [btn01 setTitle:@"  拍摄背景与物品表面纹理不能太相近" forState:UIControlStateNormal];
    btn01.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn01 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn00.left);
        make.top.equalTo(btn00.bottom).offset(10);
    }];
    
    
    
    // 第2张图片
    UIImageView *imageView1 = [[YYAnimatedImageView alloc] initWithImage:[YYImage imageNamed:@"guide1.gif"]];
    [self.scrollView addSubview:imageView1];
    [imageView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView0.top);
        make.left.equalTo(imageView0.right);
//        make.right.equalTo(self.scrollView.right);
        make.bottom.equalTo(imageView0.bottom);
        make.width.equalTo(self.view.width);
    }];
    
    UILabel *titleLabel1 = [[UILabel alloc] init];
    [imageView1 addSubview:titleLabel1];
    titleLabel1.text = @"重建物品需符合规范";
    titleLabel1.textColor = UIColor.whiteColor;
    titleLabel1.font = [UIFont boldSystemFontOfSize:20];
    [titleLabel1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView1.top).offset(SCREEN_HEIGHT * 0.15);
        make.centerX.equalTo(imageView1.centerX);
    }];
    
    UILabel *tipLabel1 = [[UILabel alloc] init];
    [imageView1 addSubview:tipLabel1];
    tipLabel1.text = @"注意事项 2";
    tipLabel1.textColor = UIColor.whiteColor;
    tipLabel1.font = [UIFont systemFontOfSize:14];
    [tipLabel1 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imageView1.bottom).offset(-SCREEN_HEIGHT * 0.28);
        make.centerX.equalTo(imageView1.centerX);
    }];
    
    UIButton *btn10 = [[UIButton alloc] init];
    [imageView1 addSubview:btn10];
    btn10.userInteractionEnabled = NO;
    [btn10 setImage:[UIImage imageNamed:@"check_white"] forState:UIControlStateNormal];
    [btn10 setTitle:@"  拍摄的物品周身尽量没有反光的部位" forState:UIControlStateNormal];
    btn10.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn10 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView1.centerX);
        make.top.equalTo(tipLabel1.bottom).offset(10);
    }];
    
    UIButton *btn11 = [[UIButton alloc] init];
    [imageView1 addSubview:btn11];
    btn11.userInteractionEnabled = NO;
    [btn11 setImage:[UIImage imageNamed:@"check_white"] forState:UIControlStateNormal];
    [btn11 setTitle:@"  拍摄的物品周身尽量没有透明的部位" forState:UIControlStateNormal];
    btn11.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn11 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn10.left);
        make.top.equalTo(btn10.bottom).offset(10);
    }];
    
    
    
    // 第3张图片
    UIImageView *imageView2 = [[YYAnimatedImageView alloc] initWithImage:[YYImage imageNamed:@"guide2.gif"]];
    [self.scrollView addSubview:imageView2];
    [imageView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView1.top);
        make.left.equalTo(imageView1.right);
//        make.right.equalTo(self.scrollView.right);
        make.bottom.equalTo(imageView1.bottom);
        make.width.equalTo(self.view.width);
    }];
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    [imageView2 addSubview:titleLabel2];
    titleLabel2.text = @"摆放标定物";
    titleLabel2.textColor = UIColor.whiteColor;
    titleLabel2.font = [UIFont boldSystemFontOfSize:20];
    [titleLabel2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView2.top).offset(SCREEN_HEIGHT * 0.15);
        make.centerX.equalTo(imageView2.centerX);
    }];
    
    UILabel *tipLabel2 = [[UILabel alloc] init];
    [imageView2 addSubview:tipLabel2];
    tipLabel2.text = @"使用步骤 1";
    tipLabel2.textColor = UIColor.whiteColor;
    tipLabel2.font = [UIFont systemFontOfSize:14];
    [tipLabel2 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imageView2.bottom).offset(-SCREEN_HEIGHT * 0.28);
        make.centerX.equalTo(imageView2.centerX);
    }];
    
    UILabel *tipDetailLabel2 = [[UILabel alloc] init];
    [imageView2 addSubview:tipDetailLabel2];
    tipDetailLabel2.text = @"请打印标定图放在物品的四周辅助拍摄，请尽量保持标定图贴近物品，确保每张拍摄的图片都包含部分标定图。";
    tipDetailLabel2.numberOfLines = 0;
    tipDetailLabel2.textColor = UIColor.whiteColor;
    tipDetailLabel2.font = [UIFont systemFontOfSize:14];
    [tipDetailLabel2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView2.centerX);
        make.top.equalTo(tipLabel2.bottom).offset(10);
        make.left.equalTo(imageView2.left).offset(30);
        make.right.equalTo(imageView2.right).offset(-30);
    }];
    
    
    
    // 第4张图片
    UIImageView *imageView3 = [[YYAnimatedImageView alloc] initWithImage:[YYImage imageNamed:@"guide3.gif"]];
    [self.scrollView addSubview:imageView3];
    [imageView3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView2.top);
        make.left.equalTo(imageView2.right);
//        make.right.equalTo(self.scrollView.right);
        make.bottom.equalTo(imageView2.bottom);
        make.width.equalTo(self.view.width);
    }];
    
    UILabel *titleLabel3 = [[UILabel alloc] init];
    [imageView3 addSubview:titleLabel3];
    titleLabel3.text = @"使用立体框架定位物品";
    titleLabel3.textColor = UIColor.whiteColor;
    titleLabel3.font = [UIFont boldSystemFontOfSize:20];
    [titleLabel3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView3.top).offset(SCREEN_HEIGHT * 0.15);
        make.centerX.equalTo(imageView3.centerX);
    }];
    
    UILabel *tipLabel3 = [[UILabel alloc] init];
    [imageView3 addSubview:tipLabel3];
    tipLabel3.text = @"使用步骤 2";
    tipLabel3.textColor = UIColor.whiteColor;
    tipLabel3.font = [UIFont systemFontOfSize:14];
    [tipLabel3 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imageView3.bottom).offset(-SCREEN_HEIGHT * 0.28);
        make.centerX.equalTo(imageView3.centerX);
    }];
    
    UILabel *tipDetailLabel3 = [[UILabel alloc] init];
    [imageView3 addSubview:tipDetailLabel3];
    tipDetailLabel3.text = @"调整立体框架尺寸将物品包围其中，可以拖拽框架四周的控制点拉伸它的尺寸，也可以拖拽量尺控制旋转和位移。";
    tipDetailLabel3.numberOfLines = 0;
    tipDetailLabel3.textColor = UIColor.whiteColor;
    tipDetailLabel3.font = [UIFont systemFontOfSize:14];
    [tipDetailLabel3 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView3.centerX);
        make.top.equalTo(tipLabel3.bottom).offset(10);
        make.left.equalTo(imageView3.left).offset(30);
        make.right.equalTo(imageView3.right).offset(-30);
    }];
    
    
    
    // 第5张图片
    UIImageView *imageView4 = [[YYAnimatedImageView alloc] initWithImage:[YYImage imageNamed:@"guide4.gif"]];
    [self.scrollView addSubview:imageView4];
    [imageView4 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView3.top);
        make.left.equalTo(imageView3.right);
//        make.right.equalTo(self.scrollView.right);
        make.bottom.equalTo(imageView3.bottom);
        make.width.equalTo(self.view.width);
    }];
    
    UILabel *titleLabel4 = [[UILabel alloc] init];
    [imageView4 addSubview:titleLabel4];
    titleLabel4.text = @"拍摄物品";
    titleLabel4.textColor = UIColor.whiteColor;
    titleLabel4.font = [UIFont boldSystemFontOfSize:20];
    [titleLabel4 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView4.top).offset(SCREEN_HEIGHT * 0.15);
        make.centerX.equalTo(imageView4.centerX);
    }];
    
    UILabel *tipLabel4 = [[UILabel alloc] init];
    [imageView4 addSubview:tipLabel4];
    tipLabel4.text = @"使用步骤 3";
    tipLabel4.textColor = UIColor.whiteColor;
    tipLabel4.font = [UIFont systemFontOfSize:14];
    [tipLabel4 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imageView4.bottom).offset(-SCREEN_HEIGHT * 0.28);
        make.centerX.equalTo(imageView4.centerX);
    }];
    
    UILabel *tipDetailLabel4 = [[UILabel alloc] init];
    [imageView4 addSubview:tipDetailLabel4];
    tipDetailLabel4.text = @"围绕商品拍3圈，每圈拍摄商品侧面的上、中、下三个部分，拍摄中尽量保持物品在手机画面中心位置，并始终确保完整拍摄整个物品。";
    tipDetailLabel4.numberOfLines = 0;
    tipDetailLabel4.textColor = UIColor.whiteColor;
    tipDetailLabel4.font = [UIFont systemFontOfSize:14];
    [tipDetailLabel4 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView4.centerX);
        make.top.equalTo(tipLabel4.bottom).offset(10);
        make.left.equalTo(imageView4.left).offset(30);
        make.right.equalTo(imageView4.right).offset(-30);
    }];
    
    
    
    // 第6张图片
    UIImageView *imageView5 = [[YYAnimatedImageView alloc] initWithImage:[YYImage imageNamed:@"guide5.gif"]];
    [self.scrollView addSubview:imageView5];
    [imageView5 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView4.top);
        make.left.equalTo(imageView4.right);
        make.right.equalTo(self.scrollView.right);
        make.bottom.equalTo(imageView4.bottom);
        make.width.equalTo(self.view.width);
    }];
    
    UILabel *titleLabel5 = [[UILabel alloc] init];
    [imageView5 addSubview:titleLabel5];
    titleLabel5.text = @"上传建模";
    titleLabel5.textColor = UIColor.whiteColor;
    titleLabel5.font = [UIFont boldSystemFontOfSize:20];
    [titleLabel5 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView5.top).offset(SCREEN_HEIGHT * 0.15);
        make.centerX.equalTo(imageView5.centerX);
    }];
    
    UILabel *tipLabel5 = [[UILabel alloc] init];
    [imageView5 addSubview:tipLabel5];
    tipLabel5.text = @"使用步骤 4";
    tipLabel5.textColor = UIColor.whiteColor;
    tipLabel5.font = [UIFont systemFontOfSize:14];
    [tipLabel5 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imageView5.bottom).offset(-SCREEN_HEIGHT * 0.28);
        make.centerX.equalTo(imageView5.centerX);
    }];
    
    UILabel *tipDetailLabel5 = [[UILabel alloc] init];
    [imageView5 addSubview:tipDetailLabel5];
    tipDetailLabel5.text = @"拍摄完成后可上传结果进行建模，建模的同时可以拍摄其他的物品。";
    tipDetailLabel5.numberOfLines = 0;
    tipDetailLabel5.textColor = UIColor.whiteColor;
    tipDetailLabel5.font = [UIFont systemFontOfSize:14];
    [tipDetailLabel5 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView5.centerX);
        make.top.equalTo(tipLabel5.bottom).offset(10);
        make.left.equalTo(imageView5.left).offset(30);
        make.right.equalTo(imageView5.right).offset(-30);
    }];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = 6;
    pageControl.currentPage = 0;
    [self.view addSubview:pageControl];
    [pageControl makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.bottom.equalTo(self.view.bottom).offset(-50);
    }];
    self.pageControl = pageControl;
    
    UIButton *clearBtn = [[UIButton alloc] init];
    [clearBtn addTarget:self action:@selector(touchClearBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearBtn setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    [self.view addSubview:clearBtn];
    [clearBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(60);
        make.right.equalTo(self.view.right).offset(-20);
        make.width.equalTo(@(35));
        make.height.equalTo(@(35));
    }];
}

- (void)touchClearBtn {
    switch (self.fromController) {
        case MTFromControllerTypeLaunchScreenController:
            [FNUserDefault fn_setBool:YES forKey:kDidViewGuideKey];
            gKeyWindow.rootViewController = [[MTNavigationController alloc] initWithRootViewController:[[MTCodeLoginController alloc] init]];
            break;
        case MTFromControllerTypeSettingController:
            [self.navigationController popViewControllerAnimated:YES];
            break;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.sui_contentOffsetX / SCREEN_WIDTH;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    switch (self.fromController) {
        case MTFromControllerTypeLaunchScreenController:
            if (scrollView.sui_contentOffsetX > (SCREEN_WIDTH * 5 + 40)) {
                [FNUserDefault fn_setBool:YES forKey:kDidViewGuideKey];
                [self.navigationController pushViewController:[[MTCodeLoginController alloc] init] animated:YES];
            }
            break;
        case MTFromControllerTypeSettingController:
            // 啥事不做
            break;
    }
}


@end
