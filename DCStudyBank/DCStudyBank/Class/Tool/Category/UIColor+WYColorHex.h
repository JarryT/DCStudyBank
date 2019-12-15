//
//  UIColor+WYColorHex.h
//  wantease
//
//  Created by mzj on 16/1/4.
//  Copyright © 2016年 iMax02. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WYColorHex)
+ (UIColor *) colorWithHexString: (NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *) hexColor alpha:(CGFloat)alpha;
@end
