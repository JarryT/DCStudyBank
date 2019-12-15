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

- (BOOL)isAnswerCorrect {
    if ([self type] == ItemtypeSingle) {
        if (self.selectedOptionsList.count == 1 && [self.selectedOptionsList.firstObject.opname isEqualToString:_itemresult]) {
            return true;
        }
    } else if ([self type] == ItemtypeDouble) {
        NSArray *results = [_itemresult componentsSeparatedByString:@","];
        if (results.count == _selectedOptionsList.count) {
            for ( DCKaoDianOptionsListModel *model in _selectedOptionsList) {
                BOOL isThisAnswerCorect = false;
                for (NSString *result in results) {
                    if ([result isEqualToString: model.opname]) {
                        isThisAnswerCorect = true;
                        break;
                    }
                }
                if (!isThisAnswerCorect) {
                    return false;
                }
            }
            return true;
        }
    }
    return false;
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

