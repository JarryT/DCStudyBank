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

- (BOOL)isOptionCorrect:(DCKaoDianOptionsListModel *)option {
    NSArray *results = [_itemresult componentsSeparatedByString:@","];
    BOOL isThisAnswerCorect = false;
    for (NSString *result in results) {
        if ([result isEqualToString: option.opname]) {
            isThisAnswerCorect = true;
            break;
        }
    }
    return isThisAnswerCorect;
}

- (CGFloat)footerHeight {
    if (!_footerHeight) {
        _footerHeight = [self.itemjiexi boundingRectWithSize:CGSizeMake(KScreenWidth - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size.height + 125;
    }
    return _footerHeight;
}

- (NSMutableArray *)selectedOptionsList {
    if (!_selectedOptionsList) {
        _selectedOptionsList = [NSMutableArray array];
    }
    return  _selectedOptionsList;
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

