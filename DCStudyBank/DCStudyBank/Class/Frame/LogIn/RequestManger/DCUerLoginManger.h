//
//  DCUerLoginManger.h
//  DCStudyBank
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCUerLoginManger : NSObject
@property (nonatomic,assign) BOOL isUerLogin;
@property (nonatomic,copy) NSString *dizhi;
@property (nonatomic,copy) NSString *jwtToken;
@property (nonatomic,copy) NSString *kemu;
@property (nonatomic,copy) NSString *kaoshi;
//用户数据
@property(nonatomic,strong)NSString *headphoto;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *regional;
@property(nonatomic,strong)NSString *registerdate;
@property(nonatomic,strong)NSString *type;

+ (DCUerLoginManger *)shareLoginInfoIntents;
- (void)getData:(NSDictionary *)loginInfo;
- (void)clearData;
- (void)deleateLocalData;
@end

NS_ASSUME_NONNULL_END
