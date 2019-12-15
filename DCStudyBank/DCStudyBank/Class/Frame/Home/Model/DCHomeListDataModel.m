//
//  DCHomeListDataModel.m
//  DCStudyBank
//
//  Created by mac on 2019/12/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCHomeListDataModel.h"

@implementation DCHomeListDataModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"group":@"DCHomeGroupModel"};
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

@implementation DCHomeGroupModel



@end
