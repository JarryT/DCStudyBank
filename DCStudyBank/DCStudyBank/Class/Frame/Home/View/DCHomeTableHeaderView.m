//
//  DCHomeTableHeaderView.m
//  DCStudyBank
//
//  Created by mac on 2019/12/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCHomeTableHeaderView.h"
#import "DCHomeListDataModel.h"
@interface DCHomeTableHeaderView()
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UILabel *currentLable;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIView *seprtView;
@property (weak, nonatomic) IBOutlet UIButton *editeBtn;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@end
@implementation DCHomeTableHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    _buyBtn.layer.borderWidth = 1;
    _buyBtn.layer.borderColor = KMainColor.CGColor;
    _buyBtn.layer.cornerRadius = 13;
    _buyBtn.layer.masksToBounds = true;

}

- (IBAction)buyBtnClick:(UIButton *)sender {
    
    if (_buyTestBlock) {
        _buyTestBlock(@"");
    }
}

- (IBAction)btnHeaderClick:(UIButton *)sender {
    if (_isShowAllBlock) {
        _isShowAllBlock();
    }
    
}

- (void)setModelM:(DCHomeListDataModel *)modelM{
    _modelM = modelM;
    _titleName.text = modelM.title;
    _currentLable.text = [NSString stringWithFormat:@"%@/%@",modelM.current,modelM.total];
    if (modelM.isOpen) {
        [_imageBtn setImage:[UIImage imageNamed:@"index_pot_a_icon"] forState:UIControlStateNormal];
        if (self.type == 1) {
             [_editeBtn setImage:[UIImage imageNamed:@"list_open_icon"] forState:UIControlStateNormal];
        }
        _seprtView.hidden = NO;
    }else{
        [_imageBtn setImage:[UIImage imageNamed:@"index_pot_icon"] forState:UIControlStateNormal];
        if (self.type == 1) {
            [_editeBtn setImage:[UIImage imageNamed:@"list_close_icon"] forState:UIControlStateNormal];
        }
        _seprtView.hidden = YES;
    }
       
}


- (void)setType:(NSInteger)type{
    _type = type;
    switch (type) {
        case 0:{
           
        }break;
        case 1:{
            _buyBtn.hidden = YES;
            _editeBtn.hidden = NO;

        }break;
                
        default:
            break;
    }
}

@end
