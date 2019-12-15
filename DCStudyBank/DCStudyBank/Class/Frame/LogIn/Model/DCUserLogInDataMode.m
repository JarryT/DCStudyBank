
//
//  DCUserLogInDataMode.m
//  DCStudyBank
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCUserLogInDataMode.h"

@implementation DCUserLogInDataMode

@end
@implementation DCUserLogInObjMode

@end
@implementation DCUserLogUserModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"userId":@"id"};
}
@end
