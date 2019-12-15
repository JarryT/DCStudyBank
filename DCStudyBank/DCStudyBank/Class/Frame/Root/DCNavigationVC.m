//
//  DCNavigationVC.m
//  ItemBank
//
//  Created by mac on 2019/11/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCNavigationVC.h"
#import "YaydUINavigationBar+handle.h"
@interface DCNavigationVC ()

@end

@implementation DCNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航初始 默认白色和1    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = true;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.ss_prefersNavigationBarHidden = NO;
}

+ (void)setupNavBarTheme{
     // 取出appearance对象
        UINavigationBar *navBar = [UINavigationBar appearance];
        [navBar navBarBottomLineHidden:YES];
        
        // 设置标题属性
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = kNavigationTitleBgColor;
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
        [navBar setTitleTextAttributes:textAttrs];
}
+ (void)initialize{
    // 1.设置导航栏主题
      
     
        // 2.设置导航栏按钮主题
    //    [self setupBarButtonItemTheme];
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = kGobalViewBgColor;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] =  kGobalViewBgColor;//[UIColor lightGrayColor];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) { // 此时push进来的viewController是第二个子控制器
        // 自动隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 定义全局leftBarButtonItem
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 45, 45);
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 25)];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateNormal];
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

    [super pushViewController:viewController animated:animated];
   
}


- (void)back {
   
    [self popViewControllerAnimated:true];
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
