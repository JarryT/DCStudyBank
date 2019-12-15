//
//  DCCountDownTime.h
//  DCStudyBank
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CountComplete)(BOOL isComplete);
@interface DCCountDownTime : NSObject
/**
 开启倒计时
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color atBtn:(UIButton *)btn isHidden:(BOOL)isHidden titleColor:(UIColor *)tColor completeBlock:(CountComplete)complete;
/**
 停止倒计时
 */
- (void)stopCountDownTimeAtBtn:(UIButton *)btn;

+ (DCCountDownTime *)sharedYaydTXCountDownTime;
@end

NS_ASSUME_NONNULL_END
