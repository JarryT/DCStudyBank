//
//  UIViewController+Util.m
//  CTTAPP
//
//  Created by 汤军 on 2017/10/26.
//  Copyright © 2017年 TJarry. All rights reserved.
//

#import "UIViewController+Util.h"
#import "DCLoginViewController.h"
#import "DCNavigationVC.h"

@implementation UIViewController (Util)

- (void)loginWith:(LoginTransitionType)type manu:(BOOL)manu complete:(ActionBlock)completeBlock{
    
    DCLoginViewController *login = [[DCLoginViewController alloc] init];
    login.type = 1;
	login.manuAppear = manu;
    if (type == LoginTransitionTypePush) {
        [self pushToViewController:login animated:YES];
    } else if (type == LoginTransitionTypePresent){
        DCNavigationVC *nav = [[DCNavigationVC alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (void)loginWith:(LoginTransitionType)type{

//    [self loginWith:type complete:nil];
	[self loginWithType:type manu:NO];
}
- (void)loginWithType:(LoginTransitionType)type manu:(BOOL)manu
{
	[self loginWith:type manu:manu complete:nil];
}
- (void)performPopAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushToViewController:(UIViewController *)viewContrller animated:(BOOL)animated hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed{

    //perform push action
    viewContrller.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed;
    [viewContrller customPopAction];
    if ([self isKindOfClass:[UINavigationController class]]){
        [(UINavigationController *)self pushViewController:viewContrller animated:true];
    }else{
        [self.navigationController pushViewController:viewContrller animated:animated];
    }
}
- (void)pushWithClass:(NSString *)className
{
	Class class = NSClassFromString(className);
	UIViewController *vc = [[class alloc] init];
		//	[self.navigationController pushViewController:vc animated:YES];
	[self pushToViewController:vc animated:YES];
}
- (void)pushToViewController:(UIViewController *)viewContrller animated:(BOOL)animated{
    [self pushToViewController:viewContrller animated:animated hidesBottomBarWhenPushed:YES];
}
- (void)customPopAction{
    self.navigationItem.leftBarButtonItem = [self customPopItem];
}
- (UIBarButtonItem *)customPopItemWithSize:(CGSize)size{
    UIButton *button = [[UIButton alloc] init];
    button.adjustsImageWhenHighlighted = false;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.size = size;
    [button setImage:[UIImage imageNamed:@"icon-jt-dl"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(performPopAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}
- (UIBarButtonItem *)customPopItem{
    return [self customPopItemWithSize:CGSizeMake(44, 30)];
}

@end
