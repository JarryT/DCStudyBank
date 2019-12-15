//
//  DCForgetPasswordVC.m
//  DCStudyBank
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCForgetPasswordVC.h"
#import "DCAgainSetPasswordVC.h"
@interface DCForgetPasswordVC ()<UITextFieldDelegate>{
     NSInteger counts;
}
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UIButton *cheackBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UITextField *cheackNum;

@end

@implementation DCForgetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"填写手机号";
    _nextBtn.layer.cornerRadius = 22;
    _nextBtn.layer.masksToBounds = YES;
    _nextBtn.backgroundColor = [UIColor colorWithHexString:@"#00C0AE" alpha:0.4];
    _nextBtn.userInteractionEnabled = NO;
    _phone.delegate = self;
    _cheackNum.delegate = self;
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 40, 40)];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}

- (IBAction)nextBtnClick:(UIButton *)sender {
    if (self.phone.text.length == 0 && self.cheackNum.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号和验证码"];
        return;
    }
    DCAgainSetPasswordVC *vc = [DCAgainSetPasswordVC new];
    vc.phone = self.phone.text;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)cheackBtnClick:(UIButton *)sender {
    if (self.phone.text.length == 0) {
           [MBProgressHUD showError:@"请输入手机号"];
           return;
       }else if (self.phone.text.length != 11){
           [MBProgressHUD showError:@"请输入正确手机号"];
           return;
    }
    weakSelf(self);
    [MBProgressHUD showLoadingCustomtoView:ApplicationKeyWindow animated:YES];
    [self.phone resignFirstResponder];
    [self.cheackNum resignFirstResponder];
    [DCNetworkingRequest requestWithURLString:ForgetPasswordPhoneCodePath params:@{@"phone":self.phone.text} method:POST withMappingObject:@"DCNetworkingReultModel" success:^(DCNetworkingReultModel *responseObject) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        if (responseObject.code == 200) {
            [weakSelf statTime];
            [MBProgressHUD showSuccess:@"验证码发送成功"];
        }else{
            [MBProgressHUD showError:responseObject.msg];
        }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        [MBProgressHUD showError:errorDescription];
    }];
   
}

- (void)statTime{
    [[DCCountDownTime sharedYaydTXCountDownTime] startWithTime:60 title:@"获取验证码" countDownTitle:@"s重新获取" mainColor:[UIColor whiteColor] countColor:KMainColor atBtn:self.cheackBtn isHidden:false titleColor:[UIColor colorWithHexString:@"#BDBDBD" alpha:1] completeBlock:nil];
}

#pragma mark-UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
       if (textField.tag) {
           switch (textField.tag) {
               case 21:{
                   counts = 11;
               }break;
               case 22:{
                   counts = 6;
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
        if (self.phone.text.length > 0 && self.cheackNum.text.length > 0) {
                 _nextBtn.userInteractionEnabled =YES;
                 _nextBtn.backgroundColor = [UIColor colorWithHexString:@"#00C0AE" alpha:1];
        }
           
    } else {
            ///< 删除操作，设置按钮灰色方法，或者其他控件颜色方法
             _nextBtn.userInteractionEnabled =NO;
             _nextBtn.backgroundColor = [UIColor colorWithHexString:@"#00C0AE" alpha:0.4];
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
