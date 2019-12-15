

//
//  DCJoinStudyMangerModel.m
//  DCStudyBank
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCJoinStudyMangerModel.h"

@implementation DCJoinStudyMangerModel
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"obj":[DCListModel class],
             };
}
@end

@implementation DCListModel : NSObject
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"list":[DCObjModel class],
             };
}
@end

@implementation DCObjModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"studyId":@"id"};
    
}
@end
