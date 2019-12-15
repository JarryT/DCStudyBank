//
//  DCUerLoginManger+DCUserReuest.h
//  DCStudyBank
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCUerLoginManger.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCUerLoginManger (DCUserReuest)
//登录
+ (void)userLoginWithParms:(NSDictionary *)Parms success:(void(^)(id responseObject))sucessBlock fail:(void (^)(NSError *error, NSString *errorDescription))failBlock;

//注册
+(void)userRegisterWithParms:(NSDictionary *)parms success:(void(^)(id responseObject))sucessBlock fail:(void (^)(NSError *error, NSString *errorDescription))failBlock;

@end

NS_ASSUME_NONNULL_END
