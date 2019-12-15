//
//  DCZhangJieListModel.h
//  DCStudyBank
//
//  Created by mac on 2019/12/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCNetworkingReultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCZhangJieListModel : DCNetworkingReultModel
@property(nonatomic,strong)NSArray *obj;
@end

@interface DCZhangJieObjModel : NSObject
@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,strong)NSString *collid;
@property(nonatomic,strong)NSString *corhard;
@property(nonatomic,strong)NSString *corid;
@property(nonatomic,strong)NSString *corname;
@property(nonatomic,strong)NSString *cortype;
@property(nonatomic,strong)NSString *isSc;
@property(nonatomic,strong)NSArray *itemBeans;
@property(nonatomic,strong)NSString *itemBeans2;
@property(nonatomic,strong)NSString *itemcorrect;
@property(nonatomic,strong)NSString *itemcount;
@property(nonatomic,strong)NSString *itemid;
@property(nonatomic,strong)NSString *itemjiexi;
@property(nonatomic,strong)NSString *itemname;
@property(nonatomic,strong)NSString *itempic;
@property(nonatomic,strong)NSString *itemresult;
@property(nonatomic,strong)NSString *itemscore;
@property(nonatomic,strong)NSString *itemsource;
@property(nonatomic,strong)NSString *itemtype;
@property(nonatomic,strong)NSArray *optionsList;
@property(nonatomic,strong)NSArray *subid;

@end

@interface DCZhangJieOptionsModel : NSObject
@property(nonatomic,strong)NSString *itemid;
@property(nonatomic,strong)NSString *opid;
@property(nonatomic,strong)NSString *opname;
@property(nonatomic,strong)NSString *oppoint;
@property(nonatomic,strong)NSString *opvalue;
@end

NS_ASSUME_NONNULL_END
