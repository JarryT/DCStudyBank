
//
//  DCMySettingVC.m
//  DCStudyBank
//
//  Created by mac on 2019/11/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCMySettingVC.h"
#import "DCFristRootVC.h"
#import "DCChooseTestInfoVC.h"
#import "DCChooseAddress.h"
#import "DCStudySubjectMangerVC.h"
@interface DCMySettingVC ()
@property (weak, nonatomic) IBOutlet UILabel *kaoShiKeMu;

@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@end

@implementation DCMySettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImage *backGroundImage = [UIImage imageNamed:@"title_head_bg_three"];
    backGroundImage = [backGroundImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarMetrics:UIBarMetricsDefault];
    
     [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _addressLable.text = [DCUerLoginManger shareLoginInfoIntents].regional;
}

//报考科目
- (IBAction)chooseStudyClick:(UIButton *)sender {
    weakSelf(self);
    DCChooseTestInfoVC *vc = [[DCChooseTestInfoVC alloc]init];
    vc.saveStudySubJectBlock = ^(NSString *string) {
        weakSelf.kaoShiKeMu.text = string;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

//报考科目管理
- (IBAction)chooseStudyMangerClick:(UIButton *)sender {
   
    DCStudySubjectMangerVC *vc = [[DCStudySubjectMangerVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


//选择区域
- (IBAction)chooseAreBtnClick:(UIButton *)sender {
    DCChooseAddress *addreVC = [[DCChooseAddress alloc]init];
    [self.navigationController pushViewController:addreVC animated:YES];
}


//退出登录
- (IBAction)logOutBtnClick:(UIButton *)sender {
    weakSelf(self);
    AlertView *alt = [[AlertView alloc]initWithIconName:@"" title:@"温馨提示" content:@"确定要退出登录？" isSingleAction:NO cancelBlock:^{
               
           } doneBlock:^{
            [[DCUerLoginManger shareLoginInfoIntents] clearData];
            [[DCUerLoginManger shareLoginInfoIntents] deleateLocalData];
            UIViewController *rootVC = [[DCFristRootVC alloc]init];
              
            DCNavigationVC *nav = [[DCNavigationVC alloc]initWithRootViewController:rootVC];
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
               
    }];
    [alt showTo:self.navigationController.view];
   
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
