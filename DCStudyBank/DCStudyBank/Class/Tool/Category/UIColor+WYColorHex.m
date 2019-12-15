//
//  UIColor+WYColorHex.m
//  wantease
//
//  Created by mzj on 16/1/4.
//  Copyright © 2016年 iMax02. All rights reserved.
//

#import "UIColor+WYColorHex.h"

@implementation UIColor (WYColorHex)
#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    return [UIColor colorWithHexString:color alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *) hexColor alpha:(CGFloat)alpha
{
    //线程锁@synchronized(self){}
    @synchronized(self)
    {
        if ([hexColor length] < 6) return [UIColor blackColor];
        if ([hexColor hasPrefix:@"#"]) hexColor = [hexColor substringFromIndex:1];
        if ([hexColor length] < 6) return [UIColor blackColor];
        unsigned int redInt_, greenInt_, blueInt_;
        NSRange rangeNSRange_;
        rangeNSRange_.length = 2;  // 范围长度为2
        
        // 取红色的值
        rangeNSRange_.location = 0;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&redInt_];
        
        // 取绿色的值
        rangeNSRange_.location = 2;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&greenInt_];
        
        // 取蓝色的值
        rangeNSRange_.location = 4;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&blueInt_];
        
        return [UIColor colorWithRed:(float)(redInt_/255.0f) green:(float)(greenInt_/255.0f) blue:(float)(blueInt_/255.0f) alpha:alpha];
    }
    
}

@end
