//
//  DCMyUserHeaderView.m
//  DCStudyBank
//
//  Created by mac on 2019/11/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCMyUserHeaderView.h"

@interface DCMyUserHeaderView()
@property(nonatomic,strong)UIButton *jhCenterBtn;
@end

@implementation DCMyUserHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    _levBtn.layer.cornerRadius = 10;
    _levBtn.layer.masksToBounds = true;
    
    _jhCenterBtn = [[UIButton alloc]init];
    _jhCenterBtn.backgroundColor = [UIColor colorWithHexString:@"#FFFDC6"];
    [_jhCenterBtn setTitle:@" 激活中心" forState:UIControlStateNormal];
    _jhCenterBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_jhCenterBtn setTitleColor:KMainColor forState:UIControlStateNormal];
    [_jhCenterBtn setImage:[UIImage imageNamed:@"my_jihuo_icon"] forState:UIControlStateNormal];
    [_jhCenterBtn addTarget:self action:@selector(jhCenterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_jhCenterBtn];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _jhCenterBtn.frame = CGRectMake(KScreenWidth-85,(self.height-26)*0.5,85,26);
     UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_jhCenterBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(13, 13)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
     maskLayer.frame = _jhCenterBtn.bounds;
     maskLayer.path = maskPath.CGPath;
     _jhCenterBtn.layer.mask = maskLayer;

    
}
- (IBAction)userHeaderIconBtnClick:(UIButton *)sender {
    if (_loginHeaderBtnblock) {
        _loginHeaderBtnblock(12);
    }
}
- (IBAction)levBtnClick:(UIButton *)sender {
    if (_loginHeaderBtnblock) {
        _loginHeaderBtnblock(13);
    }
}

- (void)jhCenterBtnClick:(UIButton *)sender {
    if (_loginHeaderBtnblock) {
        _loginHeaderBtnblock(14);
    }
}

@end
