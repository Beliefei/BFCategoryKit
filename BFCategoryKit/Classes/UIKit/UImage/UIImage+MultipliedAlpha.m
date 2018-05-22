//
//  UIImage+MultipliedAlpha.m
//  PreMultiplyAlphaDemo
//
//  Created by Huan WANG on 07/07/2017.
//  Copyright © 2017 Knowbox. All rights reserved.
//

#import "UIImage+MultipliedAlpha.h"

#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )
#define A(x) ( Mask8(x >> 24) )
#define RGBAMake(r, g, b, a) ( Mask8(r) | Mask8(g) << 8 | Mask8(b) << 16 | Mask8(a) << 24 )

@implementation UIImage (MultipliedAlpha)

+ (UIImage *)normalizeMultipliedAlphaForImage:(UIImage *)inputImage
{
	// 1.
	CGImageRef inputCGImage = [inputImage CGImage];
	NSUInteger width = CGImageGetWidth(inputCGImage);
	NSUInteger height = CGImageGetHeight(inputCGImage);
	
	// 2.
	NSUInteger bytesPerPixel = 4;
	NSUInteger bytesPerRow = bytesPerPixel * width;
	NSUInteger bitsPerComponent = 8;
	
	UInt32 * pixels;
	pixels = (UInt32 *) calloc(height * width, sizeof(UInt32));
	
	// 3.
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(pixels, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	
	// 4.
	CGContextDrawImage(context, CGRectMake(0, 0, width, height), inputCGImage);
	
	// 5. process pixels
	[self processPixels:pixels width:width height:height];
	
	CGImageRef outputCGImage = CGBitmapContextCreateImage(context);
	UIImage *outputImage = [UIImage imageWithCGImage:outputCGImage scale:inputImage.scale orientation:inputImage.imageOrientation];
	
	// 6. Cleanup
	free(pixels);
	CFRelease(outputCGImage);
	CGColorSpaceRelease(colorSpace);
	CGContextRelease(context);
	
	return outputImage;
}

+ (void)processPixels:(UInt32 *)pixels width:(NSUInteger)width height:(NSUInteger)height
{
	UInt32 *currentPixel = pixels;
	for (NSUInteger j = 0; j < height; j++) {
		for (NSUInteger i = 0; i < width; i++) {
			UInt32 color = *currentPixel;
			UInt32 alpha = A(color);
			
			const BOOL isTransparent = (alpha > 0) && (alpha < 255);
			if (isTransparent) {
				UInt32 newR = round(255.0 * R(color) / alpha);
				UInt32 newG = round(255.0 * G(color) / alpha);
				UInt32 newB = round(255.0 * B(color) / alpha);
				
				// Clamp, not really useful here :p
				newR = MAX(0,MIN(255, newR));
				newG = MAX(0,MIN(255, newG));
				newB = MAX(0,MIN(255, newB));
				
				*currentPixel = RGBAMake(newR, newG, newB, alpha);
			}
			
			currentPixel++;
		}
	}
}

@end
