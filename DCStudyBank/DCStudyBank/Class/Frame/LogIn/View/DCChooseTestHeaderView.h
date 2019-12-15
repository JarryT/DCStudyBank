//
//  DCChooseTestHeaderView.h
//  DCStudyBank
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DCSubJectStudyObjModel;
@interface DCChooseTestHeaderView : UIView
+(instancetype)createJMDServeMoneySetHeaerView;
@property(nonatomic,strong)DCSubJectStudyObjModel *M;
@property(nonatomic,copy)ActionBlock isShowAllBlock;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@end

NS_ASSUME_NONNULL_END
