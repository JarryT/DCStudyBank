//
//  DCKaoDianModel.h
//  DCStudyBank
//
//  Created by mac on 2019/12/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCNetworkingReultModel.h"

NS_ASSUME_NONNULL_BEGIN

@class DCKaoDianObjModel, DCKaoDianOptionsListModel;
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
@property(nonatomic,strong)NSArray<DCKaoDianOptionsListModel *> *optionsList;//选项数组
@property(nonatomic,strong)NSMutableArray<DCKaoDianOptionsListModel *> *selectedOptionsList;//选择的数组
@property(nonatomic,strong)NSString *subid;
@property(nonatomic,assign)BOOL isCollect;
@property(nonatomic,strong)NSString *userAnwer;

//收藏列表的时间
@property (nonatomic, copy) NSString * colldate;
//收藏的高
@property (nonatomic, assign) CGFloat height;

@property(nonatomic,assign)KaoDianCellType cellType;
@property(nonatomic,assign)CGFloat footerHeight;
- (Itemtype)type;
- (BOOL)isSelected;
- (BOOL)isAnswerCorrect;
- (BOOL)isOptionCorrect:(DCKaoDianOptionsListModel *)option;
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
