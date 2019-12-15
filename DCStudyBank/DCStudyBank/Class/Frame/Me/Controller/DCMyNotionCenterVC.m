
//
//  DCMyNotionCenterVC.m
//  DCStudyBank
//
//  Created by mac on 2019/11/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCMyNotionCenterVC.h"

@interface DCMyNotionCenterVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tabV;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation DCMyNotionCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"通知";
    UIButton *delBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [delBtn setImage:[UIImage imageNamed:@"navigation_delete_w_icon"] forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(delBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:delBtn];
    _tabV.delegate = self;
    _tabV.dataSource = self;
    _tabV.rowHeight = 50;
    _dataArr = [NSMutableArray array];
    [_dataArr addObjectsFromArray:@[@{@"title":@"免费领取价值500元新人学习大礼包"}]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImage *backGroundImage = [UIImage imageNamed:@"title_head_bg_three"];
    self.navigationController.ss_navigationBackImage = [UIImage  imageNamed:@"navigation_back_w_icon"];
    backGroundImage = [backGroundImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarMetrics:UIBarMetricsDefault];
     [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

//删除通知消息
- (void)delBtnClick{
}

#pragma mark-UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YaydTXSeperateLineCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"DCMyNotionCenterVCId"];
    if (!cell) {
        cell = [[YaydTXSeperateLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DCMyNotionCenterVCId"];
    }
    cell.textLabel.text = self.dataArr[indexPath.row][@"title"];
    cell.textLabel.textColor = kMainTitleColor;
    cell.textLabel.font = KFont(14);
    if (self.dataArr.count-1 == indexPath.row) {
        cell.bottomLineView.hidden = true;
    }
    return cell;
}


@end
