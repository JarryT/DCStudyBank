//
//  DCAgainSetPasswordVC.m
//  DCStudyBank
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCAgainSetPasswordVC.h"

@interface DCAgainSetPasswordVC ()<UITextFieldDelegate>{
     NSInteger counts;
}
@property (weak, nonatomic) IBOutlet UITextField *newpassword;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UITextField *surePassword;


@end

@implementation DCAgainSetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"填写密码";
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 40, 40)];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    _sureBtn.layer.cornerRadius = 22;
    _sureBtn.layer.masksToBounds = YES;
    _sureBtn.backgroundColor = [UIColor colorWithHexString:@"#00C0AE" alpha:0.4];
    _sureBtn.userInteractionEnabled = NO;
    _newpassword.delegate = self;
    _surePassword.delegate = self;
}
- (void)backBtnClick{
   
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sureSetPasswordClick:(UIButton *)sender {
     if (self.newpassword.text.length == 0) {
              [MBProgressHUD showError:@"请输入新密码"];
              return;
          }
    if (self.newpassword.text.length<6) {
              [MBProgressHUD showError:@"输入密码应大于6位"];
              return;
    }
    if (![self.newpassword.text isPassword]) {
              [MBProgressHUD showError:@"密码不合法"];
              return;
    }
    if (self.surePassword.text.length == 0) {
              [MBProgressHUD showError:@"请输入确认密码"];
              return;
    }
    if (self.surePassword.text.length<6) {
              [MBProgressHUD showError:@"输入密码应大于6位"];
              return;
    }
    if (![self.surePassword.text isPassword]) {
        [MBProgressHUD showError:@"密码不合法"];
        return;
    }
    if (![self.surePassword.text isEqualToString:self.newpassword.text]) {
        [MBProgressHUD showError:@"新密码和确认密码不一致"];
              return;
    }
    weakSelf(self);
    [self.surePassword resignFirstResponder];
    [self.newpassword resignFirstResponder];
    [MBProgressHUD showLoadingCustomtoView:ApplicationKeyWindow animated:YES];
    [DCNetworkingRequest requestWithURLString:AgainSetPasswordPath params:@{@"phone":_phone,@"password":self.surePassword.text} method:POST withMappingObject:@"DCNetworkingReultModel" success:^(DCNetworkingReultModel *responseObject) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        if (responseObject.code == 200) {
            [weakSelf backGologin];
            [MBProgressHUD showSuccess:@"密码重置成功请重新登录"];
        }else{
            [MBProgressHUD showError:responseObject.msg];
        }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        [MBProgressHUD showError:errorDescription];
    }];

    
}

- (void)backGologin{
    if (self.navigationController.viewControllers.count >= 2) {
        UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:1];
        [self.navigationController popToViewController:vc animated:YES];
    }
    
}


#pragma mark-UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
       if (textField.tag) {
           switch (textField.tag) {
               case 23:{
                   counts = 16;
               }break;
               case 24:{
                   counts = 16;
               }break;
               default:
                   break;
           }
    }
    
    NSString *temp = [textField.text stringByReplacingCharactersInRange:range
                                                                withString:string];
    NSInteger isInputlen = counts - temp.length;
    NSString *newTextField = textField.text;
    if (!(newTextField.length == 1 && string.length == 0)) {
            ///< 输入操作，设置按钮高亮方法，或者其他控件颜色方法
        if (self.newpassword.text.length > 0 && self.surePassword.text.length > 0) {
                 _sureBtn.userInteractionEnabled =YES;
                 _sureBtn.backgroundColor = [UIColor colorWithHexString:@"#00C0AE" alpha:1];
        }
           
    } else {
            ///< 删除操作，设置按钮灰色方法，或者其他控件颜色方法
             _sureBtn.userInteractionEnabled =NO;
             _sureBtn.backgroundColor = [UIColor colorWithHexString:@"#00C0AE" alpha:0.4];
    }
   
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
