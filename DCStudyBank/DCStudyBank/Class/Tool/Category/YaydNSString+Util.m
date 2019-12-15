//
//  YaydNSString+Util.m
//  CTTAPP
//
//  Created by 汤军 on 2017/11/2.
//  Copyright © 2017年 TJarry. All rights reserved.
//

#import "YaydNSString+Util.h"
#import <CommonCrypto/CommonDigest.h>

#define UUID_PATH @"UUID_Device_UUID_PATH"
@implementation NSString (Util)

- (NSString *)timeFromFormatter:(NSString *)lastFormatterS toFormatter:(NSString *)toFormatterS{
    
    NSDateFormatter *lastFormatter = [[NSDateFormatter alloc] init];
    lastFormatter.dateFormat = lastFormatterS;
    NSDate *lastDate = [lastFormatter dateFromString:self];
    
    NSDateFormatter *nowFormatter = [[NSDateFormatter alloc] init];
    nowFormatter.dateFormat = toFormatterS;
    
    return [nowFormatter stringFromDate:lastDate];
}

- (NSMutableAttributedString *)fixedPriceTextWithFont:(UIFont *)font{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self];
    [attr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, 1)];
    return  attr;
}

- (CGSize)sizeWithFont:(UIFont *)font maxW:(double)maxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
- (CGSize)sizeWithFont:(UIFont *)font maxH:(double)maxH {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(MAXFLOAT, maxH);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

//手机设备UUID永远保存在用户偏好中、hhnz不需要删除
+ (NSString*)UUID{
    
    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:UUID_PATH];
    if (uuid) {
        
        return uuid;
    } else {
        
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        
        [[NSUserDefaults standardUserDefaults] setObject:result forKey:UUID_PATH];
        return result;
    }
}

//md5加密-32位 (小写)
- (NSString *)md5Endode32{
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

+(BOOL)codeFormatters:(NSString *)pass{
//	BOOL result = false;
			// 判断长度大于8位后再接着判断是否同时包含数字和字符
			//		NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$";
	//[0-9a-zA_Z]+   @"^[A-Za-z0-9]$"
	NSString * regex = @"^(?=.*[A-Za-z])(?=.*[0-9])[a-zA-Z0-9]{4}$";
		NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//		if ([pred evaluateWithObject:pass]) {
//			NSString * regex = @"^[A-Za-z0-9]$";
//			NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//			result = [pred evaluateWithObject:pass];
//		}
	return [pred evaluateWithObject:pass];
}
- (BOOL)stringContainsEmoji
{
	__block BOOL returnValue = NO;
	[self enumerateSubstringsInRange:NSMakeRange(0, [self length])
							 options:NSStringEnumerationByComposedCharacterSequences
						  usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
							  const  unichar hs = [substring characterAtIndex:0];
							  if (0xd800 <= hs && hs <= 0xdbff) {
									  //                                    if (substring.length > 1) {
									  //                                        const unichar ls = [substring characterAtIndex:1];
									  //                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
									  //                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
								  returnValue = YES;
									  //                                        }
									  //                                    }
							  }else
							   {
								  if (substring.length > 1) {
									  const unichar ls = [substring characterAtIndex:1];
									  if (ls == 0x20e3) {
										  returnValue = YES;
									  }
								  }
								  if (!returnValue){
									  if (0x2100 <= hs && hs <= 0x27ff) {
										  returnValue = YES;
									  } else if (0x2B05 <= hs && hs <= 0x2b07) {
										  returnValue = YES;
									  } else if (0x2934 <= hs && hs <= 0x2935) {
										  returnValue = YES;
									  } else if (0x3297 <= hs && hs <= 0x3299) {
										  returnValue = YES;
									  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
										  returnValue = YES;
									  }
								  }
							   }
						  }];
	return returnValue;
}

+ (BOOL)stringContainsEmoji:(NSString *)string isAbsoluteEmoji:(BOOL)isAbsoluteEmoji{
    NSArray *arr = @[@"➋",@"➌",@"➍",@"➎",@"➏",@"➐",@"➑",@"➒",@""];
    if ([arr containsObject:string]) {
        return false;
    }else{
        return [self stringContainsEmoji:string];
    }
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
	__block BOOL returnValue = NO;
	[string enumerateSubstringsInRange:NSMakeRange(0, [string length])
							 options:NSStringEnumerationByComposedCharacterSequences
						  usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
							  const  unichar hs = [substring characterAtIndex:0];
							  if (0xd800 <= hs && hs <= 0xdbff) {
								  returnValue = YES;
							  }else{
								  if (substring.length > 1) {
									  const unichar ls = [substring characterAtIndex:1];
									  if (ls == 0x20e3) {
										  returnValue = YES;
									  }
								  }
								  if (!returnValue){
									  if (0x2100 <= hs && hs <= 0x27ff) {
										  returnValue = YES;
									  } else if (0x2B05 <= hs && hs <= 0x2b07) {
										  returnValue = YES;
									  } else if (0x2934 <= hs && hs <= 0x2935) {
										  returnValue = YES;
									  } else if (0x3297 <= hs && hs <= 0x3299) {
										  returnValue = YES;
									  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
										  returnValue = YES;
									  }
								  }
							   }
						  }];
	return returnValue;
}


