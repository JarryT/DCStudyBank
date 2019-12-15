//
//  DCErrorListViewController.m
//  DCStudyBank
//
//  Created by fillinse on 2019/12/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCErrorListViewController.h"
#import "FCGroupChatInfoTextItemTableViewCell.h"
#import "DCWrongTestVC.h"
#import "DCKaoDianModel.h"
#import "DCHomeKeMuModel.h"

@interface DCErrorListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation DCErrorListViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isShowBgImag = true;
    self.isShowWhiteImg = true;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navTitle = @"错误";
    [self getKaoDianListData];
    [self.tableView registerNib:[UINib nibWithNibName:@"FCGroupChatInfoTextItemTableViewCell" bundle:nil] forCellReuseIdentifier:@"FCGroupChatInfoTextItemTableViewCell"];
}
//获取错题列表
- (void)getKaoDianListData{
    weakSelf(self);
    [DCNetworkingRequest postString:HomeStudyCategoryPath params:@{} withMappingObject:@"DCHomeKeMuModel" success:^(DCHomeKeMuModel *responseObject) {
        if (responseObject.code == 200) {
             if (responseObject.obj.kemu.count > 0) {
                   [weakSelf.dataArray removeAllObjects];
                   [weakSelf.dataArray addObjectsFromArray:responseObject.obj.kemu];
               }
            [weakSelf.tableView reloadData];
        }else{
            [MBProgressHUD showError:responseObject.msg];
        }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {

    }];
}
#pragma mark -- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FCGroupChatInfoTextItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FCGroupChatInfoTextItemTableViewCell" forIndexPath:indexPath];
    DCkemuListModel *keM = self.dataArray[indexPath.row];
    [cell configWithModel:keM];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCkemuListModel *keM = self.dataArray[indexPath.row];
    DCWrongTestVC *test = [[DCWrongTestVC alloc] init];
    test.item = keM;
    [self.navigationController pushViewController:test animated:YES];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        weakSelf(self);
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(weakSelf.view);
            make.top.mas_equalTo(weakSelf.navView.mas_bottom);
        }];
    }
    return _tableView;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
