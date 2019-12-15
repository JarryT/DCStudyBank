//
//  DCKaoDianModel.m
//  DCStudyBank
//
//  Created by mac on 2019/12/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCKaoDianModel.h"

@implementation DCKaoDianModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"obj":@"DCKaoDianObjModel"};
}

@end
@implementation DCKaoDianObjModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"optionsList":@"DCKaoDianOptionsListModel"};
    
}

- (Itemtype)type {
    //只有两个选项
    if ([_itemtype isEqualToString: @"单选"]) {
        return ItemtypeSingle;
    } else {
        return ItemtypeDouble;
    }
}

- (BOOL)isSelected {
    return self.selectedOptionsList.count > 0;
}

- (NSMutableArray *)selectedOptionsList {
    if (!_selectedOptionsList) {
        _selectedOptionsList = [NSMutableArray array];
    }
    return  _selectedOptionsList;
}

- (NSString *)isZhengQue{
    if (!_isZhengQue) {
        _isZhengQue = @"2";
    }
    return _isZhengQue;
}
- (NSString *)userAnwer{
    if (!_userAnwer) {
        _userAnwer = @"";
    }
    return _userAnwer;
}
@end

@implementation DCKaoDianOptionsListModel

@end

