//
//  DCChooseAddress.h
//  DCStudyBank
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCRegistrationInfoVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface DCChooseAddress : DCRegistrationInfoVC
@property(nonatomic,copy)void(^chooseAddressBlock)(NSString *address);
@end

NS_ASSUME_NONNULL_END
