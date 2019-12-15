//
//  DCDaTiItemCell.h
//  DCStudyBank
//
//  Created by mac on 2019/12/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCKaoDianModel.h"
NS_ASSUME_NONNULL_BEGIN
static NSString *DCDaTiItemCellId = @"DCDaTiItemCellId";

@protocol DCDaTiItemCellDlegate <NSObject>
- (void)anwerWith:(NSString *)anwerId;
@end
@interface DCDaTiItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIView *conetV;
@property (weak, nonatomic) IBOutlet UITableView *tabV;
@property (weak, nonatomic) IBOutlet UILabel *subTit;
@property (nonatomic,strong) NSString *anwer;
@property (nonatomic,strong) DCKaoDianObjModel *KaoDianModel;
@property (nonatomic,weak)id<DCDaTiItemCellDlegate>delegate;
@end

NS_ASSUME_NONNULL_END
