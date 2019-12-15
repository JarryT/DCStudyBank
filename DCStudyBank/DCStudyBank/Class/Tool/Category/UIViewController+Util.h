//
//  UIViewController+Util.h
//  CTTAPP
//
//  Created by 汤军 on 2017/10/26.
//  Copyright © 2017年 TJarry. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LoginTransitionType) {
    LoginTransitionTypePush = 0,
    LoginTransitionTypePresent = 1,
};
@interface UIViewController (Util)

- (UIBarButtonItem *)customPopItem;
- (UIBarButtonItem *)customPopItemWithSize:(CGSize)size;

- (void)pushToViewController:(UIViewController *)viewContrller animated:(BOOL)animated;
- (void)pushToViewController:(UIViewController *)viewContrller animated:(BOOL)animated
	hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed;
- (void)pushWithClass:(NSString *)className;
- (void)performPopAction;

//用户已登录时
//- (void)checkLoginStatusWith:(LoginTransitionType)type complete:(CTTActionBlock)block;
//
- (void)loginWith:(LoginTransitionType)type;//push 和 present弹出方式
//登录界面出现是否是手动调出来的 manu
- (void)loginWithType:(LoginTransitionType)type manu:(BOOL)manu;
@end
