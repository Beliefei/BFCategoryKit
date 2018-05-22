//
//  UIImage+ComposeImage.m
//  RapidCalculation
//
//  Created by raven on 2017/8/16.
//  Copyright © 2017年 knowin. All rights reserved.
//

#import "UIImage+ComposeImage.h"

@implementation UIImage (ComposeImage)

+ (UIImage *)addImage:(UIImage *)image2 toImage:(UIImage *)image1 {
    UIGraphicsBeginImageContextWithOptions(image1.size, NO, [UIScreen mainScreen].scale);
    
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

@end
