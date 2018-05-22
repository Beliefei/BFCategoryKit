//
//  UIImage+CircleImage.h
//  TRapidCalculation
//
//  Created by 寇诚意 on 8/16/16.
//  Copyright © 2016 knowbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CircleImage)

//生成圆角图片
+ (UIImage *)tf_imageWithOriginalImage:(UIImage *)originalImage;

//生成纯色圆角图片
+ (UIImage *)tf_createRoundedImageWithColor:(UIColor *)color withSize:(CGSize)imageSize;

//生成纯色图片
+ (UIImage *)tf_createImageWithColor:(UIColor *)color withSize:(CGSize)imageSize;

//生成带圆环的圆角图片
+ (UIImage *)tf_imageWithOriginalImage:(UIImage *)originalImage withBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth;

@end
