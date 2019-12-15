//
//  DCJoinStudyMangerModel.h
//  DCStudyBank
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCNetworkingReultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCJoinStudyMangerModel : DCNetworkingReultModel
@property(nonatomic,strong)NSArray *obj;
@end

@interface DCListModel : NSObject
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSArray *list;
@end
@interface DCObjModel : NSObject
@property(nonatomic,assign) BOOL isSelect;
@property(nonatomic,strong) NSString *checktype;
@property(nonatomic,strong) NSString *studyId;
@property(nonatomic,strong) NSString *isdel;
@property(nonatomic,strong) NSString *islast;
@property(nonatomic,strong) NSString *ispay;
@property(nonatomic,strong) NSString *pid;
@property(nonatomic,strong) NSString *subname;
@property(nonatomic,strong) NSString *subrank;
@property(nonatomic,strong) NSString *subtype;
@property(nonatomic,strong) NSString *tupian;
@property(nonatomic,strong) NSString *twoList;
@end


NS_ASSUME_NONNULL_END
