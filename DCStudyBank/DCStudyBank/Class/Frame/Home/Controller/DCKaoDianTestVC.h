//
//  DCKaoDianTestVC.h
//  DCStudyBank
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "YABaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

//答题和全部解析
@class DCKaoDianObjModel;
@interface DCKaoDianTestVC : YABaseViewController

@property (nonatomic,strong)NSArray<DCKaoDianObjModel *> *kaoDianList;

@property(nonatomic,assign)Itemtype itemtype;
@property(nonatomic,strong)NSString *keMuId;
@property(nonatomic,strong)NSString *keMuName;

@property(nonatomic,assign)BOOL isAllCheck;//是否为解析
@end

NS_ASSUME_NONNULL_END
