//
//  PersistManager+UserDefaults.h
//  CTTAPP
//
//  Created by 汤军 on 2017/11/3.
//  Copyright © 2017年 TJarry. All rights reserved.
//

#import "PersistManager.h"

@interface PersistManager (UserDefaults)

+ (NSUserDefaults *)userDefaults;
+ (NSUserDefaults *)userDefaultsWith:(NSString *)userId;
@end
