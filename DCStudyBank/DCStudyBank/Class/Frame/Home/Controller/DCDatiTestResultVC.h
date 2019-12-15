//
//  DCDatiTestResultVC.h
//  DCStudyBank
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "YABaseViewController.h"
#import "DCKaoDianModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCDatiTestResultVC : YABaseViewController
@property(nonatomic,strong)NSArray<DCKaoDianObjModel *> *list;
@property(nonatomic,assign)Itemtype itemtype;
@property(nonatomic,strong)NSString *keMuId;
@property(nonatomic,strong)NSString *keMuName;

@end

NS_ASSUME_NONNULL_END
