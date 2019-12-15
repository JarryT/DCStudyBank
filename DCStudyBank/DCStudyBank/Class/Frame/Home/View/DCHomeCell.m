//
//  DCHomeCell.m
//  DCStudyBank
//
//  Created by mac on 2019/12/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCHomeCell.h"
#import "DCHomeListDataModel.h"
@implementation DCHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
   
    DCHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:DCHomeCellId];
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

- (void)setDataM:(DCHomeGroupModel *)dataM{
    _dataM = dataM;
    _titleName.text = dataM.title;
    _subTitle.text = [NSString stringWithFormat:@"%@/%@",dataM.current,dataM.total];
}
@end
