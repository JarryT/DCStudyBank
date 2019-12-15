//
//  PersistManager+UserDefaults.m
//  CTTAPP
//
//  Created by 汤军 on 2017/11/3.
//  Copyright © 2017年 TJarry. All rights reserved.
//

#import "PersistManager+UserDefaults.h"

@implementation PersistManager (UserDefaults)

+ (NSUserDefaults *)userDefaultsWith:(NSString *)userId{
    return [[NSUserDefaults alloc] initWithSuiteName:userId];
}

+ (NSUserDefaults *)userDefaults{
    return [NSUserDefaults standardUserDefaults];
}
@end
