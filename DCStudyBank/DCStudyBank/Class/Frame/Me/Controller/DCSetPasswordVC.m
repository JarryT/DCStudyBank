//
//  DCSetPasswordVC.m
//  DCStudyBank
//
//  Created by mac on 2019/12/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCSetPasswordVC.h"

@interface DCSetPasswordVC ()<UITextFieldDelegate>{
     NSInteger counts;
}
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UITextField *newsPasswoed;
@end

@implementation DCSetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"修改密码";
    self.navView.titleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    self.navView.sepView.hidden =NO;
    self.oldPassword.delegate = self;
    self.newsPasswoed.delegate = self;
    _sureBtn.layer.cornerRadius = 22;
    _sureBtn.layer.masksToBounds = YES;
    _sureBtn.backgroundColor = [UIColor colorWithHexString:@"#00C0AE" alpha:0.4];
    _sureBtn.userInteractionEnabled = NO;
    
}
- (IBAction)sureBtnClick:(UIButton *)sender {
    
      if (self.oldPassword.text.length == 0) {
                [MBProgressHUD showError:@"请输入旧密码"];
                return;
            }
      if (self.oldPassword.text.length<6) {
                [MBProgressHUD showError:@"输入密码应大于6位"];
                return;
      }
      if (![self.oldPassword.text isPassword]) {
                [MBProgressHUD showError:@"旧密码不合法"];
                return;
      }
      if (self.newsPasswoed.text.length == 0) {
                [MBProgressHUD showError:@"请输入新密码"];
                return;
      }
      if (self.newsPasswoed.text.length<6) {
                [MBProgressHUD showError:@"输入密码应大于6位"];
                return;
      }
      if (![self.newsPasswoed.text isPassword]) {
          [MBProgressHUD showError:@"新密码密码不合法"];
          return;
      }
    weakSelf(self);
        [self.newsPasswoed resignFirstResponder];
         [self.oldPassword resignFirstResponder];
         [MBProgressHUD showLoadingCustomtoView:ApplicationKeyWindow animated:YES];
         [DCNetworkingRequest requestWithURLString:SetPasswordPath params:@{@"pwd":self.oldPassword.text,@"password":self.newsPasswoed.text} method:POST withMappingObject:@"DCNetworkingReultModel" success:^(DCNetworkingReultModel *responseObject) {
             [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
             if (responseObject.code == 200) {
                
                 [MBProgressHUD showSuccess:@"密码修改成功,下次新密登录"];
                 [weakSelf.navigationController popViewControllerAnimated:YES];
             }else{
                 [MBProgressHUD showError:responseObject.msg];
             }
         } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
             [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
             [MBProgressHUD showError:errorDescription];
         }];

    
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
        if (self.oldPassword.text.length > 0 && self.newsPasswoed.text.length > 0) {
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
