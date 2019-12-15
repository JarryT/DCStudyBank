//
//  DCLoginViewController.h
//  DCStudyBank
//
//  Created by mac on 2019/11/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCLoginViewController : UIViewController
@property(nonatomic,assign)NSInteger type ;//1登录，0注册
@property(assign, nonatomic) BOOL manuAppear;

@property(nonatomic,strong)NSDictionary *parms;//登录参数
@end

NS_ASSUME_NONNULL_END
