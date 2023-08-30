//
//  MTValidCodeView.h
//  metar
//
//  Created by 关山第一渣男 on 2023/8/1.
//

#import "BSAnimationView.h"

@class MTValidCodeView;

@protocol MTValidCodeViewDelegate <NSObject>

@optional
- (void)validCodeViewSuccess:(MTValidCodeView *_Nullable)validCodeView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MTValidCodeView : BSAnimationView

@property (nonatomic, weak) id<MTValidCodeViewDelegate> delegate;

- (void)showWithParentView:(UIView *)parentView;

+ (instancetype)validCodeView;

@end

NS_ASSUME_NONNULL_END
