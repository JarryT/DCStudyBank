//
//  DCDatiTitlemSubCell.m
//  DCStudyBank
//
//  Created by mac on 2019/12/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCDatiTitlemSubCell.h"

@implementation DCDatiTitlemSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _chooseBtn.layer.borderWidth = 1;
    _chooseBtn.layer.borderColor = KMainColor.CGColor;
    _chooseBtn.layer.cornerRadius = 15;
    _chooseBtn.layer.masksToBounds = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (animated) {
        _chooseBtn.backgroundColor = KMainColor;
    }else{
        _chooseBtn.backgroundColor = [UIColor whiteColor];
    }
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
   
    DCDatiTitlemSubCell *cell = [tableView dequeueReusableCellWithIdentifier:DCDatiTitlemSubCellId];
    if (nil == cell) {
    
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] firstObject];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

@end
