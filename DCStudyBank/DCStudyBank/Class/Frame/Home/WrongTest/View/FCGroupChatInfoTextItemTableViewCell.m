//
//  FCGroupChatInfoTextItemTableViewCell.m
//  FunChat
//
//  Created by fillinse on 2019/11/26.
//  Copyright © 2019 fillinse. All rights reserved.
//

#import "FCGroupChatInfoTextItemTableViewCell.h"
@interface FCGroupChatInfoTextItemTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation FCGroupChatInfoTextItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateWithInfo:(NSDictionary *)info
{
    _leftLabel.text = [info objectSafeKey:@"left"];
    _rightLabel.text = [info objectSafeKey:@"right"];
}
- (void)configWithModel:(DCkemuListModel *)model
{
    _leftLabel.text = model.subname;
    _rightLabel.text = @"";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
