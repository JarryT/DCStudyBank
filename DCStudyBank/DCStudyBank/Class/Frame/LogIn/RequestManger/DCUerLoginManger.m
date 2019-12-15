//
//  DCUerLoginManger.m
//  DCStudyBank
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCUerLoginManger.h"
#import "PersistManager+Archieve.h"
@implementation DCUerLoginManger
+ (DCUerLoginManger *)shareLoginInfoIntents {
    
    static DCUerLoginManger *shareIntence = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareIntence = [[DCUerLoginManger alloc] init];
        
    });
    return shareIntence;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *dict = [PersistManager objectForUser:[[NSUserDefaults standardUserDefaults]objectForKey: LastLoginUserID] withKey:UserLoginPatch];
        [self getData:dict];
    }
    return self;
}

- (void)getData:(NSDictionary *)loginInfo{
    if (!loginInfo) return;
    _isUerLogin = YES;
    NSDictionary *userDict = [loginInfo objectSafeKey:@"user"];
    _dizhi = [loginInfo objectSafeKey:@"dizhi"];
    _jwtToken = [loginInfo objectSafeKey:@"jwtToken"];
    _kemu = [loginInfo objectSafeKey:@"jkemu"];
    _kaoshi = [loginInfo objectSafeKey:@"kaoshi"];
    _headphoto = [userDict objectSafeKey:@"headphoto"];
    _userId = [userDict objectSafeKey:@"id"];
    _name = [userDict objectSafeKey:@"name"];
    _password = [userDict objectSafeKey:@"password"];
    _phone = [userDict objectSafeKey:@"phone"];
    _regional = [userDict objectSafeKey:@"regional"];
    _registerdate = [userDict objectSafeKey:@"registerdate"];
    _type = [userDict objectSafeKey:@"type"];
    
}


- (void)clearData{
    _isUerLogin = NO;
    _dizhi = @"";
    _jwtToken = @"";
    _kemu = @"";
    _kaoshi = @"";
    _phone = @"";
    _headphoto = @"";
    _userId = @"";
    _name = @"";
    _password = @"";
    _phone = @"";
    _regional = @"";
    _registerdate = @"";
    _type = @"";
    
}

- (void)deleateLocalData{
    
    [PersistManager deleteObjectForUser:[[NSUserDefaults standardUserDefaults]objectForKey: LastLoginUserID] withKey:UserLoginPatch];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LastLoginUserAccount];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LastLoginUserPSW];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LastLoginUserID];
}
@end
