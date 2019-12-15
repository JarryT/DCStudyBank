//
//  DCZhangJieAltView.m
//  DCStudyBank
//
//  Created by mac on 2019/12/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCZhangJieAltView.h"

@interface DCZhangJieAltView()
@property (weak, nonatomic) IBOutlet UIView *conetV;
@property (weak, nonatomic) IBOutlet SYButton *btn1;
@property (weak, nonatomic) IBOutlet SYButton *btn2;
@property (weak, nonatomic) IBOutlet SYButton *btn3;
@property (nonatomic,strong)SYButton *stlectBtn;
@end
@implementation DCZhangJieAltView

- (void)awakeFromNib{
    [super awakeFromNib];
    _conetV.layer.cornerRadius = 6;
    _conetV.layer.masksToBounds = YES;
    [_btn1 setTitle:@"刷题模式" forState:UIControlStateNormal];
    [_btn1 setImage:[UIImage imageNamed:@"baokao_more_icon"] forState:UIControlStateNormal];
    _btn1.btnType = RIGHT;
    [_btn2 setTitle:@"智能模式" forState:UIControlStateNormal];
    [_btn2 setImage:[UIImage imageNamed:@"baokao_more_icon"] forState:UIControlStateNormal];
    _btn2.btnType = RIGHT;
    [_btn3 setTitle:@"自学模式" forState:UIControlStateNormal];
    [_btn3 setImage:[UIImage imageNamed:@"baokao_more_icon"] forState:UIControlStateNormal];
    _btn3.btnType = RIGHT;
    _stlectBtn = _btn1;
    [_stlectBtn setTitleColor:KMainColor forState:UIControlStateNormal];
  
}
- (IBAction)btn1Click:(SYButton *)sender {
    if ([sender isEqual:_stlectBtn]) {
        return;
    }else{
        [_stlectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _stlectBtn = _btn1;
        [_stlectBtn setTitleColor:KMainColor forState:UIControlStateNormal];
    }
    if (_btnBlock) {
        _btnBlock(@"刷题模式",1);
    }
}
- (IBAction)btn2Click:(id)sender {
    if ([sender isEqual:_stlectBtn]) {
        return;
    }else{
        [_stlectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _stlectBtn = _btn2;
        [_stlectBtn setTitleColor:KMainColor forState:UIControlStateNormal];
    }
    if (_btnBlock) {
              _btnBlock(@"智能模式",2);
    }
  
}

- (IBAction)btn3Click:(SYButton *)sender {
    if ([sender isEqual:_stlectBtn]) {
        return;
    }else{
        [_stlectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _stlectBtn = _btn3;
        [_stlectBtn setTitleColor:KMainColor forState:UIControlStateNormal];
    }
    if (_btnBlock) {
           _btnBlock(@"自学模式",3);
    }
}

- (IBAction)scanceBtnClick:(UIButton *)sender {
     if (_btnBlock) {
            _btnBlock(@"",0);
       }
}

@end
