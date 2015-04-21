//
//  UIImage+QRImage.h
//  SKsinaWeibo
//
//  Created by jiasongkai on 15/4/11.
//  Copyright (c) 2015年 jiasongkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
@interface UIImage (QRImage)

/**
 * 第一个参数string：二维码信息
 * 第二个参数imageSize:二维码的宽或者高
 * 第三个参数icon:需要添加到二维码上面的图片的名字
 * 第四个参数iconSize：需要添加到二维码上面的图片的size；
 */
+ (UIImage *)imageWithQRCodeImageMessage:(NSString *)string imageSize:(CGFloat)imageSize icon:(NSString *)icon iconSize:(CGSize)iconSize;

@end
