//
//  DCStudyMoKaoVC.m
//  DCStudyBank
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCStudyMoKaoVC.h"
#import "DCStudyMoKaoCell.h"
@interface DCStudyMoKaoVC ()<UITableViewDelegate,UITableViewDataSource,DCStudyMoKaoCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *jxStudyView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jxVH;

@end

@implementation DCStudyMoKaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"真题模考";
    self.plainTableView.frame = CGRectMake(0,_jxStudyView.bottom+10,KScreenWidth,KScreenHeight-_jxStudyView.bottom);
    self.plainTableView.delegate = self;
    self.plainTableView.dataSource = self;
    self.plainTableView.rowHeight = 75;
    [self.view addSubview:self.plainTableView];

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
    return 10;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCStudyMoKaoCell *cell = [DCStudyMoKaoCell cellWithTableView:tableView];
    cell.delegate = self;
    return cell;
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
