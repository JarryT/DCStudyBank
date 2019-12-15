//
//  DCCollectAnswerListItemTableViewCell.m
//  DCStudyBank
//
//  Created by fillinse on 2019/12/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCCollectAnswerListItemTableViewCell.h"
@interface DCCollectAnswerListItemTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation DCCollectAnswerListItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configWithModel:(DCKaoDianObjModel *)model
{
    _nameLabel.text = model.itemname;
    _titleLabel.text = model.cortype;
    _timeLabel.text = model.colldate;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
