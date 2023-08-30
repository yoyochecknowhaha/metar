//
//  MTNavigationController.m
//  metar
//
//  Created by 关山第一渣男 on 2023/7/30.
//

#import "MTNavigationController.h"

@interface MTNavigationController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation MTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置代理
    self.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //如果控制器遵守了DLNoNav协议，则需要隐藏导航栏
    BOOL noNav = [[viewController class] conformsToProtocol:@protocol(MTHideNavigationBar)];
    
    //隐藏导航栏后会导致边缘右滑返回的手势失效，需要重新设置一下这个代理
    self.interactivePopGestureRecognizer.delegate = self;
    
    //设置控制器是否要隐藏导航栏
    [self setNavigationBarHidden:noNav animated:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.childViewControllers.count > 1;
}

@end
