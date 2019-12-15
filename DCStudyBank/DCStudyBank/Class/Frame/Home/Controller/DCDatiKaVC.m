//
//  DCDatiKaVC.m
//  DCStudyBank
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCDatiKaVC.h"
#import "DCDatiTestResultVC.h"
@interface DCDatiKaVC ()
@property (weak, nonatomic) IBOutlet UIView *conetView;
@property(nonatomic,strong)UIScrollView *scrllV;
@property(nonatomic,assign)CGFloat conetH;
@end

@implementation DCDatiKaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"考点智能练习";
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
    _conetH = 0;
    _scrllV = [[UIScrollView alloc]initWithFrame:self.conetView.bounds];
    [self.conetView addSubview:_scrllV];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 15,200, 20)];
    lab.text = @"快速智能练习";
    lab.font = KFont(14);
    [self.scrllV addSubview:lab];
    _conetH = lab.bottom;
    UIView *singleBgView = [[UIView alloc] init];
        
    [self.scrllV addSubview:singleBgView];
           
    NSInteger number = 1;
           
    UIButton *lastBtn = nil;
    for (int k = 0; k < 15; k++) {
        
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
                   
        [singleBgView addSubview:btn];
                   
        CGFloat top;
        if(lastBtn == nil) {
            top = 10;
        } else if (lastBtn.right + 40 > KScreenWidth) {
            top = lastBtn.bottom + 10;
            number++;
        } else{
            top = lastBtn.top;
        }
        
        btn.frame = CGRectMake(lastBtn == nil ? 20 : lastBtn.right + 40 > KScreenWidth ? 20 : lastBtn.right + 20, top, 30, 30);
        btn.layer.cornerRadius = 15;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor colorWithHexString:@"#AAAAAA" alpha:1].CGColor;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor colorWithHexString:@"#222222" alpha:1] forState:UIControlStateNormal];
        btn.titleLabel.font = KFont(14);
        NSInteger inde = k+1;
        [btn setTitle:[NSString stringWithFormat:@"%ld",inde] forState:UIControlStateNormal];
        lastBtn = btn;
                   
    }
    singleBgView.frame = CGRectMake(0, lab.bottom + 5, KScreenWidth, number * 50);

    _conetH = singleBgView.bottom + 5;
    
}
//确认提交
- (IBAction)suerTijiaoBtnClick:(UIButton *)sender {
    
    DCDatiTestResultVC *vc = [[DCDatiTestResultVC alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
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
