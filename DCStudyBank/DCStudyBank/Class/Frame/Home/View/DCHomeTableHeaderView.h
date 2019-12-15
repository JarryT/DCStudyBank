//
//  DCHomeTableHeaderView.h
//  DCStudyBank
//
//  Created by mac on 2019/12/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DCHomeListDataModel;
@interface DCHomeTableHeaderView : UIView
@property(nonatomic,strong)DCHomeListDataModel *modelM;
@property(nonatomic,copy)ActionBlock isShowAllBlock;
@property(nonatomic,copy)ActionNSString buyTestBlock;
@property(nonatomic,assign)NSInteger type;
@end

NS_ASSUME_NONNULL_END
