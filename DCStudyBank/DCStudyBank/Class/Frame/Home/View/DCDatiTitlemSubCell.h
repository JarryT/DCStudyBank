//
//  DCDatiTitlemSubCell.h
//  DCStudyBank
//
//  Created by mac on 2019/12/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DCDatiTitlemSubCellDelgate <NSObject>
- (void)anwerWith:(NSString *)itemid result:(NSString *)result;
@end
static NSString *DCDatiTitlemSubCellId = @"DCDatiTitlemSubCellId";
@interface DCDatiTitlemSubCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (nonatomic,weak)id<DCDatiTitlemSubCellDelgate>delegate;
@end

NS_ASSUME_NONNULL_END
