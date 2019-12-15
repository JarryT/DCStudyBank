//
//  DCHomeVC.m
//  DCStudyBank
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCHomeVC.h"
#import "DCHomeHeaderView.h"
#import "DCHomeTableHeaderView.h"
#import "DCHomeListDataModel.h"
#import "DCHomeCell.h"
#import "DCHomeStudyTopMangerView.h"
#import "DCMangerBtn.h"
#import "DCHomeStudyTopMangerView.h"
#import "EBCustomBannerView.h"
#import "DCChooseTestInfoVC.h"
#import "DCStudySubjectMangerVC.h"
#import "DCJiHuoCenterVC.h"
#import "DCStudyMoKaoVC.h"
#import "DCXYZhangJieTestVC.h"
#import "DCStudyHistoryVC.h"
#import "DCWrongTestVC.h"
#import "DCCollectMainVC.h"
#import "DCKaoDianTestVC.h"
#import "DCHomeKeMuModel.h"
#import "DCKaoShiProcessModel.h"
@interface DCHomeVC ()<UITableViewDelegate,UITableViewDataSource,DCHomeCellDelegate,DCHomeHeaderViewDelegate,DCHomeStudyTopMangerViewDelegate>
@property (nonatomic,strong) DCHomeHeaderView *topHeader;
@property (nonatomic,strong)NSMutableArray <DCHomeListDataModel *>*homeDataArr;
@property (nonatomic,strong) DCHomeStudyTopMangerView *studyMagerView;
@property(nonatomic,strong)DCMangerBtn *titleNameBtn;
@property(nonatomic,strong)NSMutableArray *keMuList;
@property(nonatomic,strong)NSString *keMuId;
@end

@implementation DCHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _keMuId = @"";
    [self setInitWith];
    [self getStudyCategoryData:NO];
}

- (void)setInitWith{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake((KScreenWidth-160)*0.5,0,160, 44)];
    [self.navView.backView2 addSubview:titleView];
    self.navTitle = @"";
    _titleNameBtn = [[NSBundle mainBundle] loadNibNamed:@"DCMangerBtn" owner:nil options:nil].firstObject;
    _titleNameBtn.frame = CGRectMake(0, 0, titleView.width, titleView.height);
    _titleNameBtn.titleName.text = @"工程管理";
    [_titleNameBtn addTarget:self action:@selector(studyMangerClick:) forControlEvents:UIControlEventTouchUpInside];
    _titleNameBtn.selected = NO;
    [titleView addSubview:_titleNameBtn];
    self.navView.backBtn.hidden = YES;
    NSArray *data = @[@{@"title":@"建设工程项目的组织与管理",@"current":@"100",@"total":@"30000",@"group":@[@{@"title":@"建设工程项目进度控制的目标和任务",@"current":@"0",@"total":@"1000"},@{@"title":@"施工方进度计划的类型及其作用",@"current":@"50",@"total":@"1000"},@{@"title":@"施工方进度计划的类型及其作用",@"current":@"50",@"total":@"1000"}]},@{@"title":@"建设工程项目进度控制",@"current":@"130",@"total":@"30000",@"group":@[@{@"title":@"建设工程项目进度控制",@"current":@"30",@"total":@"1000"},@{@"title":@"施工方进度计划",@"current":@"50",@"total":@"1000"},@{@"title":@"施工方进度计划的类型及其作用",@"current":@"50",@"total":@"1000"}]}];
    [self.homeDataArr addObjectsFromArray:[DCHomeListDataModel mj_objectArrayWithKeyValuesArray:data]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.groupTableView.frame = CGRectMake(0,kTopHeight,KScreenWidth,KScreenHeight-kTopHeight-kTabBarHeight);
    self.groupTableView.rowHeight = 75;
    [self.view addSubview:self.groupTableView];
    _topHeader = [[NSBundle mainBundle] loadNibNamed:@"DCHomeHeaderView" owner:nil options:nil].firstObject;
    _topHeader.delegate = self;
    _topHeader.frame = CGRectMake(0,0,KScreenWidth,525);
    self.groupTableView.tableHeaderView = _topHeader;
    [self.view addSubview:self.groupTableView];
    
}
//获取考试科目
- (void)getStudyCategoryData:(BOOL)isLoadTips{
    weakSelf(self);
    [DCNetworkingRequest requestWithURLString:HomeStudyCategoryPath params:@{} method:POST withMappingObject:@"DCHomeKeMuModel" success:^(DCHomeKeMuModel *responseObject) {
        if (responseObject.code == 200) {
            if (responseObject.obj.kemu.count > 0) {
                [weakSelf.keMuList removeAllObjects];
                [weakSelf.keMuList addObjectsFromArray:responseObject.obj.kemu];
                DCkemuListModel *keM = responseObject.obj.kemu.firstObject;
                weakSelf.keMuId = keM.kemuId;
                [weakSelf getUserKaoShiInfo];
                weakSelf.titleNameBtn.titleName.text = keM.subname;
            }
        }else{
            [MBProgressHUD showError:responseObject.msg];
        }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
        
    }];
}

