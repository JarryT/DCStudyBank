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
    cell.item = nil;
    cell.model = nil;
    DCKaoDianOptionsListModel *itemM = _KaoDianModel.optionsList[indexPath.row];
    cell.item = _KaoDianModel;//题目
    cell.model = itemM; //选项
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DCKaoDianOptionsListModel *M = _KaoDianModel.optionsList[indexPath.row];
    DCDatiTitlemSubCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.item.type == ItemtypeSingle) {
        if (cell.item.selectedOptionsList.count == 1 ) {//已选中过
            if ([cell.item.selectedOptionsList.firstObject isEqual:M]) {//更改状态
                M.isSelect = !M.isSelect;
                [cell updateUI];
            } else { //更改选项
                for (DCKaoDianOptionsListModel *model in cell.item.selectedOptionsList) {
                    model.isSelect = false;
                }
                [cell.item.selectedOptionsList removeAllObjects];

                M.isSelect = true;
                [cell.item.selectedOptionsList addObject:M];
                [tableView reloadData];
            }
        } else {
            M.isSelect = true;
            [cell.item.selectedOptionsList addObject:M];
            [cell updateUI];
        }       
    } else if (cell.item.type == ItemtypeDouble) {

        M.isSelect = !M.isSelect;
        //之前已选中、当前操作为取消选中
        if ([cell.item.selectedOptionsList containsObject:M]) {
            [cell.item.selectedOptionsList removeObject:M];
        } else {
            [cell.item.selectedOptionsList addObject:M];
        }
        [cell updateUI];
    }
}
@end
