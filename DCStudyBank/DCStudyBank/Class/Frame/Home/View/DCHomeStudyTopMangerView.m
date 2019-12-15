//
//  DCHomeStudyTopMangerView.m
//  DCStudyBank
//
//  Created by mac on 2019/12/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCHomeStudyTopMangerView.h"
#import "DCHomeTopMangerCell.h"
#import "EBCustomBannerView.h"
#import "DCHomeKeMuModel.h"
@interface DCHomeStudyTopMangerView()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tabV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topH;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign)BOOL isHaveMore;
@end

@implementation DCHomeStudyTopMangerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    _isHaveMore = YES;
    _tabV.delegate = self;
    _tabV.dataSource = self;
    _tabV.rowHeight = 44;
    [self.dataSource addObjectsFromArray:@[@"中国近代史",@"计算机基础",@"公共政策",@"更多考试科目>",@"切换参加考试>"]];
   
}

- (void)setKeMulist:(NSArray *)keMulist{
    _keMulist = keMulist;
    DCkemuListModel *moreM = [DCkemuListModel new];
    moreM.subname = @"更多考试科目>";
    moreM.kemuId = @"001";
    DCkemuListModel *moreM1 = [DCkemuListModel new];
    moreM1.subname = @"切换参加考试>";
    moreM1.kemuId = @"002";
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:keMulist];
    [self.dataSource addObject:moreM];
    [self.dataSource addObject:moreM1];
    if (self.dataSource.count > 5) {
        _topH.constant = 240;
    }else{
        _topH.constant = 44*self.dataSource.count;
           
    }
    [self.tabV reloadData];
    
}

//取消
- (IBAction)scanceBtnClick:(UIButton *)sender {
    
     //[self.customView hide];
    if ([_delegate respondsToSelector:@selector(scanceHindeStudyView)]) {
        [_delegate scanceHindeStudyView];
    }
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCHomeTopMangerCell *cell = [DCHomeTopMangerCell cellWithTableView:tableView];
   
    if (indexPath.row == self.dataSource.count-2) {
        cell.contentLable.textColor = KMainColor;
    }else if (indexPath.row == self.dataSource.count-1){
        cell.contentLable.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    }
    DCkemuListModel *kemuM = self.dataSource[indexPath.row];
    cell.contentLable.text = kemuM.subname;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = 99;
    
    DCkemuListModel *moreMM = self.dataSource[indexPath.row];
    if ([_delegate respondsToSelector:@selector(sureChooseStudyWith:index:)]) {
        [_delegate sureChooseStudyWith:moreMM.subname index:moreMM.kemuId];
    }
}
#pragma lazy
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


@end
