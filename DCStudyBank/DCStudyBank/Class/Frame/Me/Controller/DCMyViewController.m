//
//  DCMyViewController.m
//  DCStudyBank
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCMyViewController.h"
#import "SYButton.h"
#import "DCMyUserHeaderView.h"
#import "DCMyNoLogInHeaderView.h"
#import "DCMySettingVC.h"
#import "DCMyNotionCenterVC.h"
#import "DCAboutMyVC.h"
#import "DCMyUseInfoVC.h"
#import "DCWrongTestVC.h"
#import "DCCollectMainVC.h"
#import "DCStudyHistoryVC.h"
#import "DCJiHuoCenterVC.h"
@interface DCMyViewController ()
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navBagH;
@property (weak, nonatomic) IBOutlet UIView *btnConentView;
@property (nonatomic,strong)DCMyUserHeaderView *loginHeaderView;
@property (nonatomic,strong)DCMyNoLogInHeaderView *nologinHeaderView;
@end

@implementation DCMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBtnView];
}

- (void)setBtnView{
    weakSelf(self);
    _loginHeaderView = [[NSBundle mainBundle] loadNibNamed:@"DCMyUserHeaderView" owner:nil options:nil].firstObject;
    _loginHeaderView.frame = CGRectMake(0,_headerView.height-100,KScreenWidth, 80);
    _loginHeaderView.loginHeaderBtnblock = ^(NSInteger integer) {
        [weakSelf logInWiyh:integer];
    };
    
   /**************未登录**************/
    _nologinHeaderView = [[NSBundle mainBundle] loadNibNamed:@"DCMyNoLogInHeaderView" owner:nil options:nil].firstObject;
    _nologinHeaderView.frame = CGRectMake(0,_headerView.height-100,KScreenWidth, 80);
    _nologinHeaderView.goLoginBtnBlock = ^{
        [weakSelf goLogin];
    };
    
    NSArray *btnArr = @[@{@"title":@"收藏",@"img":@"my_shoucang_icon"},@{@"title":@"错题",@"img":@"my_cuoti_icon"},@{@"title":@"历史",@"img":@"my_lishi_icon"},@{@"title":@"激活",@"img":@"my_shoucang_icon"}];
    CGFloat btnW = KScreenWidth/4.0;
    for (int k = 0; k < btnArr.count; k++) {
        NSDictionary *dit = btnArr[k];
        SYButton *btn = [[SYButton alloc]init];
        
        [btn setTitle:[dit objectForKey:@"title"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[dit objectForKey:@"img"]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.btnType = TOP;
        btn.frame = CGRectMake(btnW*k, 0,btnW,90);
        [btn setTitleColor:kMainTitleColor forState:UIControlStateNormal];
        btn.tag = 10+k;
        [btn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnConentView addSubview:btn];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImage *backGroundImage = [UIImage imageNamed:@"title_head_bg_three"];
    backGroundImage = [backGroundImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarMetrics:UIBarMetricsDefault];
    self.navigationController.ss_navigationBackImage = [UIImage imageNamed:@"navigation_back_w_icon"];
    
     [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBarHidden = true;
    if ([DCUerLoginManger shareLoginInfoIntents].isUerLogin) {
        [_headerView addSubview:_loginHeaderView];
           _loginHeaderView.userNike.text = [DCUerLoginManger shareLoginInfoIntents].name;
        [_loginHeaderView.headerIcon sd_setImageWithURL:[NSURL URLWithString:[DCUerLoginManger shareLoginInfoIntents].headphoto] forState:UIControlStateNormal placeholderImage:UserHeaderIconPlaceholderImage];
       
       }else{
           [_headerView addSubview:_nologinHeaderView];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

//未登录去登录
- (void)goLogin{
    
    [self loginWithType:0 manu:true];
}

//登录情况下，header上的按钮点击
-(void)logInWiyh:(NSInteger)type{
    switch (type) {
        case 12:{//用户头像
            DCMyUseInfoVC *suerInfo = [[DCMyUseInfoVC alloc]init];
            [self.navigationController pushViewController:suerInfo animated:true];
        }break;
        case 13:{//等级
        }break;
        case 14:{//激活中心
            DCJiHuoCenterVC *vc = [DCJiHuoCenterVC new];
            [self.navigationController pushViewController:vc animated:true];
        }break;
            
        default:
            break;
    }
}

//菜单栏
- (void)menuBtnClick:(UIButton *)sender{
    switch (sender.tag-10) {
        case 0:{//收藏
            DCCollectMainVC *vc = [[DCCollectMainVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 1:{//错题
            DCWrongTestVC *vc = [DCWrongTestVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 2:{//历史
            DCStudyHistoryVC *vc = [[DCStudyHistoryVC alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 3:{//激活
            DCJiHuoCenterVC *vc = [DCJiHuoCenterVC new];
            [self.navigationController pushViewController:vc animated:true];
        }break;
            
        default:
            break;
    }
}
- (IBAction)listBtnClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 20:{//通知
            DCMyNotionCenterVC *setVC = [[DCMyNotionCenterVC alloc]init];
            [self.navigationController pushViewController:setVC animated:true];
        }break;
        case 21:{//设置
            DCMySettingVC *setVC = [[DCMySettingVC alloc]init];
            [self.navigationController pushViewController:setVC animated:true];
        }break;
        case 22:{//关于题库
            DCAboutMyVC *setVC = [[DCAboutMyVC alloc]init];
            [self.navigationController pushViewController:setVC animated:true];
        }break;
        default:
            break;
    }
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
