//
//  DCStudyMoKaoCell.h
//  DCStudyBank
//
//  Created by mac on 2019/12/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *DCStudyMoKaoCellId = @"DCStudyMoKaoCellId";
@protocol DCStudyMoKaoCellDelegate <NSObject>
- (void)editeStudyInfo:(NSString *)studyId;
@end
@interface DCStudyMoKaoCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *numLable;

@property (weak, nonatomic) IBOutlet UILabel *naDulable;
@property(nonatomic,weak)id<DCStudyMoKaoCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
