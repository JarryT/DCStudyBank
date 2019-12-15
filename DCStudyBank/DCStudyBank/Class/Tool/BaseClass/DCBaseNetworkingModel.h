//
//  DCBaseNetworkingModel.h
//  DCStudyBank
//
//  Created by mac on 2019/12/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCBaseNetworkingModel : NSObject
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,assign)NSInteger code;
@property (assign, nonatomic) BOOL success;
@end

NS_ASSUME_NONNULL_END
