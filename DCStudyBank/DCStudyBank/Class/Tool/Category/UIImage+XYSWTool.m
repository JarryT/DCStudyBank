//
//  UIImage+XYSWTool.m
//  Bayenet_User_iOS
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "UIImage+XYSWTool.h"

@implementation UIImage (XYSWTool)
+ (UIImage *)imageWithName:(NSString *)name{
    if (name && name.length > 0) {
        return [self imageNamed:name];
    } else {
        return nil;
    }
}
+ (UIImage *)imageWithColor:(UIColor *)color
{
    return  [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);

    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    [self drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+ (UIImage *)twoDimensionCodeWithSting:(NSString *)string size:(CGSize)size
{
    // 1.将字符串转换成NSData
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];

    // 2.创建二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];

    // 3.恢复默认
    [filter setDefaults];

    // 4.给滤镜设置数据
    [filter setValue:data forKeyPath:@"inputMessage"];

    // 5.获取滤镜输出的二维码
    CIImage *outputImage = [filter outputImage];

    // 6.此时生成的还是CIImage，可以通过下面方式生成一个固定大小的UIImage
    CGRect extent = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));

    // 7.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);

    // 8.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+ (UIImage *)barCodeImageWithSting:(NSString *)string
{
    // 1.将字符串转换成NSData
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];

    // 2.创建条形码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];

    // 3.恢复滤镜的默认属性
    [filter setDefaults];

    // 4.设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];

    // 5.获得滤镜输出的图像
    CIImage *urlImage = [filter outputImage];

    // 6.将CIImage 转换为UIImage
    UIImage *image = [UIImage imageWithCIImage:urlImage];

    return image;
}
@end
