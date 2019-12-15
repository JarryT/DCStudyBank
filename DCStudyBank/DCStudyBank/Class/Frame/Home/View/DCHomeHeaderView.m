//
//  DCHomeHeaderView.m
//  DCStudyBank
//
//  Created by mac on 2019/11/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCHomeHeaderView.h"
#import "SYButton.h"
#import "CircleProgressView.h"
@interface DCHomeHeaderView()
@property(nonatomic,strong)UIButton *jhCenterBtn;
@property(nonatomic,strong)SYButton *titleNameBtn;
@property(nonatomic,strong) NSTimer *timer;

@end

@implementation DCHomeHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
   // self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(progressTimer:) userInfo:nil repeats:YES];
    [self setUI];
}

- (void)progressTimer:(NSTimer *)timer{
    self.circleProgress.percent += 0.05;
    self.circleProgress.centerLabel.text = [NSString stringWithFormat:@"%f%%", self.circleProgress.percent*100];
    if(self.circleProgress.percent > 0.8){
        [self.timer invalidate];
    }
}

- (void)setUI{
    _jhCenterBtn = [[UIButton alloc]init];
    _jhCenterBtn.backgroundColor = [UIColor colorWithHexString:@"#FFFDC6"];
    [_jhCenterBtn setTitle:@" 激活" forState:UIControlStateNormal];
    _jhCenterBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_jhCenterBtn setTitleColor:KMainColor forState:UIControlStateNormal];
    [_jhCenterBtn setImage:[UIImage imageNamed:@"my_jihuo_icon"] forState:UIControlStateNormal];
    [_jhCenterBtn addTarget:self action:@selector(jhCenterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:_jhCenterBtn];

    NSArray *btnArr = @[@{@"title":@"考点智能练习",@"img":@"index_kaodian_icon"},@{@"title":@"章节智能练习",@"img":@"index_zhangjie_icon"},@{@"title":@"真题模考",@"img":@"index_mokao_icon"},@{@"title":@"错题练习",@"img":@"index_lianxi_icon"},@{@"title":@"我的收藏",@"img":@"index_shoucang_icon"},@{@"title":@"练题历史",@"img":@"index_lianti_icon"},@{@"title":@"答疑社区",@"img":@"index_shequ_icon"},@{@"title":@"关于我们",@"img":@"index_aboutus_icon"}];
    
    for (int i=0; i<btnArr.count; i++) {
        NSDictionary *dict = btnArr[i];
        SYButton *itemBtn = [[SYButton alloc]init];
        itemBtn.btnType = TOP;
        [itemBtn setTitle:[dict objectForKey:@"title"] forState:UIControlStateNormal];
        [itemBtn setImage:[UIImage imageNamed:[dict objectSafeKey:@"img"]] forState:UIControlStateNormal];
        itemBtn.tag = 20+i;
        [itemBtn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn.titleLabel.font = KFont(12);
        [itemBtn setTitleColor:kMainTitleColor forState:UIControlStateNormal];
        [self.mentView addSubview:itemBtn];
    }

    [self.circleProgressView addSubview:self.circleProgress];
    self.circleProgress.percent = 0.0;
    self.circleProgress.centerLabel.text = [NSString stringWithFormat:@"%.0f%%", self.circleProgress.percent*100];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _jhCenterBtn.frame = CGRectMake(KScreenWidth-60,self.scoreLable.top,60,26);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_jhCenterBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(13, 13)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
     maskLayer.frame = _jhCenterBtn.bounds;
     maskLayer.path = maskPath.CGPath;
    _jhCenterBtn.layer.mask = maskLayer;
    _titleNameBtn.frame = CGRectMake((KScreenWidth-120)*0.5,25, 120, 50);
    CGFloat itemW = KScreenWidth/4.0;
    CGFloat itemH = _mentView.height*0.5;
    //每行列数
    NSInteger rank = 4;
    for (int i = 0 ; i< _mentView.subviews.count; i++) {
        
        SYButton *itemBtn = _mentView.subviews[i];
        //Item X轴
        CGFloat X = (i % rank) * itemW;
        //Item Y轴
        NSUInteger Y = (i / rank) * itemH;
        if (i>3) {
            Y = Y-8;
        }
        itemBtn.frame = CGRectMake(X,Y, itemW, itemH);
            
    }
    
}

//激活
- (void)jhCenterBtnClick{
    if ([_delegate respondsToSelector:@selector(studyWithJihuoCenter)]) {
        [_delegate studyWithJihuoCenter];
    }
    
}

//按钮点击事件
- (void)itemClick:(SYButton *)sender{
    
    if ([_delegate respondsToSelector:@selector(menuItemBtnClickWith:)]) {
              [_delegate menuItemBtnClickWith:sender.tag-20];
          }
}

//已学习
- (IBAction)studyBtnNumClick:(UIButton *)sender {
    
}
//总题个数
- (IBAction)totalStudyNumClick:(UIButton *)sender {
    
}

- (CircleProgressView *)circleProgress{
    if(!_circleProgress)
    {
        _circleProgress = [[CircleProgressView alloc] initWithFrame:CGRectMake((self.circleProgressView.width-82)*0.5, (self.circleProgressView.height-82)*0.5, 82, 82)];
        _circleProgress.backgroundColor = [UIColor clearColor];
        _circleProgress.progressBackgroundColor = [UIColor colorWithHexString:@"#F2F2F2" alpha:1];
        _circleProgress.progressColor = KMainColor;
        _circleProgress.progressWidth = 4;
        _circleProgress.textFont = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        _circleProgress.textColor = KMainColor;
        _circleProgress.centerTitleName.text = @"学习进度";
        _circleProgress.subTextFont = KFont(11);
        _circleProgress.subTextColor = KTextColor;
        
    }
    return _circleProgress;
}

@end
