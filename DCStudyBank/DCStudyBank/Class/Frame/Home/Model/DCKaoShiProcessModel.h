//
//  DCKaoShiProcessModel.h
//  DCStudyBank
//
//  Created by mac on 2019/12/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCNetworkingReultModel.h"

NS_ASSUME_NONNULL_BEGIN
@class DCKaoShiInfoM;
@interface DCKaoShiProcessModel : DCNetworkingReultModel
@property(nonatomic,strong)DCKaoShiInfoM *obj;
@end

@interface DCKaoShiInfoM : NSObject
@property(nonatomic,strong)NSString *jd;
@property(nonatomic,strong)NSString *yz;
@property(nonatomic,strong)NSString *subname;
@property(nonatomic,strong)NSString *zts;
@end
NS_ASSUME_NONNULL_END
