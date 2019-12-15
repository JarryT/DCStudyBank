//
//  DCLoginViewController.m
//  DCStudyBank
//
//  Created by mac on 2019/11/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCLoginViewController.h"
#import "DCForgetPasswordVC.h"
#import "DCRegistrationInfoVC.h"
#import "PersistManager+Archieve.h"
#import "DCRootTabbarVC.h"
#import "DCChooseTestInfoVC.h"

@interface DCLoginViewController ()<UITextFieldDelegate>{
     NSInteger counts;
}
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *cheackNum;
@property (weak, nonatomic) IBOutlet UIButton *cheackBtn;
@property (weak, nonatomic) IBOutlet UIButton *logInAndRegistBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cheackViewH;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordBtn;
@property (weak, nonatomic) IBOutlet UIButton *registWarnBtn;
@property (weak, nonatomic) IBOutlet UIView *cheackView;

@end

@implementation DCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 40, 40)];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    _logInAndRegistBtn.layer.cornerRadius = 22;
    _logInAndRegistBtn.layer.masksToBounds = YES;
    _logInAndRegistBtn.backgroundColor = [UIColor colorWithHexString:@"#00C0AE" alpha:0.4];
    _phone.delegate = self;
    _password.delegate = self;
    _cheackNum.delegate = self;
    if (_type == 1) {
        _cheackViewH.constant = 0;
        _cheackView.hidden = YES;
        _forgetPasswordBtn.hidden = NO;
        _registWarnBtn.hidden = NO;
        [_logInAndRegistBtn setTitle:@"登 录" forState:UIControlStateNormal];
        if (_parms.count > 0) {
            self.phone.text = [_parms objectSafeKey:@"phone"];
            self.password.text = [_parms objectSafeKey:@"password"];
            self.logInAndRegistBtn.userInteractionEnabled = YES;
            _logInAndRegistBtn.userInteractionEnabled =YES;
            _logInAndRegistBtn.backgroundColor = [UIColor colorWithHexString:@"#00C0AE" alpha:1];
            
        }
    }
}
- (IBAction)registWaenBtnClick:(UIButton *)sender {
    DCLoginViewController *vc = [DCLoginViewController new];
    vc.type = 0;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)forgetPasswordBtnClick:(UIButton *)sender {
    DCForgetPasswordVC *vc = [DCForgetPasswordVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backBtnClick{

    if(self.navigationController.presentingViewController){//present 方式
               [self dismissViewControllerAnimated:YES completion:nil];
           } else {//push
               [self.navigationController setNavigationBarHidden:NO animated:NO];
               [self.navigationController popViewControllerAnimated:YES];
        }
}
- (IBAction)cheackBtnCclick:(id)sender {
   
    if (self.phone.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }else if (self.phone.text.length != 11){
        [MBProgressHUD showError:@"请输入正确手机号"];
        return;
    }
    [self.phone resignFirstResponder];
    [self.cheackNum resignFirstResponder];
    [self.password resignFirstResponder];
    
    weakSelf(self);
    NSString *urlPath = [NSString stringWithFormat:@"%@?phone=%@",GetPhoneCodePath,self.phone.text];
    [MBProgressHUD showLoadingCustomtoView:ApplicationKeyWindow animated:YES];
    [DCNetworkingRequest requestWithURLString:urlPath params:@{} method:GET withMappingObject:@"DCNetworkingReultModel" success:^(DCNetworkingReultModel *responseObject) {
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
- (IBAction)registAndLoginBtnClick:(id)sender {
    
    if (_type == 0) {//注册
        [self setRegistrationInfo];
    }else{//登录
        [self userLoginWith];
    }
    
}

- (IBAction)poctoclBtnClick:(UIButton *)sender {//tag20
    
    if (sender.tag ==20) {//用户协议
        
    }else{//隐私政策
        DCRegistrationInfoVC *vc = [DCRegistrationInfoVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//用户登录
- (void)userLoginWith{
      weakSelf(self);
      if (self.phone.text.length == 0) {
           [MBProgressHUD showError:@"请输入手机号"];
           return;
       }
       if (self.phone.text.length != 11) {
           [MBProgressHUD showError:@"请输入正确的手机号"];
           return;
       }
       
       if (self.password.text.length == 0) {
           [MBProgressHUD showError:@"请输入密码"];
           return;
       }
       if (self.password.text.length<6) {
           [MBProgressHUD showError:@"输入密码应大于6位"];
           return;
       }
       if (![self.password.text isPassword]) {
           [MBProgressHUD showError:@"密码不合法"];
           return;
       }
        NSDictionary *parms = @{@"phone":self.phone.text,@"password":self.password.text};
         [MBProgressHUD showLoadingCustomtoView:ApplicationKeyWindow animated:YES];
        [DCUerLoginManger userLoginWithParms:parms success:^(  NSDictionary *responseObject) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        if ([[responseObject objectSafeKey:@"code"] intValue] == 200) {//登录成功
            //保存上次登录用户的账号
            NSDictionary *obj = [responseObject objectSafeKey:@"obj"];
            NSDictionary *userDict = [obj objectSafeKey:@"user"];
            [[NSUserDefaults standardUserDefaults] setObject:userDict[@"phone"] forKey:LastLoginUserAccount];
            [[NSUserDefaults standardUserDefaults] setObject:weakSelf.password.text forKey:LastLoginUserPSW];
            //保存上次登录用户的uid
            [[NSUserDefaults standardUserDefaults] setObject:userDict[@"id"] forKey:LastLoginUserID];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //保存用户信息
            [[DCUerLoginManger shareLoginInfoIntents] getData:obj];
            [PersistManager archieveForUser:[[NSUserDefaults standardUserDefaults]objectForKey:LastLoginUserID] withObject:obj forKey:UserLoginPatch];
            [weakSelf userLoginScuess];
            
        }else{
        
            [MBProgressHUD showError:[responseObject objectSafeKey:@"msg"]];
        }
        
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        [MBProgressHUD showError:errorDescription];
    }];
}

- (void)userLoginScuess{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"firstLaunch"]) {
        //第一次启动
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"everLaunch"];
        if ([[DCUerLoginManger shareLoginInfoIntents].kemu intValue] == 1) {
            DCNavigationVC *nav = [[DCNavigationVC alloc]initWithRootViewController:[[DCRootTabbarVC alloc]init]];
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
        }else{
            DCChooseTestInfoVC *vc = [DCChooseTestInfoVC new];
            vc.fromLogin = true;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else {

        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"everLaunch"];
        DCNavigationVC *nav = [[DCNavigationVC alloc]initWithRootViewController:[[DCRootTabbarVC alloc]init]];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    }
    
}

//注册
- (void)setRegistrationInfo{
    if (self.phone.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    if (self.phone.text.length != 11) {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        return;
    }
    
    if (self.password.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    if (self.password.text.length<6) {
        [MBProgressHUD showError:@"输入密码应大于6位"];
        return;
    }

    if (![self.password.text isPassword]) {
        [MBProgressHUD showError:@"密码不合法"];
        return;
    }
    if (self.cheackNum.text.length == 0) {
        [MBProgressHUD showError:@"请输入验证码"];
        return;
    }
    if (self.cheackNum.text.length != 6) {
        [MBProgressHUD showError:@"输入验证码位数不正确"];
        return;
    }
    weakSelf(self)
     NSDictionary *parms = @{@"phone":self.phone.text,@"code":self.cheackNum.text,@"password":self.password.text};
    [MBProgressHUD showLoadingCustomtoView:ApplicationKeyWindow animated:YES];
    
    [DCUerLoginManger userRegisterWithParms:parms success:^( DCNetworkingReultModel *responseObject) {
         [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        if (responseObject.code == 200) {
            [MBProgressHUD showSuccess:@"注册成功请去登录"];
            
             [weakSelf registSucessGoLogin];
         }else{
            
             [MBProgressHUD showError:responseObject.msg];
        }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
         [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
         [MBProgressHUD showError:errorDescription];
    }];
}

- (void)registSucessGoLogin{
    DCLoginViewController *VC = [DCLoginViewController new];
    VC.type = 1;
    VC.parms = @{@"phone":self.phone.text,@"password":self.password.text};
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark-UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
       if (textField.tag) {
           switch (textField.tag) {
               case 16:{
                   counts = 11;
               }break;
               case 17:{
                   counts = 16;
               }break;
                case 18:{
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
        if (self.type == 1) {
            if (self.password.text.length > 0 && self.phone.text.length > 0) {
                 _logInAndRegistBtn.userInteractionEnabled =YES;
                 _logInAndRegistBtn.backgroundColor = [UIColor colorWithHexString:@"#00C0AE" alpha:1];
            }
        }else{
            if (self.password.text.length > 0 && self.phone.text.length > 0 && self.cheackNum.text.length > 0) {
                 _logInAndRegistBtn.userInteractionEnabled =YES;
                 _logInAndRegistBtn.backgroundColor = [UIColor colorWithHexString:@"#00C0AE" alpha:1];
            }
        }
        
           
    } else {
            ///< 删除操作，设置按钮灰色方法，或者其他控件颜色方法
             _logInAndRegistBtn.userInteractionEnabled =NO;
             _logInAndRegistBtn.backgroundColor = [UIColor colorWithHexString:@"#00C0AE" alpha:0.4];
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

@end
