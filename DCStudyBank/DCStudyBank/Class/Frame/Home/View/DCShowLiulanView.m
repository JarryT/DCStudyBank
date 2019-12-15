//
//  DCShowLiulanView.m
//  DCStudyBank
//
//  Created by mac on 2019/12/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCShowLiulanView.h"
#import "EBCustomBannerView.h"
@interface DCShowLiulanView()
@property (weak, nonatomic) IBOutlet SYButton *baiTianBtn;
@property (weak, nonatomic) IBOutlet SYButton *wanSBtn;
@property (weak, nonatomic) IBOutlet SYButton *fontMax;
@property (weak, nonatomic) IBOutlet SYButton *fontMil;

@end

@implementation DCShowLiulanView

- (void)awakeFromNib{
    [super awakeFromNib];
    _baiTianBtn.btnType = TOP;
    [_baiTianBtn setTitle:@"白天模式" forState:UIControlStateNormal];
    [_baiTianBtn setTitleColor:KMainColor forState:UIControlStateNormal];
    _wanSBtn.btnType = TOP;
    [_wanSBtn setTitle:@"夜间模式" forState:UIControlStateNormal];
    [_wanSBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    
    _fontMax.btnType = TOP;
    [_fontMax setTitle:@"字体增大" forState:UIControlStateNormal];
    [_fontMax setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    _fontMil.btnType = TOP;
    [_fontMil setTitle:@"字体减小" forState:UIControlStateNormal];
    [_fontMil setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    
}
- (IBAction)scanceClick:(UIButton *)sender {
     [self removeFromSuperview];
}

- (void)setCustomView:(EBCustomBannerView *)customView{
    _customView = customView;
    [customView hide];
}

- (IBAction)fontMile:(SYButton *)sender {
    if (_setUiStyleBlock) {
        _setUiStyleBlock(4);
    }
}
- (IBAction)fontMax:(SYButton *)sender {
    if (_setUiStyleBlock) {
        _setUiStyleBlock(3);
    }
}
- (IBAction)baiTainBtn:(SYButton *)sender {
    if (_setUiStyleBlock) {
        _setUiStyleBlock(1);
    }
}
- (IBAction)nightBtn:(SYButton *)sender {
    if (_setUiStyleBlock) {
           _setUiStyleBlock(2);
       }
}

@end
