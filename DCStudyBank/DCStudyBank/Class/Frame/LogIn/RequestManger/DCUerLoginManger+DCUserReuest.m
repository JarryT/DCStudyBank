//
//  DCUerLoginManger+DCUserReuest.m
//  DCStudyBank
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCUerLoginManger+DCUserReuest.h"
#import "DCNetworkingReultModel.h"

@implementation DCUerLoginManger (DCUserReuest)
//登录
+ (void)userLoginWithParms:(NSDictionary *)Parms success:(void(^)(id responseObject))sucessBlock fail:(void (^)(NSError *error, NSString *errorDescription))failBlock{
    [DCNetworkingRequest requestWithURLString:LogInPath params:Parms method:POST withMappingObject:nil success:^(NSDictionary *responseObject) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        sucessBlock(responseObject);
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
        failBlock(error,errorDescription);
    }];
}

//注册
+(void)userRegisterWithParms:(NSDictionary *)parms success:(void(^)(id responseObject))sucessBlock fail:(void (^)(NSError *error, NSString *errorDescription))failBlock{
    [DCNetworkingRequest requestWithURLString:RegisterPath params:parms method:POST withMappingObject:@"DCNetworkingReultModel" success:^(DCNetworkingReultModel *responseObject) {
            sucessBlock(responseObject);
       } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
           failBlock(error,errorDescription);
           
       }];
}

@end
