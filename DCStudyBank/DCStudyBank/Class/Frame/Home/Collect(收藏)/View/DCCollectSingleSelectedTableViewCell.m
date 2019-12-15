//
//  DCCollectSingleSelectedTableViewCell.m
//  DCStudyBank
//
//  Created by fillinse on 2019/12/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCCollectSingleSelectedTableViewCell.h"

@interface DCCollectSingleSelectedTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation DCCollectSingleSelectedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)configWithModel:(DCKaoDianObjModel *)model
{
    _nameLabel.text = model.itemname;
    _titleLabel.text = model.cortype;
    for (int i = 0; i< model.optionsList.count; i ++) {
        UILabel *itemLabel = [[UILabel alloc] init];
        itemLabel.font = PF_R_Font(14);
        itemLabel.textColor = RGB(102, 102, 102);
        DCKaoDianOptionsListModel *option = model.optionsList[i];
        itemLabel.text = [NSString stringWithFormat:@"%@.%@",option.opname,option.opvalue];
        itemLabel.frame = CGRectMake(20, 22 * i, KScreenWidth - 30, 17);
        [self.contentView addSubview:itemLabel];
        weakSelf(self);
        [itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(10);
            make.height.mas_equalTo(17);
            make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(5 + 22 * i);
        }];
    }
    _timeLabel.text = model.colldate;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
