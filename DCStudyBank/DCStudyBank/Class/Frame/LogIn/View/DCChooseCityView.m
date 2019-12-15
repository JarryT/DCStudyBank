//
//  DCChooseCityView.m
//  DCStudyBank
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCChooseCityView.h"

@interface  DCChooseCityView()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tabV;

@end

@implementation DCChooseCityView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    _tabV.delegate = self;
    _tabV.dataSource = self;
    _tabV.showsVerticalScrollIndicator = NO;
}
- (IBAction)backBtnClick:(UIButton *)sender {
    if (_backBlock) {
        _backBlock(NO,@"");
    }
}

- (void)setAddressList:(NSArray *)addressList{
    _addressList = addressList;
    [self.tabV reloadData];
}
#pragma mark-UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _addressList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityId"];
    if (!cell) {
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CityId"];
    }
    cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#F7F8FA"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
       cell.textLabel.font = XYFont(14);
    cell.textLabel.textColor = kMainTitleColor;
    cell.textLabel.text = _addressList[indexPath.row][@"city"];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_backBlock) {
        _backBlock(true,_addressList[indexPath.row][@"city"]);
    }
}

@end
