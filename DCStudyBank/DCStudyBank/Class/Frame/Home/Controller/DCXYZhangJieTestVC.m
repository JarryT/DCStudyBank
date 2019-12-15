//
//  DCXYZhangJieTestVC.m
//  DCStudyBank
//
//  Created by mac on 2019/12/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCXYZhangJieTestVC.h"
#import "DCHomeTableHeaderView.h"
#import "DCHomeListDataModel.h"
#import "DCHomeCell.h"

#import "DCZhangJieAltView.h"
@interface DCXYZhangJieTestVC ()<DCHomeCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewH;
@property (nonatomic,strong)NSMutableArray <DCHomeListDataModel *>*homeDataArr;
@property (nonatomic,strong)DCZhangJieAltView *latView;
@end

@implementation DCXYZhangJieTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"章节练习";
    weakSelf(self);
    NSArray *data = @[@{@"title":@"建设工程项目的组织与管理",@"current":@"100",@"total":@"30000",@"group":@[@{@"title":@"建设工程项目进度控制的目标和任务",@"current":@"0",@"total":@"1000"},@{@"title":@"施工方进度计划的类型及其作用",@"current":@"50",@"total":@"1000"},@{@"title":@"施工方进度计划的类型及其作用",@"current":@"50",@"total":@"1000"}]},@{@"title":@"建设工程项目进度控制",@"current":@"130",@"total":@"30000",@"group":@[@{@"title":@"建设工程项目进度控制",@"current":@"30",@"total":@"1000"},@{@"title":@"施工方进度计划",@"current":@"50",@"total":@"1000"},@{@"title":@"施工方进度计划的类型及其作用",@"current":@"50",@"total":@"1000"}]}];
       [self.homeDataArr addObjectsFromArray:[DCHomeListDataModel mj_objectArrayWithKeyValuesArray:data]];
      self.groupTableView.frame = CGRectMake(0,_topView.bottom+10,KScreenWidth,self.view.height-_topView.bottom-10);
      self.groupTableView.rowHeight = 75;
     [self.view addSubview:self.groupTableView];
     [self.navView setRightFirstName:@"刷题模式" icon:@"index_downmore_icon" btnType:RIGHT resultAction:^{
         [weakSelf showLatview];
     }];
    
    _latView = [[NSBundle mainBundle] loadNibNamed:@"DCZhangJieAltView" owner:nil options:nil].firstObject;
    _latView.hidden = YES;
    _latView.bounds = self.view.bounds;
    _latView.btnBlock = ^(NSString * _Nonnull content, NSInteger index) {
        
    };
    [self.view addSubview:_latView];
     
}

- (void)showLatview{
    
    _latView.hidden = _latView.isHidden?NO:YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isShowWhiteImg = true;
    self.isShowBgImag = true;
}

#pragma mark-DCHomeCellDelegate
- (void)editeStudyInfo:(NSString *)studyId{
}
#pragma  mark-UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _homeDataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     DCHomeListDataModel *dataM = self.homeDataArr[section];
    return dataM.isOpen?dataM.group.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCHomeCell *cell = [DCHomeCell cellWithTableView:tableView];
    cell.dataM = self.homeDataArr[indexPath.section].group[indexPath.row];
    cell.delegate = self;
    if (indexPath.row == self.homeDataArr[indexPath.section].group.count-1) {
        cell.seperView.hidden = YES;
        cell.stutusImg.image = [UIImage imageNamed:@"index_list_add_pot"];
    }else{
        cell.seperView.hidden = NO;
        cell.stutusImg.image = [UIImage imageNamed:@"index_list_delete_pot"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 84;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    weakSelf(self);
    DCHomeTableHeaderView *headerV = [[NSBundle mainBundle] loadNibNamed:@"DCHomeTableHeaderView" owner:nil options:nil].firstObject;
    headerV.type = 1;
    headerV.isShowAllBlock = ^{
        weakSelf.homeDataArr[section].isOpen = !weakSelf.homeDataArr[section].isOpen; //打开取反
        NSIndexSet *indexSext = [[NSIndexSet alloc]initWithIndex:section];
        [tableView reloadSections:indexSext withRowAnimation:UITableViewRowAnimationNone];
    };
    headerV.buyTestBlock = ^(NSString *string) {
        
    };
    headerV.modelM = self.homeDataArr[section];
    return headerV;
}

#pragma lazy
- (NSMutableArray *)homeDataArr{
    if (!_homeDataArr) {
        _homeDataArr = [NSMutableArray array];
    }
    return _homeDataArr;
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
