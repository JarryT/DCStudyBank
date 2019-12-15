
//
//  DCSubJectStudyModel.m
//  DCStudyBank
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCSubJectStudyModel.h"

@implementation DCSubJectStudyModel
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"obj":[DCSubJectStudyObjModel class],
             };
}
@end
@implementation DCSubJectStudyObjModel
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"twoList":[DCSubJectStudyTwoListModel class],
             };
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"keMuId":@"id"};
    
}

@end
@implementation DCSubJectStudyTwoListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"studyId":@"id"};
    
}
@end
