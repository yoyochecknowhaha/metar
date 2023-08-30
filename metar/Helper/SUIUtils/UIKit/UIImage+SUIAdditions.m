//
//  UIImage+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/18.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UIImage+SUIAdditions.h"

@implementation UIImage (SUIAdditions)


- (UIImage *)sui_imageWithTintColor:(UIColor *)tintColo
{
    return [self sui_imageWithTintColor:tintColo blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)sui_imageWithGradientTintColor:(UIColor *)tintColo
{
    return [self sui_imageWithTintColor:tintColo blendMode:kCGBlendModeOverlay];
}

- (UIImage *)sui_imageWithTintColor:(UIColor *)tintColo blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColo setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

+ (UIImage *)sui_imageSetStringImage:(UIImage *)image text:(NSString *)text attributedString:(NSDictionary * )attributed {
    CGSize textSize = [text sui_sizeWithFont:attributed[NSFontAttributeName] constrainedToWidth:image.size.width];
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width, image.size.height + textSize.height + 10), NO, 0);
    //2.绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //添加水印文字
    CGFloat textX = 0;
    CGSize textHorizontalSize = [text sizeWithAttributes:attributed];
    if (textHorizontalSize.width < image.size.width) {
        textX = (image.size.width - textHorizontalSize.width) * 0.5;
        [text drawAtPoint:CGPointMake(textX, image.size.height) withAttributes:attributed];
    } else {
        [text drawInRect:CGRectMake(textX, image.size.height, image.size.width, textSize.height + 10) withAttributes:attributed];
    }
    //3.从上下文中获取新图片
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return img;
}


@end
