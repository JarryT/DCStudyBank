//
//  DCTestInfoGroupModel.m
//  DCStudyBank
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCTestInfoGroupModel.h"

@implementation DCTestInfoGroupModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"list":@"DCTestInfoListModel"};
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isOpen = NO;
    }
    return self;
}

@end

@implementation DCTestInfoListModel

@end
