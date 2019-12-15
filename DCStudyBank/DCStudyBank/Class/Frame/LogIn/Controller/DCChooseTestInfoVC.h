//
//  DCChooseTestInfoVC.h
//  DCStudyBank
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YABaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface DCChooseTestInfoVC : YABaseViewController
@property(nonatomic,assign)BOOL fromLogin;//是否来自登录
@property(nonatomic,copy)ActionNSString saveStudySubJectBlock;
@end

NS_ASSUME_NONNULL_END
