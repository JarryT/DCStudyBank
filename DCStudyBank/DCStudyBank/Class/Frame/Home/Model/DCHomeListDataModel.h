//
//  DCHomeListDataModel.h
//  DCStudyBank
//
//  Created by mac on 2019/12/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class DCHomeGroupModel;
@interface DCHomeListDataModel : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *current;
@property(nonatomic,strong)NSString *total;
@property (nonatomic,assign) BOOL isOpen;
@property(nonatomic,strong)NSArray <DCHomeGroupModel *>*group;
@end

@interface DCHomeGroupModel : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *current;
@property(nonatomic,strong)NSString *total;
@end
NS_ASSUME_NONNULL_END
