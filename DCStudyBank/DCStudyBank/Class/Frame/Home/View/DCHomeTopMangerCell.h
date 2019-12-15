//
//  DCHomeTopMangerCell.h
//  DCStudyBank
//
//  Created by mac on 2019/12/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *DCHomeTopMangerCellId = @"DCHomeTopMangerCellId";
@interface DCHomeTopMangerCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@end

NS_ASSUME_NONNULL_END
