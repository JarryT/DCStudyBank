//
//  DCMyUseInfoVC.m
//  DCStudyBank
//
//  Created by mac on 2019/11/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCMyUseInfoVC.h"
#import "DCSetPasswordVC.h"
@interface DCMyUseInfoVC ()<UITextFieldDelegate>{
    NSString *sex;
    NSString *nike;
}
@property (weak, nonatomic) IBOutlet UIButton *headerIconBtn;
@property (weak, nonatomic) IBOutlet UITextField *nikeTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;//男
@property (weak, nonatomic) IBOutlet UIButton *wmanBtn;//女
@property (weak, nonatomic) IBOutlet UIView *levContentView;
@property (weak, nonatomic) IBOutlet UILabel *moneyNum;
@property (weak, nonatomic) IBOutlet UIView *levIndexView;
@property (nonatomic,strong)UILabel *levLable;
@property (nonatomic,strong)UIView *levView;

@end

@implementation DCMyUseInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人资料";
    [self setInitWith];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImage *backGroundImage = [UIImage imageNamed:@"title_head_bg_three"];
    self.navigationController.ss_navigationBackImage = [UIImage  imageNamed:@"navigation_back_w_icon"];
    backGroundImage = [backGroundImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];

}

- (void)setInitWith{
    
    _nikeTextFiled.text = [DCUerLoginManger shareLoginInfoIntents].name;
    _headerIconBtn.layer.cornerRadius = 20;
    _headerIconBtn.layer.masksToBounds = true;
    _levLable = [[UILabel alloc]init];
    [_levContentView addSubview:_levLable];
    _levLable.textColor = [UIColor colorWithHexString:@"#999999"];
    _levLable.text = @"学渣Lv1";
    _levLable.font = KFont(11);
    [_levLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.levIndexView.mas_left).offset(-8);
        make.centerY.equalTo(self.levContentView.mas_centerY);
    }];
    _levView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.levIndexView.width*0.3,2)];
    _levView.backgroundColor = [UIColor orangeColor];
    [self.levIndexView addSubview:_levView];
    _manBtn.selected = YES;
    _nikeTextFiled.delegate = self;
    
    UIButton *savBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    savBtn.titleLabel.font = KFont(15);
    [savBtn setTitle:@"保存" forState:UIControlStateNormal];
    [savBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [savBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:savBtn];
    
}

//保存
- (void)saveBtnClick{
    
    if ([self.nikeTextFiled.text isEqualToString:[DCUerLoginManger shareLoginInfoIntents].name]) {
        [MBProgressHUD showError:@"请修改昵称再保存"];
        return;
    }
    BOOL isSure = [NSString checkisChinaese:self.nikeTextFiled.text];
    if (!isSure) {
        [MBProgressHUD showError:@"输入内容不合法"];
        return;
    }
    [MBProgressHUD showLoadingCustomtoView:ApplicationKeyWindow animated:YES];
    weakSelf(self);
    [DCNetworkingRequest requestWithURLString:SetUserInfoPath params:@{@"name":self.nikeTextFiled.text} method:POST withMappingObject:@"DCNetworkingReultModel" success:^(DCNetworkingReultModel *responseObject) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        if (responseObject.code == 200) {
            [DCUerLoginManger shareLoginInfoIntents].name = weakSelf.nikeTextFiled.text;
            [MBProgressHUD showSuccess:responseObject.msg];
        }else{
            [MBProgressHUD showError:responseObject.msg];
        }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        [MBProgressHUD showError:errorDescription];
    }];

    
}


//设置头像
- (IBAction)setHeaderImageBtnClick:(UIButton *)sender {
    weakSelf(self);
    [[YTCameraAndPhotoManager shareUploadImage] showActionSheetInFatherViewController:weakSelf imageBlock:^(UIImage *image) {
        [weakSelf setUserHeaderIcon:image];
    }];
}

- (void)setUserHeaderIcon:(UIImage *)userImg{
    
    weakSelf(self);
    [MBProgressHUD showLoadingCustomtoView:ApplicationKeyWindow animated:YES];
    [DCNetworkingRequest postUploadImageAndVideoToPath:UpateUserHeaderIconPath uploadImage:userImg method:POST withMappingObject:@"DCNetworkingReultModel" success:^(DCNetworkingReultModel *responseObject) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        if (responseObject.code == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                  [weakSelf.headerIconBtn setImage:userImg forState:UIControlStateNormal];
                [MBProgressHUD showSuccess:@"更换成功"];
              });
        }else{
            [MBProgressHUD showError:responseObject.msg];
        }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
        [MBProgressHUD showError:@"更换失败,请稍后再试"];
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
    }];
  
}

//女
- (IBAction)wmanBtnClick:(UIButton *)sender {
    sender.selected = YES;
    _manBtn.selected = NO;
}
//男
- (IBAction)manBtnClick:(UIButton *)sender {
    sender.selected = YES;
    _wmanBtn.selected = NO;
}

//等级说明
- (IBAction)leaveBtnClick:(UIButton *)sender {

}

//修改密码
- (IBAction)setPasswordBtnClick:(UIButton *)sender {
    DCSetPasswordVC *vc = [[DCSetPasswordVC alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}


#pragma mark-UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
       
    
    NSString *temp = [textField.text stringByReplacingCharactersInRange:range
                                                                withString:string];
    NSInteger isInputlen = 15 - temp.length;
    if (isInputlen >= 0) {
        return YES;
    }else{
        NSInteger len = string.length + isInputlen;
               NSRange rg = {0,MAX(len, 0)};
        if (rg.length > 0) {
                   NSString *strtext = [string substringWithRange:rg];
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:strtext]];
        }
        return NO;
        
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
