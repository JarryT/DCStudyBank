//
//  YaydTXSeperateLineCell.h
//  TailorX
//
//  Created by 倩倩 on 17/4/19.
//  Copyright © 2017年 utouu. All rights reserved.
//

#import "YaydTXSeperateLineCell.h"

static CGFloat DefaultCellSeperateLineHeight = 0.5;

@interface YaydTXSeperateLineCell()


@end

@implementation YaydTXSeperateLineCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    switch (self.cellLineType) {
        case TXCellSeperateLinePositionType_None: {
            self.bottomLineView.hidden = true;
        }
        break;
        
        case TXCellSeperateLinePositionType_Single:
        {
            self.bottomLineView.hidden = false;
        }
            break;
    }
}

- (UIView *)bottomLineView {
    NSInteger defaultMargin = 0;
    if (!_bottomLineView) {
        switch (self.cellLineRightMargin) {
            case TXCellRightMarginType0: {
                defaultMargin = 0;
            }
            break;
            
            case TXCellRightMarginType16: {
                defaultMargin = 16;
            }
            break;
                
            case TXCellRightMarginType13: {
                defaultMargin = 13;
            }
                break;
            
            case TXCellRightMarginType47: {
                defaultMargin = 47;
            }
            break;
                
            case TXCellRightMarginType85: {
                defaultMargin = 85;
            }
                break;
            
            case TXCellRightMarginType131: {
                defaultMargin = 131;
            }
            break;
            
            case TXCellRightMarginType159: {
                defaultMargin = 159;
            }
            break;
            case TXCellRightMarginType39: {
                defaultMargin = 39;
            }
                break;
            case TXCellRightMarginType20: {
                defaultMargin = 20;
            }
                break;
            case TXCellRightMarginType96: {
                defaultMargin = 96;
            }
                break;
        }

        if (self.cellLineRightMargin == TXCellRightMarginType13) {
            _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(defaultMargin, CGRectGetHeight(self.frame) - DefaultCellSeperateLineHeight, CGRectGetWidth(self.frame) - 2 * defaultMargin, DefaultCellSeperateLineHeight)];
        } else {
            _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(defaultMargin, CGRectGetHeight(self.frame) - DefaultCellSeperateLineHeight, CGRectGetWidth(self.frame) - defaultMargin, DefaultCellSeperateLineHeight)];
        }
        
        if(self.cellLineColor){
            _bottomLineView.backgroundColor = self.cellLineColor;
        }
        else{
            _bottomLineView.backgroundColor = kTableViewCellSpColor;
        }

        [self addSubview:_bottomLineView];
    }
    return _bottomLineView;
}


/**
 AccessoryView

 @return 箭头
 */
- (UIImageView *)setCustomAccessoryView {
    UIImageView *cusIndicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_main_arrow_right"]];
    cusIndicator.frame = CGRectMake(5, 0, 9, 14);
    return cusIndicator;
}

@end
