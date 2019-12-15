//
//  DCHomeKeMuModel.h
//  DCStudyBank
//
//  Created by mac on 2019/12/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCNetworkingReultModel.h"

NS_ASSUME_NONNULL_BEGIN

@class DCHomeObjModel;
@interface DCHomeKeMuModel : DCNetworkingReultModel
@property(nonatomic,strong)DCHomeObjModel *obj;
@end

@interface DCHomeObjModel : NSObject
@property(nonatomic,strong)NSString *kaoshi;
@property(nonatomic,strong)NSArray *kemu;
@end

@interface DCkemuListModel : NSObject
@property(nonatomic,strong)NSString *checktype;
@property(nonatomic,strong)NSString *kemuId;
@property(nonatomic,strong)NSString *isdel;
@property(nonatomic,strong)NSString *islast;
@property(nonatomic,strong)NSString *ispay;
@property(nonatomic,strong)NSString *pid;
@property(nonatomic,strong)NSString *subname;
@property(nonatomic,strong)NSString *subrank;
@property(nonatomic,strong)NSString *subtype;
@property(nonatomic,strong)NSString *tupian;
@property(nonatomic,strong)NSString *twoList;
@end

NS_ASSUME_NONNULL_END
