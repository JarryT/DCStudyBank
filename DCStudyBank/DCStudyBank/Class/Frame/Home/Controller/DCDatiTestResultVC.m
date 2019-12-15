//
//  DCDatiTestResultVC.m
//  DCStudyBank
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCDatiTestResultVC.h"
#import "CircleProgressView.h"
@interface DCDatiTestResultVC ()
@property (weak, nonatomic) IBOutlet UILabel *titlNa;
@property (weak, nonatomic) IBOutlet CircleProgressView *circleProgreV;
@property (weak, nonatomic) IBOutlet UIView *conetView;
@property (weak, nonatomic) IBOutlet UIButton *cheackAllJxBtn;
@property (weak, nonatomic) IBOutlet UIButton *cheackWoringBtn;

@end

@implementation DCDatiTestResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"练习报告";
    self.navView.titleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    self.navView.backView2.backgroundColor = [UIColor whiteColor];
    [self initWithConet];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isShowBgImag = NO;
    self.isShowWhiteImg = NO;
}

- (void)initWithConet{
    _titlNa.layer.cornerRadius = 10;
    _titlNa.layer.masksToBounds = YES;
    _circleProgreV.percent = 0.3;
    _circleProgreV.backgroundColor = [UIColor clearColor];
    _circleProgreV.progressBackgroundColor = [UIColor colorWithHexString:@"#F2F2F2" alpha:1];
    _circleProgreV.progressColor = KMainColor;
    _circleProgreV.progressWidth = 4;
    _circleProgreV.textFont = KFont(30);
    _circleProgreV.textColor = KMainColor;
    _circleProgreV.subTextFont = KFont(11);
    _circleProgreV.subTextColor = KTextColor;
    self.circleProgreV.centerLabel.text = @"10";
    _circleProgreV.centerTitleName.text = @"共200道";
    _cheackAllJxBtn.layer.cornerRadius = 20;
    _cheackAllJxBtn.layer.masksToBounds = YES;
    _cheackWoringBtn.layer.cornerRadius = 20;
    _cheackWoringBtn.layer.masksToBounds = YES;
    
}

//查看所有解析
- (IBAction)cheackAllJxBtnClick:(UIButton *)sender {
}

//查看错误
- (IBAction)cheackWrongBtnClick:(UIButton *)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