//获取考试信息
- (void)getUserKaoShiInfo{
    weakSelf(self);
    [DCNetworkingRequest requestWithURLString:GetUserSecorePath params:@{@"KaoshiKMId":_keMuId} method:POST withMappingObject:@"DCKaoShiProcessModel" success:^(DCKaoShiProcessModel *responseObject) {
        if (responseObject.code == 200) {
            weakSelf.topHeader.circleProgress.percent = [responseObject.obj.jd floatValue];
            weakSelf.topHeader.keName.text = responseObject.obj.subname;
            weakSelf.topHeader.studyNum.text = responseObject.obj.yz;
            weakSelf.topHeader.totalStudyNum.text = responseObject.obj.zts;
            
        }else{
            [MBProgressHUD showError:responseObject.msg];
        }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
        
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.isShowBgImag = true;
   
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
     
}

//编辑学习资料参加考试
- (void)editeStudyInfo:(NSString *)studyId{
    
}
//购买课程
- (void)buyStudyInfo:(NSString *)studyId{
    
}
//工程管理
-(void)studyMangerClick:(DCMangerBtn *)sender{

    self.studyMagerView = [[NSBundle mainBundle] loadNibNamed:@"DCHomeStudyTopMangerView" owner:nil options:nil].firstObject;
    self.studyMagerView.delegate = self;
    EBCustomBannerView *cv = [EBCustomBannerView showCustomView:self.studyMagerView block:^(EBCustomBannerViewMaker *make) {
           make.portraitFrame = UIScreen.mainScreen.bounds;
           make.portraitMode = EBCustomViewAppearModeTop;
           make.stayDuration = 0;
       }];
    self.studyMagerView.keMulist = self.keMuList;
    self.studyMagerView.customView = cv;
    
}

#pragma mark-DCHomeStudyTopMangerViewDelegate

- (void)sureChooseStudyWith:(NSString *)studyId index:(NSString *)index{
    [self scanceHindeStudyView];
    if ([index isEqualToString:@"001"]) {//更多考试科目
        DCStudySubjectMangerVC *vc = [[DCStudySubjectMangerVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([index isEqualToString:@"002"]){//切换考试科目
        DCChooseTestInfoVC *vc = [[DCChooseTestInfoVC  alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        self.titleNameBtn.titleName.text = studyId;
    }
}

- (void)scanceHindeStudyView{
    _titleNameBtn.selected = NO;
    [UIView animateWithDuration:0 animations:^{
        self.studyMagerView.frame = CGRectMake(0,-KScreenHeight, KScreenWidth, KScreenHeight);
    }];
}
#pragma mark-DCHomeHeaderViewDelegate
- (void)studyWithJihuoCenter{//激活
    DCJiHuoCenterVC *vc = [DCJiHuoCenterVC new];
    [self.navigationController pushViewController:vc animated:true];
}

//菜单栏点击事件
- (void)menuItemBtnClickWith:(NSInteger)type{
    switch (type) {
        case 0:{//0考点智能
            if (_keMuId == nil) {
                //提示错误;
                return;
            }
            DCKaoDianTestVC *vc = [DCKaoDianTestVC new];
            vc.itemtype = ItemtypeSingle;
            vc.keMuId = _keMuId;
            vc.keMuName = @"考点智能练习";
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 1:{//章节练习
            DCXYZhangJieTestVC *vc = [DCXYZhangJieTestVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 2:{//真题模考
            DCStudyMoKaoVC *VC = [DCStudyMoKaoVC new];
            [self.navigationController pushViewController:VC animated:YES];
        }break;
        case 3:{//错题练习
            DCWrongTestVC *vc = [DCWrongTestVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 4:{//我的收藏
            DCCollectMainVC *vc = [DCCollectMainVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 5:{//练题历史
            
            DCStudyHistoryVC *VC = [DCStudyHistoryVC new];
            [self.navigationController pushViewController:VC animated:YES];
        }break;
        case 6:{//答题社区
                
        }break;
        case 7:{//关于我们
                           
        }break;
            
        default:
            break;
    }
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

- (NSMutableArray *)keMuList{
    if (!_keMuList) {
        _keMuList = [NSMutableArray array];
    }
    return _keMuList;
}
@end
