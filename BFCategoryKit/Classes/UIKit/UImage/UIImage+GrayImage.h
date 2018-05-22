//
//  UIImage+GrayImage.h
//  RapidCalculation
//
//  Created by 寇诚意 on 3/20/17.
//  Copyright © 2017 knowin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GrayImage)

+ (UIImage*)systemImageToGrayImage:(UIImage*)image;
+ (UIImage*)grayScaleImageForImage:(UIImage*)image;

@end
