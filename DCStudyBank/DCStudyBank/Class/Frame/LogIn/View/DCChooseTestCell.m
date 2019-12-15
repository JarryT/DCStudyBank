//
//  DCChooseTestCell.m
//  DCStudyBank
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCChooseTestCell.h"

@implementation DCChooseTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
   
    DCChooseTestCell *cell = [tableView dequeueReusableCellWithIdentifier:DCChooseTestCellId];
    if (nil == cell) {
    
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] firstObject];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

 
    if (!self.isFromStudyManger) {
        
        if (selected) {
            
            self.selectImage.hidden = NO;
            if ([_delgate respondsToSelector:@selector(setlectStudyWith:)]) {
                [_delgate setlectStudyWith:self.stlectM];
            }
        }else{
            self.selectImage.hidden = YES;
        }
    }

}

- (void)setIsFromStudyManger:(BOOL)isFromStudyManger{
    _isFromStudyManger = isFromStudyManger;
}
@end
