//
//  FCGroupChatInfoTextItemTableViewCell.h
//  FunChat
//
//  Created by fillinse on 2019/11/26.
//  Copyright © 2019 fillinse. All rights reserved.
//
#import "DCHomeKeMuModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FCGroupChatInfoTextItemTableViewCell : UITableViewCell
- (void)updateWithInfo:(NSDictionary *)info;
- (void)configWithModel:(DCkemuListModel *)model;
@end

NS_ASSUME_NONNULL_END
