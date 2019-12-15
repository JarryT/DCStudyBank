
//
//  DCAboutMyVC.m
//  DCStudyBank
//
//  Created by mac on 2019/11/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCAboutMyVC.h"

@interface DCAboutMyVC ()

@end

@implementation DCAboutMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImage *backGroundImage = [UIImage imageNamed:@"title_head_bg_three"];
    self.navigationController.ss_navigationBackImage = [UIImage  imageNamed:@"navigation_back_w_icon"];
    backGroundImage = [backGroundImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarMetrics:UIBarMetricsDefault];
     [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}
//版本
- (IBAction)vsersonBtnClick:(UIButton *)sender {
}

//隐私政策
- (IBAction)privacyBtnClick:(UIButton *)sender {
}

//用户意见
- (IBAction)userAdvocieBtnClick:(UIButton *)sender {
}
//好评
- (IBAction)conmmentBtnClick:(UIButton *)sender {
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
