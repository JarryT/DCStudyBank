//
//  DCHomeTopMangerCell.m
//  DCStudyBank
//
//  Created by mac on 2019/12/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCHomeTopMangerCell.h"

@implementation DCHomeTopMangerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
   
    DCHomeTopMangerCell *cell = [tableView dequeueReusableCellWithIdentifier:DCHomeTopMangerCellId];
    if (nil == cell) {
    
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] firstObject];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}
@end
