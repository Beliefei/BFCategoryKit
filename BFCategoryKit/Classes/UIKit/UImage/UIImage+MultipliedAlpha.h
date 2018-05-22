//
//  UIImage+MultipliedAlpha.h
//  PreMultiplyAlphaDemo
//
//  Created by Huan WANG on 07/07/2017.
//  Copyright © 2017 Knowbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MultipliedAlpha)

// pre-multiplied alpha is converted to regular alpha
+ (UIImage *)normalizeMultipliedAlphaForImage:(UIImage *)inputImage;

@end
