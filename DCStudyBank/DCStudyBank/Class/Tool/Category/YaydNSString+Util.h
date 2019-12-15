//
//  YaydNSString+Util.h
//  CTTAPP
//
//  Created by 汤军 on 2017/11/2.
//  Copyright © 2017年 TJarry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Util)
+ (NSString*)UUID;
- (CGSize)sizeWithFont:(UIFont *)font maxW:(double)maxW;
- (CGSize)sizeWithFont:(UIFont *)font maxH:(double)maxH;
- (NSString *)md5Endode32;

+(BOOL)codeFormatters:(NSString *)pass;//字母数字组合4个长度
- (BOOL)stringContainsEmoji;

/**
 checkString   检测字符串本身属性 是否是字符串，是否是合法字符串

 @param string 被检测的字符串
 @return 一个合法的真正字符串
 */
+ (NSString *)checkString:(NSString *)string;
/**
 *  限制输入表情字符
 */

+ (BOOL)stringContainsEmoji:(NSString *)string;
+ (BOOL)stringContainsEmoji:(NSString *)string isAbsoluteEmoji:(BOOL)isAbsoluteEmoji;

//限制输入字母或数字
+ (BOOL)checkPassword:(NSString *) password;
//限制输入字母或数字汉字
+ (BOOL)checkisChinaese:(NSString *)isChinaese;
//固定电话正则表达
+ (BOOL)isMobile:(NSString *)mobileNumbel;
//简单手机号码验证
- (BOOL)isPhoneSimple;
//限制输入字母,汉字
+ (BOOL)checkInput:(NSString *)userName;

//身份证号简单校验
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
//身份证详细校验
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;

//校验 联通、电信、移动 电话号码
+ (BOOL)valiMobile:(NSString *)mobile;

- (NSMutableAttributedString *)fixedPriceTextWithFont:(UIFont *)font;

- (NSString *)timeFromFormatter:(NSString *)lastFormatter toFormatter:(NSString *)toFormatter;

// 获取当前时间戳
+(NSString *)getNowTimeTimestamp2;
//服务器时间戳转时间
+(NSString *)getTimeTampToTime:(NSString *)timeStampString;
//获取当前时间
+(NSString*)getCurrentTimes;
@end

@interface NSString (Date)
- (NSDate *)stringDate;
- (NSDate *)stringDateTime;
@end
