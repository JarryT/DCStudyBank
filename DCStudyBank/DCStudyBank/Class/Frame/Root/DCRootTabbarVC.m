//
//  DCRootTabbarVC.m
//  DCStudyBank
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCRootTabbarVC.h"
#import "DCHomeVC.h"
#import "DCFindVC.h"
#import "DCMyViewController.h"
#import "DCNavigationVC.h"
@interface DCRootTabbarVC ()
@property(nonatomic,strong)DCNavigationVC *homeNav;
@property(nonatomic,strong)DCNavigationVC *findNav;
@property(nonatomic,strong)DCNavigationVC *myNav;
@end

@implementation DCRootTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     DCHomeVC *homeVc = [[DCHomeVC alloc]init];
    _homeNav = [[DCNavigationVC alloc]initWithRootViewController:homeVc];
    _homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"自学"image:[UIImage imageNamed:@"zixue_icon_n"] selectedImage:[self setBarItemImage:@"zixue_icon_s"]];
       
    DCFindVC *findVc = [[DCFindVC alloc]init];
    _findNav = [[DCNavigationVC alloc]initWithRootViewController:findVc];
    _findNav.title = @"发现";
    _findNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现"image:[UIImage imageNamed:@"faxian_icon_n"] selectedImage:[self setBarItemImage:@"faxian_icon_s"]];
    
    DCMyViewController *myVc = [[DCMyViewController alloc]init];
    _myNav= [[DCNavigationVC alloc]initWithRootViewController:myVc];
    _myNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"image:[UIImage imageNamed:@"my_icon_n"] selectedImage:[self setBarItemImage:@"my_icon_s"]];
    
    self.viewControllers = @[_homeNav,_findNav,_myNav];
    self.selectedIndex = 0;
    [UITabBar appearance].translucent = false;
    self.tabBar.barStyle = UIBarStyleDefault;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor = KMainColor;
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
}

- (UIImage *)setBarItemImage:(NSString *)imgName {
    UIImage *img = [UIImage imageNamed:imgName];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return img;
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
