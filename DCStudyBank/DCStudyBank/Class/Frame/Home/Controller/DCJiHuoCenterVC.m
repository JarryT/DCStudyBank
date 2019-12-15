//
//  DCJiHuoCenterVC.m
//  DCStudyBank
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCJiHuoCenterVC.h"

@interface DCJiHuoCenterVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSInteger counts;
}
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *jihuoCode;
@property (weak, nonatomic) IBOutlet UIButton *jihuoBtn;
@property (weak, nonatomic) IBOutlet UIView *jiHuoConetView;
@property (weak, nonatomic) IBOutlet UITableView *tabV;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UIButton *allShowBtn;
@end

@implementation DCJiHuoCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    self.navTitle = @"参加考试";
    self.navView.titleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    self.account.delegate = self;
    self.jihuoCode.delegate = self;
    self.jihuoBtn.layer.cornerRadius = 22;
    self.jihuoCode.layer.masksToBounds = true;
    self.navView.sepView.hidden = NO;
    self.tabV.delegate = self;
    self.tabV.dataSource = self;
    self.tabV.rowHeight = 30;
    UIView *footr = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
    _allShowBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,0,120,30)];
    [_allShowBtn setTitle:@"全部显示" forState:UIControlStateNormal];
    [_allShowBtn addTarget:self action:@selector(ShowAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _allShowBtn.selected = NO;
    [_allShowBtn setTitleColor:KMainColor forState:UIControlStateNormal];
    _allShowBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _allShowBtn.titleLabel.font = KFont(13)
    [footr addSubview:_allShowBtn];
    self.tabV.tableFooterView = footr;
    
}

- (void)ShowAllBtnClick:(UIButton *)sender{
    _allShowBtn.selected = !_allShowBtn.selected;
    [self.tabV reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar navBarBottomLineHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar navBarBottomLineHidden:true];
}

- (IBAction)jihuoBtnClick:(UIButton *)sender {
    
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allShowBtn.isSelected?self.dataSource.count:2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JIHuoID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JIHuoID"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = KFont(13);
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    return cell;
}

#pragma mark-UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
       if (textField.tag) {
           switch (textField.tag) {
               case 16:{
                   counts = 11;
               }break;
               case 17:{
                   counts = 16;
               }break;
               default:
                   break;
           }
    }
    
    NSString *temp = [textField.text stringByReplacingCharactersInRange:range
                                                                withString:string];
    NSInteger isInputlen = counts - temp.length;
    NSString *newTextField = textField.text;
    if (!(newTextField.length == 1 && string.length == 0)) {
            ///< 输入操作，设置按钮高亮方法，或者其他控件颜色方法
        if (self.account.text.length > 0 && self.jihuoCode.text.length > 0) {
                 _jihuoBtn.userInteractionEnabled =YES;
                 _jihuoBtn.backgroundColor = [UIColor colorWithHexString:@"#00C0AE" alpha:1];
        }
           
    } else {
            ///< 删除操作，设置按钮灰色方法，或者其他控件颜色方法
             _jihuoBtn.userInteractionEnabled =NO;
             _jihuoBtn.backgroundColor = [UIColor colorWithHexString:@"#00C0AE" alpha:0.4];
    }
   
    if (isInputlen >= 0) {
        return YES;
    }else{
        NSInteger len = string.length + isInputlen;
               NSRange rg = {0,MAX(len, 0)};
        if (rg.length > 0) {
                   NSString *strtext = [string substringWithRange:rg];
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:strtext]];
        }
        return NO;
        
    }
    
}
#pragma - lazy

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
       
        _dataSource = [NSMutableArray array];
        [_dataSource addObjectsFromArray:@[@"水里",@"一键",@"问里",@"二键"]];
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
