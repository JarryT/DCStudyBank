//
//  DCChooseTestInfoVC.m
//  DCStudyBank
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCChooseTestInfoVC.h"
#import "DCTestInfoGroupModel.h"
#import "DCChooseTestCell.h"
#import "DCChooseTestHeaderView.h"
#import "DCRootTabbarVC.h"
#import "DCSubJectStudyModel.h"
#import "DCStudySubjectMangerVC.h"
@interface DCChooseTestInfoVC ()<UITableViewDelegate,UITableViewDataSource,DCChooseTestCellDlectage>{
   
}
@property (weak, nonatomic) IBOutlet UITableView *tabv;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)DCChooseTestCell *selectCll;
@property(nonatomic,strong)NSString *studyId;
@property(nonatomic,strong)NSString *subName;
@end

@implementation DCChooseTestInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"参加考试";
    self.navView.titleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    _studyId = @"";
    weakSelf(self);
    [self.navView setRightFirstName:@"保存" icon:nil btnType:LEFTT resultAction:^{
        [weakSelf saveBtnClick];
    }];
    [self.navView.rightFirstBtn setTitleColor:[UIColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    _searchView.layer.cornerRadius = 17;
    _searchView.layer.masksToBounds = true;
    _dataArr = [NSMutableArray array];
    self.tabv.delegate = self;
    self.tabv.dataSource = self;
    self.tabv.rowHeight = 44;
    [self chooseStudyTest];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar navBarBottomLineHidden:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar navBarBottomLineHidden:true];
}

//选择考试
- (void)chooseStudyTest{
    weakSelf(self);
    [MBProgressHUD showLoadingCustomtoView:ApplicationKeyWindow animated:YES];
    [DCNetworkingRequest requestWithURLString:JoinStudySubPath params:@{@"subrank":@"1"} method:POST withMappingObject:@"DCSubJectStudyModel" success:^(DCSubJectStudyModel *responseObject) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        if (responseObject.code == 200) {
            if (responseObject.obj.count > 0) {
                [weakSelf.dataArr removeAllObjects];
                [weakSelf.dataArr addObjectsFromArray:responseObject.obj];
                [weakSelf.tabv reloadData];
            }
            
        }else{
            [MBProgressHUD showError:responseObject.msg];
        }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        [MBProgressHUD showError:errorDescription];
    }];

}

//保存
- (void)saveBtnClick{
    if (_studyId.length == 0) {
        [MBProgressHUD showError:@"请选择报考考试"];
        return;
    }
    weakSelf(self);
    
    [MBProgressHUD showLoadingCustomtoView:ApplicationKeyWindow animated:YES];
    [DCNetworkingRequest requestWithURLString:SavJoinSubjectPath params:@{@"homeId":_studyId} method:POST withMappingObject:@"DCSubJectStudyModel" success:^(DCSubJectStudyModel *responseObject) {
           [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
           if (responseObject.code == 200) {
               [MBProgressHUD showSuccess:responseObject.msg];
               if (weakSelf.fromLogin) {
                   
                   DCStudySubjectMangerVC *vc = [[DCStudySubjectMangerVC alloc] init];
                   vc.pid = weakSelf.studyId;
                   vc.isFromFirstLogin = weakSelf.fromLogin;
                   [weakSelf.navigationController pushViewController:vc animated:YES];
               }else{
                   if (self->_saveStudySubJectBlock) {
                       self->_saveStudySubJectBlock(weakSelf.subName);
                       
                   }
                   [weakSelf.navigationController popViewControllerAnimated:true];
               }
               
           }else{
               [MBProgressHUD showError:responseObject.msg];
           }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
           [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
           [MBProgressHUD showError:errorDescription];
    }];
}

- (void)setlectStudyWith:(DCSubJectStudyTwoListModel *)M{
    _subName = M.subname;
    _studyId = M.pid;

}
- (IBAction)searchBtnClick:(UIButton *)sender {
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DCSubJectStudyObjModel *dataM = self.dataArr[section];
    return dataM.isOpen?dataM.twoList.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DCChooseTestCell *cell = [DCChooseTestCell cellWithTableView:tableView];
    DCSubJectStudyObjModel *dataM = self.dataArr[indexPath.section];
    DCSubJectStudyTwoListModel *M = dataM.twoList[indexPath.row];
    cell.stlectM = M;
    cell.titleName.text = M.subname;
    cell.delgate = self;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 58;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    weakSelf(self)
    DCChooseTestHeaderView *heaedV = [DCChooseTestHeaderView createJMDServeMoneySetHeaerView];
    heaedV.isShowAllBlock = ^{
        DCSubJectStudyObjModel *gM = weakSelf.dataArr[section];
        gM.isOpen = !gM.isOpen; //打开取反
        NSIndexSet *indexSext = [[NSIndexSet alloc]initWithIndex:section];
        [tableView reloadSections:indexSext withRowAnimation:UITableViewRowAnimationNone];
    };
    heaedV.M = self.dataArr[section];
    return heaedV;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
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
