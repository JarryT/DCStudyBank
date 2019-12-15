//
//  DCCollectAnswerListItemTableViewCell.h
//  DCStudyBank
//
//  Created by fillinse on 2019/12/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCKaoDianModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCCollectAnswerListItemTableViewCell : UITableViewCell
- (void)configWithModel:(DCKaoDianObjModel *)model;
@end

NS_ASSUME_NONNULL_END
