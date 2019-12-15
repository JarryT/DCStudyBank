//
//  DCKaoDianModel.h
//  DCStudyBank
//
//  Created by mac on 2019/12/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCNetworkingReultModel.h"

NS_ASSUME_NONNULL_BEGIN

@class DCKaoDianObjModel;
@interface DCKaoDianModel : DCNetworkingReultModel
@property(nonatomic,strong)NSArray<DCKaoDianObjModel *> *obj;

@end

@interface DCKaoDianObjModel : NSObject
@property(nonatomic,strong)NSString *collid;
@property(nonatomic,strong)NSString *corid;
@property(nonatomic,strong)NSString *corname;
@property(nonatomic,strong)NSString *cortype;
@property(nonatomic,strong)NSString *isSc;
@property(nonatomic,strong)NSString *itemBeans;
@property(nonatomic,strong)NSString *itemBeans2;
@property(nonatomic,strong)NSString *itemcorrect;
@property(nonatomic,strong)NSString *itemcount;
@property(nonatomic,strong)NSString *itemid;
@property(nonatomic,strong)NSString *itemjiexi;
@property(nonatomic,strong)NSString *itemname;
@property(nonatomic,strong)NSString *itempic;
@property(nonatomic,strong)NSString *itemresult;
@property(nonatomic,strong)NSString *itemscore;
@property(nonatomic,strong)NSString *itemtype;
@property(nonatomic,strong)NSArray *optionsList;//选项数组
@property(nonatomic,strong)NSMutableArray *selectedOptionsList;//选择的数组
@property(nonatomic,strong)NSString *subid;
@property(nonatomic,assign)BOOL isCollect;
@property(nonatomic,strong)NSString *isZhengQue; //0错误，1正确，2未答题
@property(nonatomic,strong)NSString *userAnwer;

- (Itemtype)type;
- (BOOL)isSelected;
@end

@interface DCKaoDianOptionsListModel : NSObject
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,strong)NSString *itemid;
@property(nonatomic,strong)NSString *opid;
@property(nonatomic,strong)NSString *opname;
@property(nonatomic,strong)NSString *oppoint;
@property(nonatomic,strong)NSString *opvalue;

@end

NS_ASSUME_NONNULL_END
