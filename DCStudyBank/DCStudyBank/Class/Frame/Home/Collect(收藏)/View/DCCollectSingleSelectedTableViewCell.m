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
@property (weak, nonatomic) IBOutlet UILabel *aLabel;
@property (weak, nonatomic) IBOutlet UILabel *bLabel;
@property (weak, nonatomic) IBOutlet UILabel *cLabel;
@property (weak, nonatomic) IBOutlet UILabel *dLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation DCCollectSingleSelectedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configWithModel:(DCKaoDianObjModel *)model
{
    _nameLabel.text = model.itemname;
    _titleLabel.text = model.cortype;
    NSArray *lables = @[_aLabel,_bLabel,_cLabel,_dLabel];
    for (int i = 0; i< model.optionsList.count; i ++) {
        DCKaoDianOptionsListModel *option = model.optionsList[i];
        UILabel *label = lables[i];
        label.text = [NSString stringWithFormat:@"%@.%@",option.opname,option.opvalue];
    }
    _timeLabel.text = model.colldate;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
