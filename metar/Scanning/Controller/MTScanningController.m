//
//  MTScanningController.m
//  metar
//
//  Created by 关山第一渣男 on 2023/8/21.
//

#import "MTScanningController.h"

// sdk
#import <ARKit/ARKit.h>

// view
#import "MTPaperView.h"
#import "MTStep0View.h"
#import "MTStep1View.h"
#import "MTStep2View.h"
#import "MTStep3View.h"
#import "MTCoachingOverlayView.h"

// model
#import "metar-Swift.h"

typedef NS_ENUM(NSUInteger, MTCoachingState) {
    MTCoachingStatePlane,       // 扫描平面提示
    MTCoachingStatePlaneEnd,    // 扫描平面提示完成
    MTCoachingStateScanning,    // 扫描物体提示
    MTCoachingStateScanningEnd  // 扫描物体提示完成
};

@interface MTScanningController () <MTPaperViewDelegate, ARSessionDelegate, ARSCNViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *stepBgView;
@property (weak, nonatomic) IBOutlet UILabel *plus;

@property (nonatomic, assign) MTCoachingState coachingState;
@property (nonatomic, weak) MTCoachingOverlayView *planeOverlayView;
@property (nonatomic, weak) MTCoachingOverlayView *scanningOverlayView;
@property (nonatomic, assign) ARTrackingState cameraTrackingState;
@property (nonatomic, weak) MTStep0View *step0View;

@end

@implementation MTScanningController

static MTScanningController *_instance = nil;

+ (MTScanningController *)instance {
    return _instance;
}

+ (void)setInstance:(MTScanningController *)instance {
    _instance = instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.state = MTStateStartARSession;
    
    // nav
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationItem.title = @"重建拍摄";
    NSDictionary *atts = @{
                           NSForegroundColorAttributeName:[UIColor whiteColor]
                           };
    [[UINavigationBar appearance] setTitleTextAttributes:atts];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"clear"] style:0 target:self action:@selector(clear)];
    
    // 定位paper
    MTPaperView *paperView = [MTPaperView paperView];
    paperView.delegate = self;
    [self.view addSubview:paperView];
    [paperView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(108);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.bottom.equalTo(self.view.bottom);
    }];
    
    // 底部文字提示
    MTStep3View *step3View = [MTStep3View step3View];
    [self.stepBgView addSubview:step3View];
    [step3View makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.stepBgView);
    }];
    
    MTStep2View *step2View = [MTStep2View step2View];
    [self.stepBgView addSubview:step2View];
    [step2View makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.stepBgView);
    }];
    
    MTStep1View *step1View = [MTStep1View step1View];
    [self.stepBgView addSubview:step1View];
    [step1View makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.stepBgView);
    }];
    
    MTStep0View *step0View = [MTStep0View step0View];
    [self.stepBgView addSubview:step0View];
    [step0View makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.stepBgView);
    }];
    self.step0View = step0View;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MTScanningController setInstance:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.sceneView.session pause];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.screenCenter = self.sceneView.center;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    switch (self.coachingState) {
        case MTCoachingStatePlane:
            // 不做处理
            break;
        case MTCoachingStatePlaneEnd:
            [self.step0View removeFromSuperview];
            [self showScanCoachingView];
            break;
        case MTCoachingStateScanning:
            // 不做处理
            break;
        case MTCoachingStateScanningEnd:
            // bounding box
            break;
    }
}

