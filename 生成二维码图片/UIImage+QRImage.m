//
//  UIImage+QRImage.m
//  SKsinaWeibo
//
//  Created by jiasongkai on 15/4/11.
//  Copyright (c) 2015年 jiasongkai. All rights reserved.
//

#import "UIImage+QRImage.h"

@implementation UIImage (QRImage)

+ (UIImage *)imageWithQRCodeImageMessage:(NSString *)string imageSize:(CGFloat)imageSize icon:(NSString *)icon iconSize:(CGSize)iconSize
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setDefaults];
    
    NSData *data = [string  dataUsingEncoding:NSUTF8StringEncoding];
    
    [filter setValue:data forKeyPath:@"inputMessage"];
    CIImage *image = [filter outputImage];
    UIImage *highImage = [self createNonInterpolatedUIImageFormCIImage:image withSize:imageSize];
    if ([icon isEqualToString: @""] || icon == nil) {
        return highImage;
    }
    UIImage *iconImage = [UIImage imageNamed:icon];
    return [self mergeImageWith:highImage icon:iconImage iconSize:iconSize];
    
}

/**
 * 根据二维码图片和icon图片生成一张二维码图片。
 */
+ (UIImage *)mergeImageWith:(UIImage *)image icon:(UIImage *)icon iconSize:(CGSize)size
{
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    CGFloat iconW = size.width;
    CGFloat iconH = size.height;
    CGFloat iconX = (image.size.width - iconW) * 0.5;
    CGFloat iconY = (image.size.height - iconH) * 0.5;
    [icon drawInRect:CGRectMake(iconX, iconY, iconW, iconH)];
    UIImage *mergeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return mergeImage;
}

/**
 * 生成一张size尺寸的高清图片。
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


@end
