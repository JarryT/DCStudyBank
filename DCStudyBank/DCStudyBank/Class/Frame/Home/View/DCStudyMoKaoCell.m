//
//  DCStudyMoKaoCell.m
//  DCStudyBank
//
//  Created by mac on 2019/12/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCStudyMoKaoCell.h"

@implementation DCStudyMoKaoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
   
    DCStudyMoKaoCell *cell = [tableView dequeueReusableCellWithIdentifier:DCStudyMoKaoCellId];
    if (nil == cell) {
    
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] firstObject];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (IBAction)editeBtnClick:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(editeStudyInfo:)]) {
        [_delegate editeStudyInfo:@""];
    }
}


@end
