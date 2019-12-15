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
- (instancetype)init{
    if (self = [super init]) {
        _height = 0;
    }
    return self;
}
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"optionsList":@"DCKaoDianOptionsListModel"};
    
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
- (CGFloat)height
{
    if (_height == 0) {
        UILabel *label = [[UILabel alloc] init];
        label.font = PF_R_Font(14);
        label.text = _itemname;
        CGSize size = [label sizeThatFits:CGSizeMake(KScreenWidth - 30, MAXFLOAT)];
        _height = size.height + 160;
    }
    return _height;
}
@end

@implementation DCKaoDianOptionsListModel

@end

