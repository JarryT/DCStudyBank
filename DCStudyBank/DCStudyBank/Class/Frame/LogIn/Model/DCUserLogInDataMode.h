//
//  DCUserLogInDataMode.h
//  DCStudyBank
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCNetworkingReultModel.h"

NS_ASSUME_NONNULL_BEGIN
@class DCUserLogInObjMode;
@interface DCUserLogInDataMode : DCNetworkingReultModel
@property(nonatomic,strong)DCUserLogInObjMode *obj;
@end

@class DCUserLogUserModel;
@interface DCUserLogInObjMode : NSObject
@property(nonatomic,strong)NSString *dizhi;
@property(nonatomic,strong)NSString *jwtToken;
@property(nonatomic,strong)DCUserLogUserModel *user;
@end

@interface DCUserLogUserModel : NSObject
@property(nonatomic,strong)NSString *headphoto;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *regional;
@property(nonatomic,strong)NSString *registerdate;
@property(nonatomic,strong)NSString *type;
@end


NS_ASSUME_NONNULL_END
