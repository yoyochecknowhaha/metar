//
//  MTScanningController.h
//  metar
//
//  Created by 关山第一渣男 on 2023/8/21.
//

#import "MTBaseController.h"

@class ARSCNView, MTScan;

typedef NS_ENUM(NSUInteger, MTState) {
    MTStateStartARSession,
    MTStateNotReady,
    MTStateScanning,
    MTStateTesting
};

NS_ASSUME_NONNULL_BEGIN

@interface MTScanningController : MTBaseController

@property (class, nonatomic, strong, nullable) MTScanningController *instance;
@property (weak, nonatomic) IBOutlet ARSCNView *sceneView;
@property (nonatomic, strong, nullable) MTScan *scan;
@property (nonatomic, assign) CGPoint screenCenter;
@property (nonatomic, assign) MTState state;

@end

NS_ASSUME_NONNULL_END
