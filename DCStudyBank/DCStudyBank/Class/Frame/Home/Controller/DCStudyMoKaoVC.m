//
//  DCStudyMoKaoVC.m
//  DCStudyBank
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCStudyMoKaoVC.h"
#import "DCZHenTIKaoModel.h"
#import "DCStudyMoKaoCell.h"
@interface DCStudyMoKaoVC ()<UITableViewDelegate,UITableViewDataSource,DCStudyMoKaoCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *jxStudyView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jxVH;
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation DCStudyMoKaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"真题模考";
//    self.plainTableView.frame = CGRectMake(0,_jxStudyView.bottom,KScreenWidth,KScreenHeight-_jxStudyView.bottom);
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F7F8FA" alpha:1];
    self.plainTableView.backgroundColor = [UIColor colorWithHexString:@"#F7F8FA" alpha:1];
    [self.view addSubview:self.plainTableView];
    [self.plainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.left.right.mas_equalTo(self.view);
    
        make.top.mas_equalTo(self.jxStudyView.mas_bottom).offset(10);
    }];
    self.plainTableView.delegate = self;
    self.plainTableView.dataSource = self;
    self.plainTableView.rowHeight = 75;
    [self initWithData];
}

- (void)initWithData{
    weakSelf(self);
    [DCNetworkingRequest requestWithURLString:ZTMoKaoListPath params:@{@"cortype":@"真题模考",@"pageSize":@"10",@"isRandom":@"1"} method:POST withMappingObject:@"DCZHenTIKaoModel" success:^(DCZHenTIKaoModel *responseObject) {
        if (responseObject.code == 200) {
            if (responseObject.obj.count > 0) {
                [weakSelf.dataSource addObjectsFromArray:responseObject.obj];
                [weakSelf.plainTableView reloadData];
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

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)continueStudyBtnClick:(UIButton *)sender {
    
}

- (void)editeStudyInfo:(NSString *)studyId{
    
}
#pragma - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCStudyMoKaoCell *cell = [DCStudyMoKaoCell cellWithTableView:tableView];
    cell.delegate = self;
    DCZHenTIKaoObjModel *M = self.dataSource[indexPath.row];
    cell.titleName.text = M.corname;
    cell.numLable.text = [NSString stringWithFormat:@"%d人已做",[M.itemcount intValue]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma -lazy
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
