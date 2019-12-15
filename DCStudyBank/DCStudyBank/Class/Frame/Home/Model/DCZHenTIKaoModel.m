
//
//  DCZHenTIKaoModel.m
//  DCStudyBank
//
//  Created by mac on 2019/12/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCZHenTIKaoModel.h"

@implementation DCZHenTIKaoModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"obj":@"DCZHenTIKaoObjModel"};
}
@end
@implementation DCZHenTIKaoObjModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"itemBeans":@"DCZHenTIKaoItemBeansModel"};
}
@end

@implementation DCZHenTIKaoItemBeansModel

@end
