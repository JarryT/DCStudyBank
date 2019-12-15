//
//  DCDatiKaVC.h
//  DCStudyBank
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "YABaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class DCKaoDianObjModel;
@interface DCDatiKaVC : YABaseViewController

@property(nonatomic,strong)NSArray<DCKaoDianObjModel *> *list;

@property(nonatomic,assign)BOOL isAllCheck;//是否为全部解析
@property(nonatomic,assign)Itemtype itemtype;
@property(nonatomic,strong)NSString *keMuId;
@property(nonatomic,strong)NSString *keMuName;
@end

NS_ASSUME_NONNULL_END
