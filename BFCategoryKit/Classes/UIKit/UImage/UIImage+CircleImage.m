//
//  UIImage+CircleImage.m
//  TRapidCalculation
//
//  Created by 寇诚意 on 8/16/16.
//  Copyright © 2016 knowbox. All rights reserved.
//

#import "UIImage+CircleImage.h"

@implementation UIImage (CircleImage)

+ (UIImage *)tf_imageWithOriginalImage:(UIImage *)originalImage
{
    CGRect rect = CGRectMake(0, 0, originalImage.size.width, originalImage.size.height);
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0.0);
    CGFloat cornerRadius = MIN(originalImage.size.width, originalImage.size.height) * 0.5;
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius] addClip];
    [originalImage drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)tf_createImageWithColor:(UIColor *)color withSize:(CGSize)imageSize{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)tf_createRoundedImageWithColor:(UIColor *)color withSize:(CGSize)imageSize
{
    UIImage *originalImage = [self tf_createImageWithColor:color withSize:imageSize];
    return [self tf_imageWithOriginalImage:originalImage];
}

+ (UIImage *)tf_imageWithOriginalImage:(UIImage *)originalImage withBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth
{
    CGSize size = CGSizeMake(originalImage.size.width + 2 *borderWidth, originalImage.size.height + 2 * borderWidth);
    UIGraphicsBeginImageContextWithOptions(size,NO,0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [borderColor set];
    [path fill];
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, originalImage.size.width, originalImage.size.height)];
    [path addClip];
    [originalImage drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return clipImage;
}

@end
