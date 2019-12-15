//
//  UIBaseTableViewCell.h
//  BarCodesAPP
//
//  Created by 汤军 on 2017/12/8.
//  Copyright © 2017年 TJarry. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString* const UIBaseTableViewCellIdentifier = @"UIBaseTableViewCellIdentifier";

@interface UIBaseTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;
+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(UITableViewCellStyle)cellStyle reuseIdentifier:(NSString *)reuseIdentifier;

@property (strong, nonatomic)UIView *separator;
@property (assign, nonatomic)CGFloat separatorHeight;//分割线高度、默认0.7
@property (assign, nonatomic)CGFloat separatorLeftPad;//分割线左间距、默认10
@property (assign, nonatomic)CGFloat separatorRightPad;//分割线右间距、默认0
@property (assign, nonatomic)BOOL separatorHidden;//默认 NO

@property (strong, nonatomic)UIColor *selectedBackgroundColor;
@end
