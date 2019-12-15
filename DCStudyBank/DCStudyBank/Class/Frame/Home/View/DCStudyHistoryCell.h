//
//  DCStudyHistoryCell.h
//  DCStudyBank
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *DCStudyHistoryCellID = @"DCStudyHistoryCellID";
@interface DCStudyHistoryCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setCellWithData:(NSInteger)type;
@end

NS_ASSUME_NONNULL_END
