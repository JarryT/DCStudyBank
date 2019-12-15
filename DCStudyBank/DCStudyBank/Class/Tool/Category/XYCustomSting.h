//
//  XYCustomSting.h
//  Bayenet_User_iOS
//
//  Created by mac on 2019/9/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYCustomSting : NSObject

+ (BOOL)isEmptyString:(NSString *)_str;
+ (BOOL)isEmptyStringBySpace:(NSString*)_str;
+ (BOOL)isNotEmptyString:(NSString *)_str;
+ (BOOL)isMobileNumber:(NSString *)text;
//数字字符串每格3位，隔开
+ (NSString *)separateNumberUseCommaWith:(NSString *)number ;
//根据时间撮转换时间
+(NSString *)getTimeFromTimestamp:(double)temp formatter:(NSString *)format;
@end

NS_ASSUME_NONNULL_END
