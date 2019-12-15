//
//  DCSubJectStudyModel.h
//  DCStudyBank
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCNetworkingReultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCSubJectStudyModel : DCNetworkingReultModel
@property(nonatomic,strong) NSArray *obj;
@end

@interface DCSubJectStudyObjModel : NSObject
@property (nonatomic,assign) BOOL isOpen;
@property(nonatomic,strong) NSString *checktype;
@property(nonatomic,strong) NSString *keMuId;
@property(nonatomic,strong) NSString *isdel;
@property(nonatomic,strong) NSString *islast;
@property(nonatomic,strong) NSString *ispay;
@property(nonatomic,strong) NSString *pid;
@property(nonatomic,strong) NSString *subname;
@property(nonatomic,strong) NSString *subrank;
@property(nonatomic,strong) NSString *subtype;
@property(nonatomic,strong) NSString *tupian;
@property(nonatomic,strong) NSArray *twoList;
@end

@interface DCSubJectStudyTwoListModel : NSObject

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
