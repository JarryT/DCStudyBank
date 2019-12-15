//
//  DCChooseAddress.m
//  DCStudyBank
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCChooseAddress.h"
#import "DCChooseCityView.h"
@interface DCChooseAddress ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *addressList;
@property (weak, nonatomic) IBOutlet UITableView *tabV;
@property (nonatomic,strong)DCChooseCityView *cityView;
@property (nonatomic,strong)NSString *proveAddress;
@end

@implementation DCChooseAddress

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    self.navTitle = @"选择考地";
    self.navView.sepView.hidden =NO;
    [self getAddressList];
    _tabV.dataSource = self;
    _tabV.delegate = self;
    _tabV.showsVerticalScrollIndicator = NO;
    _cityView = [[NSBundle mainBundle] loadNibNamed:@"DCChooseCityView" owner:nil options:nil].firstObject;
    _cityView.frame = CGRectMake(KScreenWidth,kTopHeight,KScreenWidth,KScreenHeight-kTopHeight);
    weakSelf(self);
    _cityView.backBlock = ^(BOOL isSure, NSString * _Nonnull cityAddress) {
        [weakSelf setChooseAddress:isSure cityAddress:cityAddress];
    };
    [self.view addSubview:_cityView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar navBarBottomLineHidden:NO];
}
- (void)getAddressList{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"address" ofType:@"plist"];
    _addressList = [NSArray arrayWithContentsOfFile:path];
    [self.tabV reloadData];
    
}

- (void)setChooseAddress:(BOOL)isSure cityAddress:(NSString *)cityAddress{
    weakSelf(self);
    if (isSure) {
         [weakSelf sureBaoKaoAddress:[NSString stringWithFormat:@"%@%@",_proveAddress,cityAddress]];
        
        
    }else{
        [UIView animateWithDuration:0.25 animations:^{
               weakSelf.cityView.frame = CGRectMake(KScreenWidth,0,KScreenWidth, weakSelf.view.height);
           }];
    }
}

- (void)sureBaoKaoAddress:(NSString *)address{
    weakSelf(self);
    [MBProgressHUD showLoadingCustomtoView:ApplicationKeyWindow animated:YES];
    [DCNetworkingRequest requestWithURLString:BaoKaoAddressPath params:@{@"regional":address} method:POST withMappingObject:@"DCNetworkingReultModel" success:^(DCNetworkingReultModel *responseObject) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        if (responseObject.code == 200) {
            [DCUerLoginManger shareLoginInfoIntents].regional = address;
            if (weakSelf.chooseAddressBlock) {
                 
                   weakSelf.chooseAddressBlock(address);
               }
               [weakSelf.navigationController popViewControllerAnimated:true];
            [MBProgressHUD showSuccess:responseObject.msg];
        }else{
            [MBProgressHUD showError:responseObject.msg];
        }
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
        [MBProgressHUD hideHUDForView:ApplicationKeyWindow animated:true];
        [MBProgressHUD showError:errorDescription];
    }];

}
#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _addressList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CllId"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CllId"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = XYFont(14);
    cell.textLabel.textColor = kMainTitleColor;
    cell.textLabel.text = _addressList[indexPath.row][@"state"];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *cityList = _addressList[indexPath.row][@"cities"];
    _proveAddress = _addressList[indexPath.row][@"state"];
    _cityView.addressList = cityList;
    weakSelf(self);
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.cityView.frame = CGRectMake(0,kTopHeight,KScreenWidth,KScreenHeight-kTopHeight);
    }];
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
