//
//  XYToolsFunction.h
//  Bayenet_User_iOS
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYToolsFunction : NSObject
/**
设置alert按钮颜色

@param color
@param action
*/
+ (void)setActionTitleTextColor:(UIColor *)color action:(UIAlertAction *)action;
// 贝塞尔切圆角
+ (void)cutRoundView:(UIView *)imageView corner:(CGFloat)corner;
// 秒转 分秒
+ (NSString *)getMMSSFromSS:(NSInteger)seconds;

/**
 根据给定颜色 生成图片
 
 @param color
 @return
 */
+ (UIImage*)createImageWithColor:(UIColor*)color;

/**
 * 判断手机号码是否正确
 */
+ (BOOL)isPhoneNumCorrectPhoneNum:(NSString *)phoneNum;

//进行邮箱正则表达式判断
+ (BOOL)validateEmail:(NSString*)email;
// 进行银行卡号判断
+ (BOOL)isBankCard:(NSString *)cardNumber;
// 富文本字符串
+ (NSMutableAttributedString *)setAttributedString:(NSString *)string color:(UIColor *)color rang:(NSRange)range font:(id)font;
// 自定义刷新header footer
+ (MJRefreshGifHeader *)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
+ (MJRefreshAutoGifFooter *)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;

/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
+ (BOOL)hasEmoji:(NSString*)string;

/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
+ (BOOL)isNineKeyBoard:(NSString *)string;
// string 转 json
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//获取当前日期
+(NSString *)getCurrentData:(NSString *)formatter;
@end

NS_ASSUME_NONNULL_END