+ (BOOL)checkPassword:(NSString *) password
{
	NSString *pattern = @"^[a-zA-Z0-9]{8,32}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

+ (BOOL)checkisChinaese:(NSString *)isChinaese{
    
    NSString *pattern = @"^[\u4e00-\u9fa50-9a-zA-Z]+$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:isChinaese];
    return isMatch;
    
}


+ (BOOL) isMobile:(NSString *)mobileNumbel{
    
    NSString *pattern = @"d{3}-d{8}|d{4}-d{7}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:mobileNumbel];
    return isMatch;
    
    
}

+ (BOOL)checkInput:(NSString *) userName{
    
    NSString *pattern = @"^[A-Za-z\u4E00-\u9FA5]+$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
    
}
- (BOOL)isTelephone
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return  [regextestmobile evaluateWithObject:self]   ||
    [regextestphs evaluateWithObject:self]      ||
    [regextestct evaluateWithObject:self]       ||
    [regextestcu evaluateWithObject:self]       ||
    [regextestcm evaluateWithObject:self];
}

- (BOOL)isPhoneSimple
{
	NSString *phone = @"^1[3-57-9]\\d{9}$";
	NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phone];
	return  [regextestmobile evaluateWithObject:self];
}
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
   //  NSString *regex2 = @"^(\\d{14}|\\d{17})[[0-9],0-9xX]$";
    NSString *regex2 = @"^(\\d{14}|\\d{17})[0-9xX]$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value {
    
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length =0;
    
    if (!value) {
        
        return NO;
        
    }else {
        
        length = (int)value.length;
        
        
        
        if (length !=15 && length !=18) {
            
            return NO;
            
        }
        
    }
    
    
    // 省份代码
    
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    
    
    NSString *valueStart2 = [value substringToIndex:2];
    
    BOOL areaFlag =NO;
    
    for (NSString *areaCode in areasArray) {
        
        if ([areaCode isEqualToString:valueStart2]) {
            
            areaFlag =YES;
            
            break;
            
        }
        
    }
    
    
    
    if (!areaFlag) {
        
        return false;
        
    }
    
    
    
    NSRegularExpression *regularExpression;
    
    NSUInteger numberofMatch;
    
    
    
    int year =0;
    
    switch (length) {
            
        case 15:
            
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                     
                                                                         options:NSRegularExpressionCaseInsensitive
                                     
                                                                           error:nil];//测试出生日期的合法性
                
            }else {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                     
                                                                        options:NSRegularExpressionCaseInsensitive
                                     
                                                                          error:nil];//测试出生日期的合法性
                
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                             
                                                               options:NSMatchingReportProgress
                             
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                
                return YES;
                
            }else {
                
                return NO;
                
            }
            
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                     
                                                                         options:NSRegularExpressionCaseInsensitive
                                     
                                                                           error:nil];//测试出生日期的合法性
                
            }else {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                     
                                                                         options:NSRegularExpressionCaseInsensitive
                                     
                                                                           error:nil];//测试出生日期的合法性
                
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                             
                                                               options:NSMatchingReportProgress
                             
                                                                 range:NSMakeRange(0, value.length)];
            
            
            
            if(numberofMatch >0) {
                
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                int Y = S %11;
                
                NSString *M =@"F";
                
                NSString *JYM =@"10X98765432";
                
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    
                    return YES;// 检测ID的校验位
                    
                }else {
                    
                    return NO;
                    
                }
                
                
            }else {
                
                return NO;
                
            }
            
        default:
            
            return NO;
            
    }
    
}

+ (BOOL)valiMobile:(NSString *)mobile
{
    if (mobile.length != 11)
    {
        return NO;
    }else{
        
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

+ (NSString *)checkString:(NSString *)string
{
	if ([string isEqualToString:@"null"] || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"]) {
		return @"";
	}
	if (!([string isKindOfClass:[NSString class]] || [string isKindOfClass:[NSNumber class]])) {
		if ([string isKindOfClass:[NSNumber class]]) {
			string = [NSString stringWithFormat:@"%@",string];
		}
		return @"";
	}
	if (string == nil || string.length == 0) {
		return @"";
	}
	return string;
}

// 获取当前时间戳
+(NSString *)getNowTimeTimestamp2 {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

//服务器时间戳转时间
+(NSString *)getTimeTampToTime:(NSString *)timeStampString{
    
    
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStampString doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    return dateString;
}

//获取当前时间
+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}
@end

@implementation NSString (Date)
- (NSDate *)stringDate
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	NSDate *date = [dateFormatter dateFromString:self];
	return date;
}
- (NSDate *)stringDateTime
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSDate *date = [dateFormatter dateFromString:self];
	return date;
}
@end
