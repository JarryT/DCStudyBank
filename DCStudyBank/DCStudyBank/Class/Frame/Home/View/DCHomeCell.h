//
//  DCHomeCell.h
//  DCStudyBank
//
//  Created by mac on 2019/12/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *DCHomeCellId = @"DCHomeCellId";
@class DCHomeGroupModel,DCZhangJieObjModel;
@protocol DCHomeCellDelegate <NSObject>
- (void)editeStudyInfo:(NSString *)studyId;
@end
@interface DCHomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UIView *seperView;
@property (weak, nonatomic) IBOutlet UIImageView *stutusImg;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)DCHomeGroupModel *dataM;

@property(nonatomic,weak)id<DCHomeCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
