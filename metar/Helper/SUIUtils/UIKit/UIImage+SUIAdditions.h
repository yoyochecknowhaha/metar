//
//  UIImage+SUIAdditions.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/18.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SUIAdditions)


- (UIImage * __null_unspecified)sui_imageWithTintColor:(UIColor *)tintColo; // kCGBlendModeDestinationIn
- (UIImage * __null_unspecified)sui_imageWithGradientTintColor:(UIColor *)tintColo; // kCGBlendModeOverlay
- (UIImage * __null_unspecified)sui_imageWithTintColor:(UIColor *)tintColo blendMode:(CGBlendMode)blendMode;

/**
 图片添加文字

 @param image 图片
 @param text 文字
 @param point 位置
 @param attributed 文字样式
 @return 新图片
 */
+ (UIImage *)sui_imageSetStringImage:(UIImage *)image text:(NSString *)text attributedString:(NSDictionary * )attributed;


@end

NS_ASSUME_NONNULL_END
