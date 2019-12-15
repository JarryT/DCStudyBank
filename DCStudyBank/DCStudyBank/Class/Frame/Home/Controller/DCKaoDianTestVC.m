//
//  DCKaoDianTestVC.m
//  DCStudyBank
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCKaoDianTestVC.h"
#import "DCDatiKaVC.h"
#import "DCKaoDianModel.h"
#import "DCDaTiItemCell.h"
#import "DCShowLiulanView.h"
#import "EBCustomBannerView.h"

@interface DCKaoDianTestVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    dispatch_source_t timer;
}
@property (weak, nonatomic) IBOutlet SYButton *collection;
@property (weak, nonatomic) IBOutlet SYButton *datiKaBtn;
@property (weak, nonatomic) IBOutlet SYButton *liuLanBtn;
@property (weak, nonatomic) IBOutlet SYButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (weak, nonatomic) IBOutlet UIView *contView;
@property (nonatomic,strong) UICollectionView *collectionV;

/**
 *  当前的位置
 */
@property (weak, nonatomic) IBOutlet UIView *titleTopView;
@property (nonatomic, strong) NSIndexPath *indexPathNow;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UILabel *kotiStatus;
@property (weak, nonatomic) IBOutlet UILabel *kaotiNum;
@property (nonatomic,strong)NSMutableArray *kaoDianList;
@property (nonatomic) BOOL isStart;
@property (nonatomic) BOOL isPause;
@property (nonatomic) BOOL isCreat;
@property (nonatomic,assign) int timeCount;
@property (nonatomic,strong)DCShowLiulanView *liiLanV;
@property (nonatomic,strong)DCKaoDianObjModel *colletM;//收藏题目
@end

@implementation DCKaoDianTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.navTitle = @"考点智能练习";
    self.navView.backBtn.hidden = YES;
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(15, 7, 40, 30)];
    [back setImage:[UIImage imageNamed:@"navigation_back_w_icon"] forState:UIControlStateNormal];
    back.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navView.backView2 addSubview:back];

    _itemtype = ItemtypeDouble;
    [self initSetToolView];
    [self initWithPrepareLayout];
    [self getKaoDianListData];
    
}


