//
//  UIImage+Reflection.m
//
//  Created by Gilad Novik on 10-03-31.
//  Copyright 2010 Gilad Novik. All rights reserved.
//

#import "UIImage+Reflection.h"


@implementation UIImage (Reflection)

- (UIImage*)reflectedImage:(NSUInteger)height
{
    if (!height)
		return nil;
    
	CGRect rect=CGRectMake(0, 0, self.size.width, height);
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate (NULL, rect.size.width, rect.size.height, 8,	0, colorSpace, kCGImageAlphaPremultipliedLast);
	CGColorSpaceRelease(colorSpace);
	
	CGFloat translateVertical= self.size.height - height;
	CGContextTranslateCTM(context, 0, -translateVertical);
	
	UIGraphicsPushContext(context);
	[self drawAtPoint:rect.origin];
	UIGraphicsPopContext();
	
	CGContextTranslateCTM(context, 0, translateVertical);
	
	CGImageRef bitmap = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	
	colorSpace = CGColorSpaceCreateDeviceGray();
	
	CGContextRef gradientContext = CGBitmapContextCreate(nil, rect.size.width, height, 8, 0, colorSpace, kCGImageAlphaNone);
	
	static CGFloat colors[] = {0.0, 1.0, 0.5, 1.0};
	
	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
	CGColorSpaceRelease(colorSpace);
	
	CGContextDrawLinearGradient(gradientContext, gradient, CGPointZero, CGPointMake(0, height), kCGGradientDrawsAfterEndLocation);
	CGGradientRelease(gradient);
	
	CGImageRef gradientMaskImage = CGBitmapContextCreateImage(gradientContext);
	CGContextRelease(gradientContext);
	
	CGImageRef reflectionImage = CGImageCreateWithMask(bitmap, gradientMaskImage);
	CGImageRelease(bitmap);
	CGImageRelease(gradientMaskImage);
	
	UIImage *theImage = [UIImage imageWithCGImage:reflectionImage];
	
	CGImageRelease(reflectionImage);
	
	return theImage;
}

@end
