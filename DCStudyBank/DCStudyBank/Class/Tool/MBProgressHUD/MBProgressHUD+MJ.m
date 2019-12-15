//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"
#import "UIImage+XYSWTool.h"
@implementation MBProgressHUD (MJ)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.yOffset = -50;
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.5];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
   
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}
+ (void)showTip:(NSString *)tip toView:(UIView *)view
{
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
	hud.labelText = tip;
	hud.mode = MBProgressHUDModeText;
	hud.labelColor = [UIColor whiteColor];
	hud.removeFromSuperViewOnHide = YES;
	[hud hide:YES afterDelay:1.5];
    hud.color = 
	hud.color = RGBAColor(0, 0, 0, 0.8);
}
+ (void)showLoading:(NSString *)tip toView:(UIView *)view
{
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
	hud.labelText = tip;
	hud.mode = MBProgressHUDModeAnnularDeterminate;
	hud.labelColor = [UIColor whiteColor];
	hud.removeFromSuperViewOnHide = YES;
	[hud hide:YES afterDelay:1.5];
	hud.color = RGBAColor(0, 0, 0, 0.8);
}
#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

+ (void)showLoadingCustomtoView:(UIView *)view animated:(BOOL)animated{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.backgroundColor = RGBAColor(0, 0, 0, 0.5);
    UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    for(int i = 1; i < 5; i++){
        NSString *imgName = [NSString stringWithFormat:@"daxiang_icon_n_%d",i];
        [imageArray addObject:[UIImage imageNamed:imgName]];
    }
    
    images.animationDuration = 1;
    images.animationImages = imageArray;
    // 开始播放
    [images startAnimating];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = images;
    hud.color = [UIColor clearColor];
    
}

@end
