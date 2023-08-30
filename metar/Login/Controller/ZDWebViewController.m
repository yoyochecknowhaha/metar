//
//  ZDWebViewController.m
//  ZhiDian
//
//  Created by 杨先豪 on 2020/7/31.
//  Copyright © 2020 bestone. All rights reserved.
//

#import "ZDWebViewController.h"

// sdk
#import <WebKit/WebKit.h>

@interface ZDWebViewController ()<WKNavigationDelegate>

@property (nonatomic, weak) WKWebView *webView;

@property (nonatomic, copy, readwrite) NSString *urlStr;

@end

@implementation ZDWebViewController

- (instancetype)initWithUrlStr:(NSString *)urlStr {
    if (self = [super init]) {
        self.urlStr = urlStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupWebView];
}

- (void)setupWebView {
    WKWebView *webView = [[WKWebView alloc] init];
    [self.view addSubview:webView];
    [webView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.webView = webView;
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    //注入
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addUserScript:userScript];
    //创建网页配置对象
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = userContentController;
    // 创建设置对象
    WKPreferences *preference = [[WKPreferences alloc]init];
    //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
    preference.minimumFontSize = 10;
    //设置是否支持javaScript 默认是支持的
    preference.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
    preference.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preference;
    self.webView.scrollView.scrollEnabled = YES;
    self.webView.navigationDelegate = self;
//    NSString *path = [[NSBundle mainBundle] pathForResource:self.urlStr ofType:nil];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    [self.webView loadRequest:request];
}

@end
