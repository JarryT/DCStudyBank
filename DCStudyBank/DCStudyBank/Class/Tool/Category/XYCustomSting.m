//
//  XYCustomSting.m
//  Bayenet_User_iOS
//
//  Created by mac on 2019/9/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "XYCustomSting.h"

@implementation XYCustomSting
+ (BOOL)isEmptyString:(NSString *)_str
{
    if (![_str isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if ([_str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([_str isEqualToString:@""]) {
        return YES;
    }
    if ([_str isEqualToString:@"(null)"]) {
        return YES;
    }
    if (_str == nil) {
        return YES;
    }
    if (_str == NULL) {
        return YES;
    }
    if ((NSNull*)_str == [NSNull null]) {
        return YES;
    }
    return [self isEmptyStringBySpace:_str];
    return NO;
}

//全是空格
+ (BOOL)isEmptyStringBySpace:(NSString*)_str
{
    //全是空格不可完成提交
    if ([[_str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isNotEmptyString:(NSString *)_str; {
    if (![_str isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    if ([_str isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    if ([_str isEqualToString:@""]) {
        return NO;
    }
    if (_str == nil) {
        return NO;
    }
    if (_str == NULL) {
        return NO;
    }
    if ((NSNull*)_str == [NSNull null]) {
        return NO;
    }
    BOOL isHasSpace = [self isEmptyStringBySpace:_str];
    return !isHasSpace;
}

//判断手机号2016-8-11 csy
+(BOOL)isMobileNumber:(NSString *)text
{
    //手机号码，11位
    NSString *Regex = @"^\\d{11}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [phoneTest evaluateWithObject:text];
    
    //    NSString * MOBILE = @"^0{0,1}(13[0-9]|15[7-9]|153|156|18[7-9])[0-9]{8}$";
    //        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //
    //    if (([regextestmobile evaluateWithObject:text] == YES))
    //    {
    //        return YES;
    //    }
    //    else
    //    {
    //        return NO;
    //    }
    
}


//数字字符串每格3位，隔开
+ (NSString *)separateNumberUseCommaWith:(NSString *)number {
    // 前缀
       NSString *prefix = @"￥";
    // 后缀
    //    NSString *suffix = @"元";
    // 分隔符
    NSString *divide = @",";
    NSString *integer = @"";
    NSString *radixPoint = @"";
    BOOL contains = NO;
    if ([number containsString:@"."]) {
        contains = YES;
        // 若传入浮点数，则需要将小数点后的数字分离出来
        NSArray *comArray = [number componentsSeparatedByString:@"."];
        integer = [comArray firstObject];
        radixPoint = [comArray lastObject];
    } else {
        integer = number;
    }
    // 将整数按各个字符为一组拆分成数组
    NSMutableArray *integerArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < integer.length; i ++) {
        NSString *subString = [integer substringWithRange:NSMakeRange(i, 1)];
        [integerArray addObject:subString];
    }
    // 将整数数组倒序每隔3个字符添加一个逗号“,”
    NSString *newNumber = @"";
    for (NSInteger i = 0 ; i < integerArray.count ; i ++) {
        NSString *getString = @"";
        NSInteger index = (integerArray.count-1) - i;
        if (integerArray.count > index) {
            getString = [integerArray objectAtIndex:index];
        }
        BOOL result = YES;
        if (index == 0 && integerArray.count%3 == 0) {
            result = NO;
        }
        if ((i+1)%3 == 0 && result) {
            newNumber = [NSString stringWithFormat:@"%@%@%@",divide,getString,newNumber];
        } else {
            newNumber = [NSString stringWithFormat:@"%@%@",getString,newNumber];
        }
    }
    if (contains) {
        newNumber = [NSString stringWithFormat:@"%@.%@",newNumber,radixPoint];
    }
        if (![prefix isEqualToString:@""]) {
            newNumber = [NSString stringWithFormat:@"%@%@",prefix,newNumber];
        }
    //    if (![suffix isEqualToString:@""]) {
    //        newNumber = [NSString stringWithFormat:@"%@%@",newNumber,suffix];
    //    }
    return newNumber;
}

+(NSString *)getTimeFromTimestamp:(double)temp formatter:(NSString *)format{
    
    //将对象类型的时间转换为NSDate类型

    
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:temp];
    //设置时间格式
    
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:format];
    
    //将时间转换为字符串
    NSString *timeStr=[formatter stringFromDate:myDate];
    
    return timeStr;
    
}

@end
