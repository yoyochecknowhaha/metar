//
//  MTPaperView.h
//  metar
//
//  Created by 关山第一渣男 on 2023/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTPaperViewDelegate <NSObject>

@optional
- (void)paperViewDidRemoved;

@end

@interface MTPaperView : UIView

@property (nonatomic, weak) id<MTPaperViewDelegate> delegate;

+ (instancetype)paperView;

@end

NS_ASSUME_NONNULL_END