- (void)backClick{
   
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initSetToolView{
    _collection.btnType = TOP;
    [_collection setImage:[UIImage imageNamed:@"shoucang_n"] forState:UIControlStateNormal];
    _collection.selected = NO;
    [_collection setImage:[UIImage imageNamed:@"shoucang_a"] forState:UIControlStateSelected];
    [_collection setTitle:@"收藏" forState:UIControlStateNormal];
    _collection.titleLabel.font = KFont(11);
    [_collection setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
     _datiKaBtn.btnType = TOP;
    [_datiKaBtn setImage:[UIImage imageNamed:@"datika_n"] forState:UIControlStateNormal];
    [_datiKaBtn setTitle:@"答题卡" forState:UIControlStateNormal];
    _datiKaBtn.titleLabel.font = KFont(11);
    [_datiKaBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    _liuLanBtn.btnType = TOP;
    [_liuLanBtn setImage:[UIImage imageNamed:@"liulan_n"] forState:UIControlStateNormal];
    [_liuLanBtn setTitle:@"浏览设置" forState:UIControlStateNormal];
    _liuLanBtn.titleLabel.font = KFont(11);
    [_liuLanBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
     _timeBtn.btnType = TOP;
    [_timeBtn setImage:[UIImage imageNamed:@"time_n"] forState:UIControlStateNormal];
    [_timeBtn setTitle:@"00:00" forState:UIControlStateNormal];
    _timeBtn.titleLabel.font = KFont(11);
    [_timeBtn setTitleColor:KMainColor forState:UIControlStateNormal];
}

- (void)initWithPrepareLayout {
    
       self.layout = [[UICollectionViewFlowLayout alloc] init];
       self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
       self.layout.itemSize = CGSizeMake(KScreenWidth,self.toolBarView.top-self.titleTopView.bottom-24);
       self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, KScreenWidth, self.toolBarView.top-self.titleTopView.bottom-24) collectionViewLayout:self.layout];
       
       self.collectionV.backgroundColor = [UIColor whiteColor];
       self.collectionV.showsVerticalScrollIndicator = NO;
       self.collectionV.showsHorizontalScrollIndicator = NO;
       self.collectionV.delegate = self;
       self.collectionV.dataSource = self;
       self.collectionV.pagingEnabled = YES;
       self.collectionV.bounces = YES;
       [self.collectionV registerNib:[UINib nibWithNibName:@"DCDaTiItemCell" bundle:nil] forCellWithReuseIdentifier:DCDaTiItemCellId];
       [self.contView addSubview:self.collectionV];
    
}
//获取试题列表
- (void)getKaoDianListData{
    weakSelf(self);

    NSString *type = @"";
    switch (_itemtype) {
        case ItemtypeSingle:
            type = @"单选";
            break;
        case ItemtypeDouble:
            type = @"多选";
            break;
    }
    [DCNetworkingRequest requestWithURLString:KaoDianTestPath params:@{@"cortype":_keMuName, @"pageSize":@(10),@"isRandom":@"1",@"itemtype":type} method:POST withMappingObject:@"DCKaoDianModel" success:^(DCKaoDianModel *responseObject) {
        int i = 0;
        for (DCKaoDianObjModel *object in responseObject.obj) {
            object.itemname = [NSString stringWithFormat:@"%d -- %@", i,object.itemname];
            i++;
            NSLog(@"%@",object.itemname);
        }
        if (responseObject.code == 200) {
            if (responseObject.obj.count > 0) {
                [weakSelf.kaoDianList addObjectsFromArray:responseObject.obj];
                weakSelf.kotiStatus.text = type;
                weakSelf.kaotiNum.text = [NSString stringWithFormat:@"1/%d",weakSelf.kaoDianList.count];
                weakSelf.colletM = weakSelf.kaoDianList.firstObject;
                [weakSelf.collectionV reloadData];
                [weakSelf startToCountTime];
            }
        }else{
            [MBProgressHUD showError:responseObject.msg];
        }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isShowBgImag = true;
    self.isShowWhiteImg = true;
}

- (IBAction)collectBtonClick:(SYButton *)sender {
    weakSelf(self);
    NSString *url = AddCollectPath;
    if (self.colletM.isCollect) {
        url = DeleteCollectPath;
    }
    [DCNetworkingRequest requestWithURLString:url params:@{@"itemid":self.colletM.itemid} method:POST withMappingObject:@"DCNetworkingReultModel" success:^(DCNetworkingReultModel *responseObject) {
        if (responseObject.code == 200) {
            weakSelf.colletM.isCollect = true;
            weakSelf.collection.selected = weakSelf.colletM.isCollect;
            [MBProgressHUD showSuccess:responseObject.msg];
        }else{
            [MBProgressHUD showError:responseObject.msg];
        }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
        
    }];
}

- (IBAction)daTiKaBtnClick:(SYButton *)sender {
    
    DCDatiKaVC *VC = [[DCDatiKaVC alloc]init];
    VC.list = _kaoDianList;
    VC.keMuId = _keMuId;
    VC.keMuName = _keMuName;
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)liuLanBtnClick:(SYButton *)sender {
   
    [self ShowSUIIniww];
}

- (void)ShowSUIIniww{
    weakSelf(self);
    _liiLanV = [[NSBundle mainBundle] loadNibNamed:@"DCShowLiulanView" owner:nil options:nil].firstObject;
    _liiLanV.frame = CGRectMake(0, 0,KScreenWidth,self.toolBarView.top);
    _liiLanV.setUiStyleBlock = ^(NSInteger integer) {
        [weakSelf setUIStyleWith:integer];
    };
    [self.view addSubview:_liiLanV];
}
//设置UI样式
- (void)setUIStyleWith:(NSInteger)type{
    switch (type) {
        case 1:{
            
        }break;
        case 2:{
            self.view.backgroundColor = [UIColor colorWithHexString:@"#333333"];
            self.toolBarView.backgroundColor = [UIColor colorWithHexString:@"#333333"];
            self.collectionV.backgroundColor = [UIColor colorWithHexString:@"#333333"];
            self.isShowBgImag = NO;
            self.navView.backView1.backgroundColor = [UIColor colorWithHexString:@"#333333"];
            self.navView.backView2.backgroundColor = [UIColor colorWithHexString:@"#333333"];
            self.toolBarView.backgroundColor = [UIColor colorWithHexString:@"#333333"];
                       
        }break;
        case 3:{
                      
        }break;
        case 4:{
                                 
        }break;
            
        default:
            break;
    }
    
}

- (IBAction)timeBtn:(SYButton *)sender {
}

#pragma mark-UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.kaoDianList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DCDaTiItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCDaTiItemCellId forIndexPath:indexPath];
    cell.KaoDianModel = self.kaoDianList[indexPath.item];
    [cell.tabV reloadData];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint pInView = [self.view convertPoint:self.collectionV.center toView:self.collectionV];
    self.indexPathNow = [self.collectionV indexPathForItemAtPoint:pInView];
    self.colletM = self.kaoDianList[self.indexPathNow.row];
    if (self.colletM.isCollect) {
        self.collection.selected = true;
    }else{
        self.collection.selected = NO;
    }
    self.kaotiNum.text = [NSString stringWithFormat:@"%d/%d",self.indexPathNow.row+1,self.kaoDianList.count];
}

#pragma lazy
- (NSMutableArray *)kaoDianList{
    if (!_kaoDianList) {
        _kaoDianList = [NSMutableArray array];
    }
    return _kaoDianList;
}


#pragma 计时器
- (void)startToCountTime{
    weakSelf(self);
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    _isCreat = YES;

//    每秒执行一次
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        int hours = self->_timeCount / 3600;
        int minutes = (self->_timeCount - (3600*hours)) / 60;
        int seconds = _timeCount%60;
        NSString *strTime = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hours,minutes,seconds];
        
        dispatch_async(dispatch_get_main_queue(), ^{
//           ======在这根据自己的需求去刷新UI==============
             [weakSelf.timeBtn setTitle:strTime forState:UIControlStateNormal];
            
            
        });
        self->_timeCount ++;
    });
    
    dispatch_resume(timer);
    
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
