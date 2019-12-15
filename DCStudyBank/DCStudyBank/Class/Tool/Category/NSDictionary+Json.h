//
//  NSDictionary+Json.h
//  dictionrayExtension
//
//  Created by Apple on 2017/7/11.
//  Copyright © 2017年 zhangxianyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Json)
/**
 *  转换成JSON串字符串（没有可读性）
 *
 *  @return JSON字符串
 */
- (NSString *)toJSONString;

/**
 *  转换成JSON串字符串（有可读性）
 *
 *  @return JSON字符串
 */
- (NSString *)toReadableJSONString;

/**
 *  转换成JSON数据
 *
 *  @return JSON数据
 */
- (NSData *)toJSONData;

- (id)objectSafeKey:(id)key;
- (NSString *)objectForStringWith:(NSString *)key;

- (NSString *)stringValue;


@end
