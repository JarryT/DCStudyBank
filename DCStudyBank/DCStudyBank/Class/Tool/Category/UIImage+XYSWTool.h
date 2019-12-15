//
//  UIImage+XYSWTool.h
//  Bayenet_User_iOS
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (XYSWTool)
+ (UIImage *)imageWithName:(NSString *)name;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;
+ (UIImage *)twoDimensionCodeWithSting:(NSString *)string size:(CGSize)size;
+ (UIImage *)barCodeImageWithSting:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
