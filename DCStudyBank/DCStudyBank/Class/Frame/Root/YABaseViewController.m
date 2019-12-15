//
//  YABaseViewController.m
//  亿安优选
//
//  Created by 邓培 on 2019/9/5.
//  Copyright © 2019 yayd. All rights reserved.
//

#import "YABaseViewController.h"
#import "sys/utsname.h"
#import "UIBaseTableViewCell.h"
@interface YABaseViewController ()
@end

@implementation YABaseViewController
- (void)dealloc {
//    YALOG(@"%@ - %@",self,NSStringFromSelector(_cmd));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initliaedUI];
}

- (void)initliaedUI {
    self.view.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    
//    UIButton *backBtn = [UIButton imageButton:@"return" backgroundImageName:@""];
//    backBtn.frame = CGRectMake(0, 0, 55, YASafeAreaTopHeight-20);
//    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [backBtn addTarget:self action:@selector(popBackAction) forControlEvents:UIControlEventTouchUpInside];
//
//    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItem = (self.navigationController.viewControllers.count<2) ? [UIBarButtonItem new] : buttonItem;
    _navView = [[NSBundle mainBundle] loadNibNamed:@"BRBaseNavgationView" owner:nil options:nil].firstObject;
    [self.view addSubview:_navView];
    [_navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(self.view);
        if (IS_IPhoneX) {
            make.height.mas_equalTo(self.presentingViewController ? 44 : kTopHeight);
        }else{
            make.height.mas_equalTo(kTopHeight);
        }
    }];

    weakSelf(self)
    [_navView handleItemClickBlock:^(BRBaseNavgationViewType type) {
        [weakSelf handleItemClickType:type];
    }];
//    WS(weakSelf)
   
    
    [_navView resetRightBtnState];
    
//    ({\
//    BOOL isPhoneX = NO;\
//    if (@available(iOS 11.0, *)) {\
//        if (!UIEdgeInsetsEqualToEdgeInsets([UIApplication sharedApplication].delegate.window.safeAreaInsets, UIEdgeInsetsZero)) {\
//        isPhoneX = YES;\
//        }\
//    }\
//    isPhoneX;\
//    })
//    ({\
//    BOOL iPhoneX = NO;\
//     if (@available(iOS 11.0, *)) {\
//         UIWindow *mainWindow = [[[UIApplication sharedApplication] windows] firstObject];\
//         if (mainWindow.safeAreaInsets.bottom > 0.0) {\
//             iPhoneX = YES;\
//         }\
//     }\
//     iPhoneX;
//    })
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.isCenter = YES;
    self.hasBack = YES;
    //self.navView.isRed = NO;
}
- (void)handleItemClickType:(BRBaseNavgationViewType)type
{
    //
    [self popBackAction];
}
    //返回按钮点击
- (void)popBackAction{
    if (self.navigationController.topViewController == self ){
        if (self.navigationController.viewControllers.count == 1) { //模态切换时一个UINavigationController时的第一个VC
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
    //触摸关闭键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
    
- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    _navView.title = _navTitle;
}
- (void)setHasBack:(BOOL)hasBack
{
    _hasBack = hasBack;
    _navView.hasBack = _hasBack;
}
- (void)setIsCenter:(BOOL)isCenter
{
    _isCenter = isCenter;
    _navView.titleCenter = isCenter;
}

- (void)setIsShowBgImag:(BOOL)isShowBgImag{
    _isShowBgImag = isShowBgImag;
    _navView.isBagImage =isShowBgImag;
}

- (void)setIsShowWhiteImg:(BOOL)isShowWhiteImg{
    _isShowWhiteImg = isShowWhiteImg;
    _navView.isShowWhiteImg = isShowWhiteImg;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (self.datasource.count == 0) {
        return 0;
    }
    if ([self.datasource[0] isKindOfClass:[NSArray class]]) {
        return self.datasource.count;
    } else {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([self.datasource[section] isKindOfClass:[NSArray class]]) {
        NSArray *tempArray = self.datasource[section];
        return tempArray.count;
    } else {
        return self.datasource.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIBaseTableViewCell *cell = [UIBaseTableViewCell cellWithTableView:tableView reuseIdentifier:UIBaseTableViewCellIdentifier];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark-lazy
- (UITableView *)plainTableView{
    if (!_plainTableView) {
        _plainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _plainTableView.dataSource = self;
        _plainTableView.delegate = self;
        _plainTableView.backgroundColor = KTableListBGColor;
        _plainTableView.bounces = YES;
        _plainTableView.showsVerticalScrollIndicator = NO;
        _plainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _plainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _plainTableView;
}
- (UITableView *)groupTableView{
    if (!_groupTableView) {
        _groupTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _groupTableView.dataSource = self;
        _groupTableView.delegate = self;
        _groupTableView.backgroundColor = KTableListBGColor;
        _groupTableView.bounces = YES;
        _groupTableView.showsVerticalScrollIndicator = NO;
        _groupTableView.sectionHeaderHeight = 0.1;
        _groupTableView.sectionFooterHeight = 0.1;
        _groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _groupTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _groupTableView;
}

- (NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}
@end
