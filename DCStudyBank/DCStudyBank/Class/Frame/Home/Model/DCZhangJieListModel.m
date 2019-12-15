//
//  DCZhangJieListModel.m
//  DCStudyBank
//
//  Created by mac on 2019/12/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCZhangJieListModel.h"

@implementation DCZhangJieListModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"obj":@"DCZhangJieObjModel"};
}
@end
@implementation DCZhangJieObjModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"optionsList":@"DCZhangJieOptionsModel"};
}
@end
@implementation DCZhangJieOptionsModel

@end
