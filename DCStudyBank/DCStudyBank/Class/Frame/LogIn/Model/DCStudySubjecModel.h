//
//  DCStudySubjecModel.h
//  DCStudyBank
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCStudySubjecModel : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSArray *list;
@end

@interface DClistModel : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSArray *list;
@end

NS_ASSUME_NONNULL_END
