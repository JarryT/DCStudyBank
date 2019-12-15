
//
//  DCRegistrationInfoVC.m
//  DCStudyBank
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCRegistrationInfoVC.h"
#import "DCChooseAddress.h"
#import "DCChooseTestInfoVC.h"
@interface DCRegistrationInfoVC ()
@property (weak, nonatomic) IBOutlet UILabel *testInfo;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation DCRegistrationInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   self.navTitle = @"参加考试";
    self.navView.sepView.hidden =NO;
   self.navView.titleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    _loginBtn.layer.cornerRadius = 22;
    _loginBtn.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar navBarBottomLineHidden:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar navBarBottomLineHidden:true];
}
- (IBAction)goChooseTestInfoClick:(UIButton *)sender {
    DCChooseTestInfoVC *vc = [DCChooseTestInfoVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)chooseAddressClick:(UIButton *)sender {
    DCChooseAddress *vc = [DCChooseAddress new];
    weakSelf(self);
    vc.chooseAddressBlock = ^(NSString * _Nonnull address) {
        weakSelf.address.text = address;
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)loginBtnClick:(UIButton *)sender {
    
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
