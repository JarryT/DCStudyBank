//
//  DCChooseCityView.h
//  DCStudyBank
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCChooseCityView : UIView
@property(nonatomic,strong)NSArray *addressList;

@property(nonatomic,copy)void(^ backBlock)(BOOL isSure,NSString *cityAddress);
@end

NS_ASSUME_NONNULL_END
