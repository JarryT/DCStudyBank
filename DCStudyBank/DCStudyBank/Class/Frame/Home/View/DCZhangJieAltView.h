//
//  DCZhangJieAltView.h
//  DCStudyBank
//
//  Created by mac on 2019/12/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCZhangJieAltView : UIView
@property(nonatomic,copy)void(^btnBlock)(NSString *content,NSInteger index);
@end

NS_ASSUME_NONNULL_END
