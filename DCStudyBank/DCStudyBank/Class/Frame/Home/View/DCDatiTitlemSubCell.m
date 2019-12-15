//
//  DCDatiTitlemSubCell.m
//  DCStudyBank
//
//  Created by mac on 2019/12/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCDatiTitlemSubCell.h"
#import "DCKaoDianModel.h"

@implementation DCDatiTitlemSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _chooseBtn.layer.borderWidth = 1;
    _chooseBtn.layer.borderColor = KMainColor.CGColor;
    _chooseBtn.layer.cornerRadius = 15;
    _chooseBtn.layer.masksToBounds = true;
    _chooseBtn.userInteractionEnabled = false;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
   
    DCDatiTitlemSubCell *cell = [tableView dequeueReusableCellWithIdentifier:DCDatiTitlemSubCellId];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] firstObject];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)setModel:(DCKaoDianOptionsListModel *)model {
    _model = model;
    [self updateUI];
}

- (void)updateUI {

    [_chooseBtn setTitle:_model.opname forState:UIControlStateNormal];
    _titleL.text = _model.opvalue;

    if (_item.cellType == KaoDianCellTypeError) { //错误解析
        if ([_item.selectedOptionsList containsObject:_model]) {//已选择
             _chooseBtn.backgroundColor = [UIColor redColor];
            [_chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _chooseBtn.layer.borderColor = [UIColor clearColor].CGColor;
        } else {
            _chooseBtn.backgroundColor = [UIColor whiteColor];
            [_chooseBtn setTitleColor:KMainColor forState:UIControlStateNormal];
            _chooseBtn.layer.borderColor = KMainColor.CGColor;
        }
        if ( [_item isOptionCorrect:_model]) {//是否正确
            _chooseBtn.backgroundColor = KMainColor;
            [_chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _chooseBtn.layer.borderColor = [UIColor clearColor].CGColor;
        }
    } else { //全部解析 和 normal
        if (_model.isSelect) {
            _chooseBtn.backgroundColor = KMainColor;
            [_chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            _chooseBtn.backgroundColor = [UIColor whiteColor];
             [_chooseBtn setTitleColor:KMainColor forState:UIControlStateNormal];
        }
    }
}


@end
