//
//  DCStudyHistoryVC.m
//  DCStudyBank
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCStudyHistoryVC.h"
#import "DCStudyHistoryCell.h"
#import "DCKaoDianModel.h"

@interface DCStudyHistoryVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger currentIndex;//当前选中的
}
@property (weak, nonatomic) IBOutlet UILabel *timesLable;
@property (weak, nonatomic) IBOutlet UILabel *useTime;
@property (weak, nonatomic) IBOutlet UILabel *numLable;
@property (weak, nonatomic) IBOutlet UIButton *noFinshBtn;
@property (weak, nonatomic) IBOutlet UIButton *finshBtn;
@property (strong, nonatomic) UIView *seprtView;
@property (weak, nonatomic) IBOutlet UIView *conetView;
@property (weak, nonatomic) IBOutlet UIView *btnConetView;
@property (weak, nonatomic) IBOutlet UITableView *tabV;
@property (weak, nonatomic) IBOutlet UIView *spView;

@end

@implementation DCStudyHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.navTitle = @"练习历史";
    [self setInitUIView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isShowWhiteImg = true;
    self.isShowBgImag = true;
}


- (void)setInitUIView{
    currentIndex = 20;
    _seprtView = [[UIView alloc]initWithFrame:CGRectMake(0,0, KScreenWidth*0.5, 1.5)];
    _seprtView.backgroundColor = KMainColor;
    [self.spView addSubview:_seprtView];
    self.tabV.rowHeight = 84;
    self.tabV.dataSource = self;
    self.tabV.delegate = self;
  
}
//获取试题列表
- (void)getKaoDianListData{
    weakSelf(self);
    [DCNetworkingRequest postString:AllResultQueryPath params:@{@"errresult":@"",@"":@""} withMappingObject:@"DCKaoDianModel" success:^(DCKaoDianModel *responseObject) {
        if (responseObject.code == 200) {
            if (responseObject.obj.count > 0) {
                NSMutableArray *array = [NSMutableArray array];
                for (int i = 0; i < responseObject.obj.count; i ++) {
                    DCKaoDianObjModel *info = responseObject.obj[i];
                    if (info.itemtype) {
                        if (info.itemtype.length > 0) {
                            [array addObject:info];
                        }
                    }
                }

            }
        }else{
            [MBProgressHUD showError:responseObject.msg];
        }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {

    }];
}
- (IBAction)nofinshBtnClick:(UIButton *)sender {
    weakSelf(self);
    if (currentIndex == sender.tag)return;
    if (sender.tag == 20) {
        [_finshBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_noFinshBtn setTitleColor:KMainColor forState:UIControlStateNormal];
        currentIndex = sender.tag;
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.seprtView.frame = CGRectMake(0,0,KScreenWidth*0.5, 1.5);
        } completion:^(BOOL finished) {
            [weakSelf.tabV reloadData];
        }];
        
    }else if(sender.tag == 21){
        [_noFinshBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_finshBtn setTitleColor:KMainColor forState:UIControlStateNormal];
        currentIndex = sender.tag;
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.seprtView.frame = CGRectMake(KScreenWidth*0.5, 0,KScreenWidth*0.5, 1.5);
        }completion:^(BOOL finished) {
            [weakSelf.tabV reloadData];
        }];
    }
}


#pragma mark-UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCStudyHistoryCell *cell = [DCStudyHistoryCell cellWithTableView:tableView];
    [cell setCellWithData:currentIndex];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
