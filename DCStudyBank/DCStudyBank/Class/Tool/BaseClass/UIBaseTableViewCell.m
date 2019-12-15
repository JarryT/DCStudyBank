//
//  UIBaseTableViewCell.m
//  BarCodesAPP
//
//  Created by 汤军 on 2017/12/8.
//  Copyright © 2017年 TJarry. All rights reserved.
//

#import "UIBaseTableViewCell.h"

@interface UIBaseTableViewCell()


@end;

@implementation UIBaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(UITableViewCellStyle)cellStyle reuseIdentifier:(NSString *)reuseIdentifier{
    UIBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:cellStyle reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier{
    
    return [self cellWithTableView:tableView cellStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.separator];
    }
    return  self;
}

- (UIView *)separator{
    if (!_separator) {
        _separatorLeftPad = 10;
        _separatorRightPad = 0;
        _separatorHeight = 0.7;
        
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = kTableViewCellSpColor;
    }
    return _separator;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _separator.frame = CGRectMake(_separatorLeftPad, self.frame.size.height - _separatorHeight , (self.frame.size.width - _separatorLeftPad - _separatorRightPad), _separatorHeight);
    
    if (self.backgroundView) {
        self.backgroundView.frame = self.bounds;
    }
    
    if (self.selectedBackgroundView) {
        self.selectedBackgroundView.frame = self.bounds;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    if (_selectedBackgroundColor && selected) {
        self.contentView.backgroundColor = _selectedBackgroundColor;
    }else{
        self.contentView.backgroundColor = self.backgroundColor;
    }
}

- (void)setSeparatorHidden:(BOOL)separatorHidden{
    _separatorHidden = separatorHidden;

//    _separator.hidden = _separatorHidden;
}
//不调用 [super setBackgroundColor:backgroundColor];
- (void)setBackgroundColor:(UIColor *)backgroundColor{
	[super setBackgroundColor:backgroundColor];
    self.contentView.backgroundColor = self.backgroundColor;
}

@end
