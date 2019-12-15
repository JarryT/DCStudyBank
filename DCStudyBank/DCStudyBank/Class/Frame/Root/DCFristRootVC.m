//
//  DCFristRootVC.m
//  ItemBank
//
//  Created by mac on 2019/11/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCFristRootVC.h"
#import "DCLoginViewController.h"
#import "DCRootTabbarVC.h"
@interface DCFristRootVC ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnBtoomY;


@end

@implementation DCFristRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.view.backgroundColor = [UIColor redColor];
    
    _btnBtoomY.constant = kTabBarHeight-10;
    _loginBtn.layer.cornerRadius = 22;
    _loginBtn.layer.masksToBounds = true;
    _registBtn.layer.borderWidth = 1;
    _registBtn.layer.borderColor = KMainColor.CGColor;
    _registBtn.layer.cornerRadius = 22;
    _registBtn.layer.masksToBounds = YES;
    
    [self setInit];
    
}


- (void)setInit{
    UIView *leftBtnView = [[UIView alloc]initWithFrame:CGRectMake(0,0, 120, 44)];
   
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(leftBtnView.right-15,20, 15, 15)];
    imageV.image = [UIImage imageNamed:@"qid_lookmore_icon"];
    [leftBtnView addSubview:imageV];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(50,18,60, 18)];
    //lab.backgroundColor = [UIColor orangeColor];
    lab.text = @"随便看看";
    lab.font = [UIFont systemFontOfSize:13];
    lab.textColor = KMainColor;
    [leftBtnView addSubview:lab];
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(50,15,70,30)];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtnView addSubview:moreBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtnView];
    
    UIImageView *img = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:@"root_img"];
    [self.view addSubview:img];
    CGFloat Y = kTopHeight*0.5;
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(-Y);
        
    }];
    
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)moreBtnClick{
    
    UIWindow *widn = [UIApplication sharedApplication].keyWindow;
    DCRootTabbarVC *VC = [[DCRootTabbarVC alloc]init];
    widn.rootViewController = VC;
//    DCRootTabbarVC *rootVc = [[DCRootTabbarVC alloc] init];
//    [self.navigationController pushViewController:rootVc animated:YES];
    
}

- (IBAction)registBtnClick:(UIButton *)sender {
    DCLoginViewController *registVC = [DCLoginViewController new];
    registVC.type =0;
    [self.navigationController pushViewController:registVC animated:YES];
    
}

- (IBAction)logInBtnClick:(UIButton *)sender {
    DCLoginViewController *logIn = [DCLoginViewController new];
    logIn.type =1;
    [self.navigationController pushViewController:logIn animated:YES];
}


@end