- (void)setState:(MTState)state {
    MTState newState = state;
    switch (state) {
        case MTStateStartARSession:
            break;
        case MTStateNotReady: {
            ARCamera *camera = self.sceneView.session.currentFrame.camera;
            if (camera) {
                switch (camera.trackingState) {
                    case ARTrackingStateNormal:
                        newState = MTStateScanning;
                        break;
                    default:
                        break;
                }
            } else {
                newState = MTStateStartARSession;
            }
            break;
        }
        case MTStateScanning: {
            ARCamera *camera = self.sceneView.session.currentFrame.camera;
            if (camera) {
                switch (camera.trackingState) {
                    case ARTrackingStateNormal:
                        break;
                    default:
                        newState = MTStateNotReady;
                        break;
                }
            } else {
                newState = MTStateStartARSession;
            }
            break;
        }
        case MTStateTesting:
            
            break;
    }
    
    switch (newState) {
        case MTStateStartARSession:
            NSLog(@"State: Starting ARSession")
            self.scan = nil;
            self.sceneView.scene = [SCNScene new];
            [self startScanning];
            break;
        case MTStateNotReady:
            NSLog(@"State: Not ready to scan")
            self.scan = nil;
            break;
        case MTStateScanning: {
            NSLog(@"State: Scanning")
            if (self.scan == nil) {
                self.scan = [[MTScan alloc] init:self.sceneView];
//                self.scan
            }
            break;
        }
        case MTStateTesting:
            <#code#>
            break;
    }
}

#pragma mark - MTPaperViewDelegate
- (void)paperViewDidRemoved {
    [self startScanning];
    [self showPlaneCoachingView];
//    NSString *mediaType = AVMediaTypeVideo;
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
//    switch (authStatus) {
//        case AVAuthorizationStatusNotDetermined:
//            [self requestAuthorization];
//            break;
//        case AVAuthorizationStatusRestricted:
//        case AVAuthorizationStatusDenied:
//            [self openAuthorization];
//            break;
//        case AVAuthorizationStatusAuthorized:
//            [self startScanning];
//            break;
//    }
}

- (void)requestAuthorization {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                
            } else {
                
            }
        });
    }];
}

- (void)openAuthorization {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication]canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)startScanning {
    ARObjectScanningConfiguration *config = [[ARObjectScanningConfiguration alloc] init];
    config.planeDetection = ARPlaneDetectionHorizontal;
    [self.sceneView.session runWithConfiguration:config];
    self.sceneView.session.delegate = self;
    self.sceneView.delegate = self;
}

- (void)showPlaneCoachingView {
    self.coachingState = MTCoachingStatePlane;
    MTCoachingOverlayView *planeOverlayView = [MTCoachingOverlayView coachingOverlayView];
    planeOverlayView.imageName = @"plane.gif";
    planeOverlayView.title = @"请移动手机开始扫描";
    [self.sceneView addSubview:planeOverlayView];
    self.planeOverlayView = planeOverlayView;
    [planeOverlayView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.sceneView);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [planeOverlayView removeFromSuperview];
        self.plus.hidden = NO;
        self.coachingState = MTCoachingStatePlaneEnd;
    });
}

- (void)showScanCoachingView {
    self.coachingState = MTCoachingStateScanning;
    MTCoachingOverlayView *scanningOverlayView = [MTCoachingOverlayView coachingOverlayView];
    scanningOverlayView.imageName = @"scanning.gif";
    [self.sceneView addSubview:scanningOverlayView];
    self.scanningOverlayView = scanningOverlayView;
    [scanningOverlayView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.sceneView);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [scanningOverlayView removeFromSuperview];
        self.coachingState = MTCoachingStateScanningEnd;
    });
}

#pragma mark - ARSessionDelegate
- (void)session:(ARSession *)session cameraDidChangeTrackingState:(ARCamera *)camera {
    self.cameraTrackingState = camera.trackingState;
    switch (camera.trackingState) {
        case ARTrackingStateNotAvailable:
            NSLog(@"ARTrackingStateNotAvailable")
            break;
        case ARTrackingStateLimited:
            NSLog(@"ARTrackingStateLimited")
            break;
        case ARTrackingStateNormal: {
            NSLog(@"ARTrackingStateNormal")
            if (!self.scan) {
                self.scan = [[MTScan alloc] init:self.sceneView];
                self.scan.
            }
        }
            
            break;
    }
}

#pragma mark - ARSCNViewDelegate
- (void)renderer:(id<SCNSceneRenderer>)renderer updateAtTime:(NSTimeInterval)time {
    ARFrame *frame = self.sceneView.session.currentFrame;
    if (!frame) return;
    [self.scan updateOnEveryFrame:frame];
}

- (void)clear {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
