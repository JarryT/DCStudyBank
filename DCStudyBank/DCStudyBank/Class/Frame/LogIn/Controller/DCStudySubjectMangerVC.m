//
//  DCStudySubjectMangerVC.m
//  DCStudyBank
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCStudySubjectMangerVC.h"
#import "DCChooseTestCell.h"
#import "DCJoinStudyMangerModel.h"
#import "DCRootTabbarVC.h"
@interface DCStudySubjectMangerVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tabV;
@property (nonatomic,strong)NSMutableArray  *selectArr;
@property (nonatomic,strong)NSString *subjectBeanId;
@end

@implementation DCStudySubjectMangerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    weakSelf(self);
    self.navTitle = @"参加科目管理";
    self.navView.sepView.hidden =NO;
    [self.navView setRightFirstName:@"保存" icon:nil btnType:LEFTT resultAction:^{
           [weakSelf saveBtnClick];
       }];
    [self.navView.rightFirstBtn setTitleColor:[UIColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];

    [self initWithUI];
}

- (void)initWithUI{

    _pid = @"2f9d9c27c63546b8adf8b44d5ec6b67a";
    _subjectBeanId = @"";
    self.tabV.delegate = self;
    self.tabV.dataSource = self;
    self.tabV.rowHeight = 50;
    [self.view addSubview:self.tabV];
    [self initMangerWithData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar navBarBottomLineHidden:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar navBarBottomLineHidden:true];
}

- (void)initMangerWithData{
    weakSelf(self);
    [MBProgressHUD showLoadingCustomtoView:ApplicationKeyWindow animated:YES];
    [DCNetworkingRequest requestWithURLString:StudySubjectMangerPath params:@{@"pid":_pid} method:POST withMappingObject:@"DCJoinStudyMangerModel" success:^(DCJoinStudyMangerModel *responseObject) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        if (responseObject.code == 200) {
            if (responseObject.obj.count > 0) {
                [weakSelf.datasource removeAllObjects];
                [weakSelf.datasource addObjectsFromArray:responseObject.obj];
                [weakSelf.tabV reloadData];
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
    if (_subjectBeanId.length == 0) {
        [MBProgressHUD showError:@"请选择科目"];
        return;
    }
    weakSelf(self);
    [MBProgressHUD showLoadingCustomtoView:ApplicationKeyWindow animated:YES];
    [DCNetworkingRequest requestWithURLString:SaveStudyJectMangerPath params:@{@"subjectBeanId":_subjectBeanId} method:POST withMappingObject:@"DCNetworkingReultModel" success:^(DCNetworkingReultModel *responseObject) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        if (responseObject.code == 200) {
             
            if (weakSelf.isFromFirstLogin) {
                DCNavigationVC *nav = [[DCNavigationVC alloc]initWithRootViewController:[[DCRootTabbarVC alloc]init]];
                [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            }else{
                [weakSelf.navigationController popViewControllerAnimated:true];
            }
            [MBProgressHUD showSuccess:responseObject.msg];
            
        }else{
            [MBProgressHUD showError:responseObject.msg];
        }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        [MBProgressHUD showError:errorDescription];
    }];
    
}

- (void)setlectWithArrDela:(NSString *)stydi{
    
    if (self.selectArr.count == 0) {
        [self.selectArr addObject:stydi];
    }else{
        
        //数据是否存在于本地
        BOOL isContain = NO;
        for (int k = 0; k < self.selectArr.count; k++) {
            NSString *stId = self.selectArr[k];
            if ([stId isEqualToString:stydi]) {
                [self.selectArr removeObjectAtIndex:k];
                isContain = true;
                break;
            }
        }
        if (!isContain) {
            [self.selectArr addObject:stydi];
        }
        
    }
    
    if (self.selectArr.count == 0) {
        
    }else if (self.selectArr.count == 1){
        _subjectBeanId = self.selectArr.firstObject;
    }else{
        _subjectBeanId = [self.selectArr componentsJoinedByString:@","];
    }
    
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DCListModel *listM = self.datasource[section];
    return listM.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     DCChooseTestCell *cell = [DCChooseTestCell cellWithTableView:tableView];
    cell.isFromStudyManger = true;
    DCListModel *listM = self.datasource[indexPath.section];
    DCObjModel *M = listM.list[indexPath.row];
    cell.titleName.text = M.subname;
    if (M.isSelect) {
        cell.selectImage.hidden = NO;
    }else{
        cell.selectImage.hidden = true;
    }
    
     return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DCListModel *listM = self.datasource[indexPath.section];
    DCObjModel *M = listM.list[indexPath.row];
    M.isSelect = !M.isSelect;
    [self.tabV reloadData];
    [self setlectWithArrDela:M.studyId];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *heaser = [[UIView alloc]initWithFrame:CGRectMake(0, 0,KScreenWidth, 50)];
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, KScreenWidth-20, 50)];

    heaser.backgroundColor = [UIColor colorWithHexString:@"#F7F8FA" alpha:1];
    lb.textColor = [UIColor colorWithHexString:@"#999999"];
    lb.font = KFont(14);
    DCListModel *listM = self.datasource[section];
    lb.text = listM.title;
    [heaser addSubview:lb];
    return heaser;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    return view;

}

-(NSMutableArray *)selectArr{
    if (!_selectArr) {
        _selectArr = [NSMutableArray array];
    }
    return _selectArr;
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
