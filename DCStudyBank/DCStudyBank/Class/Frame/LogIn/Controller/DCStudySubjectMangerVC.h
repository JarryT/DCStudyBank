//
//  DCStudySubjectMangerVC.h
//  DCStudyBank
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCRegistrationInfoVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface DCStudySubjectMangerVC : DCRegistrationInfoVC
@property(nonatomic,assign)BOOL isFromFirstLogin;
@property(nonatomic,strong)NSString *pid;
@property(nonatomic,strong)NSString *subtype;
@end

NS_ASSUME_NONNULL_END
