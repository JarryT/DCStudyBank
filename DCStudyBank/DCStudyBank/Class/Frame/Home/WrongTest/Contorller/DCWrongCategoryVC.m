//
//  DCWrongCategoryVC.m
//  DCStudyBank
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCWrongCategoryVC.h"
#import "DCItemToolView.h"
#import "DCKaoDianModel.h"

#import "DCHomeTableHeaderView.h"
#import "DCHomeListDataModel.h"
#import "DCHomeCell.h"

#import "DCCollectSingleSelectedTableViewCell.h"

@interface DCWrongCategoryVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation DCWrongCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DCCollectSingleSelectedTableViewCell" bundle:nil] forCellReuseIdentifier:@"DCCollectSingleSelectedTableViewCell"];
    __block NSArray *itemsArray = @[@{@"name":@"真题模拟",@"type":@"1"},@{@"name":@"巩固模考",@"type":@"1"},@{@"name":@"教材强化练习",@"type":@"1"},@{@"name":@"精品三套",@"type":@"1"}];
    weakSelf(self);
    DCItemToolView *toolView = [[DCItemToolView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40) items:itemsArray result:^(int type) {
        [weakSelf getKaoDianListDataWithName:[itemsArray[0] objectSafeKey:@"name"]];
    }];
    [self.view addSubview:toolView];
    [self getKaoDianListDataWithName:[itemsArray[0] objectSafeKey:@"name"]];
}
//获取试题列表
- (void)getKaoDianListDataWithName:(NSString *)name{
    weakSelf(self);
    [DCNetworkingRequest postString:ErrorQueryPath params:@{@"errresult":@"错误",@"corid":_item.kemuId,@"cortype":name} withMappingObject:@"DCKaoDianModel" success:^(DCKaoDianModel *responseObject) {
        if (responseObject.code == 200) {
            if (responseObject.obj.count > 0) {
                [weakSelf.dataArray removeAllObjects];
                NSMutableArray *array = [NSMutableArray array];
                for (int i = 0; i < responseObject.obj.count; i ++) {
                    DCKaoDianObjModel *info = responseObject.obj[i];
                    if (info.itemtype) {
                        if (info.itemtype.length > 0) {
                            [array addObject:info];
                        }
                    }
                }
                [weakSelf.dataArray addObjectsFromArray:array];
                [weakSelf.tableView reloadData];
            }
        }else{
            [MBProgressHUD showError:responseObject.msg];
        }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {

    }];
}
#pragma  mark --- table dalegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCKaoDianObjModel *info = _dataArray[indexPath.section];
    return info.height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] init];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCKaoDianObjModel *info = _dataArray[indexPath.section];
    //单选的判断
    if ([info.itemtype isEqualToString:@"单选"] || [info.itemtype isEqualToString:@"多选"]) {
        DCCollectSingleSelectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DCCollectSingleSelectedTableViewCell" forIndexPath:indexPath];
        [cell configWithModel:info];
        return cell;
    }
    //问答题的判断
    else if([info.itemtype isEqualToString:@"问答"] || !info.itemtype){
        DCCollectSingleSelectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DCCollectSingleSelectedTableViewCell" forIndexPath:indexPath];
        [cell configWithModel:info];
        return cell;
    }else{
        //非单选多选问答并且存在的类型，会崩溃,按照类型自行处理
        return nil;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        UIView *footer = [[UIView alloc] init];
        footer.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.tableFooterView = footer;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        weakSelf(self);
        [self.view addSubview:_tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(weakSelf.view);
            make.top.mas_equalTo(self.view.mas_top).offset(40);
        }];
    }
    return _tableView;
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
