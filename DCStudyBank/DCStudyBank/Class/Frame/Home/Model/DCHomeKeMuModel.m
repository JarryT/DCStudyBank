//
//  DCHomeKeMuModel.m
//  DCStudyBank
//
//  Created by mac on 2019/12/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCHomeKeMuModel.h"

@implementation DCHomeKeMuModel

@end

@implementation DCHomeObjModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"kemu":[DCkemuListModel class]};
}

@end

@implementation DCkemuListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"kemuId":@"id"};
}

@end
