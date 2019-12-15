//
//  DCChooseTestHeaderView.m
//  DCStudyBank
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCChooseTestHeaderView.h"

#import "DCSubJectStudyModel.h"
@interface DCChooseTestHeaderView()


@property (weak, nonatomic) IBOutlet UIButton *conentBtn;
@end

@implementation DCChooseTestHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)createJMDServeMoneySetHeaerView{
    
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
- (IBAction)conetBtnCliak:(UIButton *)sender {
    if (_isShowAllBlock) {
        _isShowAllBlock();
    }
}

- (void)setM:(DCSubJectStudyObjModel *)M{
    _M = M;
    [_conentBtn setTitle:M.subname forState:UIControlStateNormal];
    if (M.isOpen) {
        _icon.transform = CGAffineTransformMakeRotation(M_PI);
    }
    
}
@end
