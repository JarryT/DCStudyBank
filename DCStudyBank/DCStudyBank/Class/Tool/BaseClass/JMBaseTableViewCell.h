//
//  JMBaseTableViewCell.h
//  JiaMei
//
//  Created by 汤军 on 2018/4/11.
//  Copyright © 2018年 TJarry. All rights reserved.
//

#import "UIBaseTableViewCell.h"

static NSString* const JMBaseTableViewCellIdentifier = @"JMBaseTableViewCellIdentifier";
@class UIBaseModel;
@interface JMBaseTableViewCell : UIBaseTableViewCell

@property (strong, nonatomic)UIBaseModel *dataModel;

@end
