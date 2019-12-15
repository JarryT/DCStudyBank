//
//  UIBaseViewController.m
//  CTTAPP
//
//  Created by 汤军 on 2017/10/26.
//  Copyright © 2017年 TJarry. All rights reserved.
//

#import "UIBaseViewController.h"
//#import "FBRetainCycleDetector.h"
@interface UIBaseViewController ()

@end

@implementation UIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

//    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
//    [detector addCandidate:self];
//    NSSet *retainCycles = [detector findRetainCycles];
//    NSLog(@"%@", retainCycles);
}

- (void)dealloc{
    NSLog(@"controller name: %@",NSStringFromClass([self class]));
}

@end
