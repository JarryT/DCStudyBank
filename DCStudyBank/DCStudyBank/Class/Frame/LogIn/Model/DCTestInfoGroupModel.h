//
//  DCTestInfoGroupModel.h
//  DCStudyBank
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class DCTestInfoListModel;
@interface DCTestInfoGroupModel : NSObject
@property(nonatomic,copy)NSString *titele;
@property (nonatomic,assign) BOOL isOpen;
@property(nonatomic,strong)NSArray <DCTestInfoListModel *>*list;
@end

@interface DCTestInfoListModel : NSObject

@property(nonatomic,copy)NSString *title;

@end

NS_ASSUME_NONNULL_END
