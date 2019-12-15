//
//  NSDictionary+Json.m
//  dictionrayExtension
//
//  Created by Apple on 2017/7/11.
//  Copyright © 2017年 zhangxianyao. All rights reserved.
//

#import "NSDictionary+Json.h"

@implementation NSDictionary (Json)
- (NSString *)toJSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}

- (NSString *)toReadableJSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}

- (NSData *)toJSONData {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    return data;
}


- (NSString *)objectForStringWith:(NSString *)key{
    return [NSString stringWithFormat:@"%@",[self objectSafeKey:key]];
}

- (id)objectSafeKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSNull class]]) {
        obj = @"";
    }
    if ([obj isKindOfClass:[NSString class]]) {
        if ([obj isEqualToString:@"null"] || [obj isEqualToString:@"<null>"] || [obj isEqualToString:@"(null)"]) {
            obj = @"";
        }
    }
    if (obj == nil) {
        obj = @"";
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        obj = [NSString stringWithFormat:@"%@",obj];
    }
    return obj;
}

- (NSString *)stringValue
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return dataString;
}
@end
