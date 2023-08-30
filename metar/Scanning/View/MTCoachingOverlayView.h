//
//  MTPlaneScanningView.h
//  metar
//
//  Created by 关山第一渣男 on 2023/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTCoachingOverlayView : UIView

+ (instancetype)coachingOverlayView;

@property (nonatomic, copy, readwrite) NSString *imageName;
@property (nonatomic, copy, readwrite) NSString *title;

@end

NS_ASSUME_NONNULL_END
