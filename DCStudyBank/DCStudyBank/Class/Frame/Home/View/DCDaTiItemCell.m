//
//  DCDaTiItemCell.m
//  DCStudyBank
//
//  Created by mac on 2019/12/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCDaTiItemCell.h"
#import "DCKaoDianModel.h"
#import "DCDatiTitlemSubCell.h"
@interface DCDaTiItemCell()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation DCDaTiItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tabV.delegate = self;
    self.tabV.dataSource = self;
}


- (void)setAnwer:(NSString *)anwer{
    _anwer = anwer;
}
- (void)setKaoDianModel:(DCKaoDianObjModel *)KaoDianModel{
    _KaoDianModel = KaoDianModel;
    _titleName.text = KaoDianModel.itemname;
    _subTit.text = KaoDianModel.corname;
    
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _KaoDianModel.optionsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DCDatiTitlemSubCell *cell = [DCDatiTitlemSubCell cellWithTableView:tableView];
    DCKaoDianOptionsListModel *itemM = _KaoDianModel.optionsList[indexPath.row];
    [cell.chooseBtn setTitle:itemM.opname forState:UIControlStateNormal];
    cell.titleL.text = itemM.opvalue;
    
    if (itemM.isSelect) {
        cell.chooseBtn.backgroundColor = KMainColor;
       }else{
        cell.chooseBtn.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        DCKaoDianOptionsListModel *M = _KaoDianModel.optionsList[indexPath.row];
        if (!M.isSelect) {
            M.isSelect = YES;
        }
    
}
@end
