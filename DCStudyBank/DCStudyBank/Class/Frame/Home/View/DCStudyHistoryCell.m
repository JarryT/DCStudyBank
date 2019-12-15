//
//  DCStudyHistoryCell.m
//  DCStudyBank
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCStudyHistoryCell.h"
#import "CircleProgressView.h"
@interface DCStudyHistoryCell()
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet CircleProgressView *circleProgessV;


@end

@implementation DCStudyHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _circleProgessV.percent = 0.3;
    _circleProgessV.backgroundColor = [UIColor clearColor];
    _circleProgessV.progressBackgroundColor = [UIColor colorWithHexString:@"#F2F2F2" alpha:1];
    _circleProgessV.progressColor = KMainColor;
    _circleProgessV.progressWidth = 2;
    _circleProgessV.textFont = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    _circleProgessV.textColor = KMainColor;
    _circleProgessV.subTextFont = KFont(11);
    _circleProgessV.subTextColor = KTextColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    DCStudyHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:DCStudyHistoryCellID];
       if (nil == cell) {
       
           cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] firstObject];
       }
       cell.contentView.backgroundColor = [UIColor whiteColor];
       return cell;
}

- (void)setCellWithData:(NSInteger)type{
     self.circleProgessV.centerLabel.text = [NSString stringWithFormat:@"%.0f%%", self.circleProgessV.percent*100];
    if (type == 20) {
        _circleProgessV.centerTitleName.text = @"已做";
    }else{
        _circleProgessV.centerTitleName.text = @"正确率";
    }
}

@end
