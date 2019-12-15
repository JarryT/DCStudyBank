//
//  DCMyNoLogInHeaderView.m
//  DCStudyBank
//
//  Created by mac on 2019/11/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCMyNoLogInHeaderView.h"
@interface DCMyNoLogInHeaderView()
@property (strong, nonatomic)UIButton *loginBtn;

@end
@implementation DCMyNoLogInHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _loginBtn = [[UIButton alloc]init];
    _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [_loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_loginBtn setTitleColor:KMainColor forState:UIControlStateNormal];
    _loginBtn.layer.cornerRadius = 16;
    _loginBtn.layer.masksToBounds = true;
    [_loginBtn addTarget:self action:@selector(goLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _loginBtn.frame = CGRectMake(KScreenWidth-111,(self.height-32)*0.5,95, 32);
}
- (void)goLoginBtnClick:(UIButton *)sender {
    if (_goLoginBtnBlock) {
        _goLoginBtnBlock();
    }
}

@end
