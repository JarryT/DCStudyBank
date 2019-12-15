//
//  XYToolsFunction.m
//  Bayenet_User_iOS
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "XYToolsFunction.h"

@implementation XYToolsFunction
/**
 设置alert按钮颜色
 
 @param color
 @param action
 */
+ (void)setActionTitleTextColor:(UIColor *)color action:(UIAlertAction *)action {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3) {
        [action setValue:color forKey:@"titleTextColor"];
    }
}

+ (void)cutRoundView:(UIView *)imageView corner:(CGFloat)corner {
    
    CGFloat cornerRadius = corner == 0 ? imageView.frame.size.width / 2 : corner;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    shapeLayer.path = path.CGPath;
    imageView.layer.mask = shapeLayer;
}

+(NSString *)getMMSSFromSS:(NSInteger)seconds {
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;
}

/**
 根据给定颜色 生成图片
 
 @param color
 @return
 */
+ (UIImage*)createImageWithColor:(UIColor*)color {
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 * 判断手机号码是否正确
 */
+ (BOOL)isPhoneNumCorrectPhoneNum:(NSString *)phoneNum {
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phoneNum.length != 11)
    {
        return NO;
    } else {
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"(^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}$|17[0-9]{9}$|19[0-9]{9}$)";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"(^1(3[0-2]|4[5]|5[56]|7[56]|8[56])\\d{8}$)|(^1709\\d{7}$)";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"(^1(33|53|73|77|79|99|8[019])\\d{8}$)|(^1700\\d{7}$)";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:phoneNum];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:phoneNum];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:phoneNum];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
}

//进行邮箱正则表达式判断
+ (BOOL)validateEmail:(NSString*)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isBankCard:(NSString *)cardNumber {
    if(cardNumber.length==0){
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++){
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c)){
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo){
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

+ (NSMutableAttributedString *)setAttributedString:(NSString *)string color:(UIColor *)color rang:(NSRange)range font:(id)font {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    //设置颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range]; // 0为起始位置 length是从起始位置开始 设置指定颜色的长度
    //设置尺寸
    [attributedString addAttribute:NSFontAttributeName value:font range:range]; // 0为起始位置 length是从起始位置开始 设置指定字体尺寸的长度
    return attributedString;
}

+ (MJRefreshGifHeader *)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    MJRefreshGifHeader *header =  [MJRefreshGifHeader headerWithRefreshingBlock:^{
        refreshingBlock();
    }];
    
    [header setTitle:@"下啦加载" forState:MJRefreshStateIdle];
    [header setTitle:@"释放查看" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    // 设置普通状态的动画图片 (idleImages 是图片)
//    [header setImages:@[[UIImage imageNamed:@"Gif_Loading_1"]] forState:MJRefreshStateIdle];
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    [header setImages:@[[UIImage imageNamed:@"Gif_Loading_1"]] forState:MJRefreshStatePulling];
//    // 设置正在刷新状态的动画图片
//    [header setImages:@[[UIImage imageNamed:@"Gif_Loading_1"], [UIImage imageNamed:@"Gif_Loading_2"], [UIImage imageNamed:@"Gif_Loading_3"], [UIImage imageNamed:@"Gif_Loading_4"], [UIImage imageNamed:@"Gif_Loading_5"]] forState:MJRefreshStateRefreshing];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    //    header.stateLabel.hidden = YES;
    return header;
}

+ (MJRefreshAutoGifFooter *)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        refreshingBlock();
    }];
    // 设置文字
    [footer setTitle:@"一 已到底了 一" forState:MJRefreshStateIdle];
    [footer setTitle:@"释放查看" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
//    // 设置普通状态的动画图片 (idleImages 是图片)
//    [footer setImages:@[[UIImage imageNamed:@"Gif_Loading_1"]] forState:MJRefreshStateIdle];
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    [footer setImages:@[[UIImage imageNamed:@"Gif_Loading_1"]] forState:MJRefreshStatePulling];
//    // 设置正在刷新状态的动画图片
//    [footer setImages:@[[UIImage imageNamed:@"Gif_Loading_1"], [UIImage imageNamed:@"Gif_Loading_2"], [UIImage imageNamed:@"Gif_Loading_3"], [UIImage imageNamed:@"Gif_Loading_4"], [UIImage imageNamed:@"Gif_Loading_5"]] forState:MJRefreshStateRefreshing];
    
    return footer;
}


/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
+ (BOOL)stringContainsEmoji:(NSString *)string {
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
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
     }];
    
    return returnValue;
}

/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
+ (BOOL)hasEmoji:(NSString*)string {
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
+ (BOOL)isNineKeyBoard:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++) {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//获取当前日期
+(NSString *)getCurrentData:(NSString *)formatter{
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:formatter];
    
    return [format1 stringFromDate:date];
}

@end
