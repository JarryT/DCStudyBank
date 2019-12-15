//
//  DCZHenTIKaoModel.h
//  DCStudyBank
//
//  Created by mac on 2019/12/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCNetworkingReultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCZHenTIKaoModel : DCNetworkingReultModel
@property(nonatomic,strong)NSArray *obj;
@end

@interface DCZHenTIKaoObjModel : NSObject
@property(nonatomic,strong)NSString *collid;
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
@property(nonatomic,strong)NSString *optionsList;
@end

@interface DCZHenTIKaoItemBeansModel : NSObject
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
@property(nonatomic,strong)NSString *itemsource;
@property(nonatomic,strong)NSString *itemtype;
@property(nonatomic,strong)NSString *optionsList;
@property(nonatomic,strong)NSString *subid;
@end

NS_ASSUME_NONNULL_END
