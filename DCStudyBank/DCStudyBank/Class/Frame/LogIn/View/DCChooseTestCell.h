//
//  DCChooseTestCell.h
//  DCStudyBank
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DCSubJectStudyTwoListModel;
static NSString *DCChooseTestCellId = @"DCChooseTestCellId";

@protocol DCChooseTestCellDlectage <NSObject>

- (void)setlectStudyWith:(DCSubJectStudyTwoListModel  *)M;

@end
@interface DCChooseTestCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIImageView *selectImage;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,assign)BOOL isFromStudyManger;//是否来自科目cell
@property (nonatomic,strong)DCSubJectStudyTwoListModel *stlectM;
@property(weak,nonatomic)id<DCChooseTestCellDlectage>delgate;
@end

NS_ASSUME_NONNULL_END
