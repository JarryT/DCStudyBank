//
//  DCCountDownTime.m
//  DCStudyBank
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCCountDownTime.h"

@interface DCCountDownTime()
/** 倒计时时间*/
@property (nonatomic, assign) NSInteger timeOut;

@property (nonatomic, strong) dispatch_source_t timer;

@end
@implementation DCCountDownTime

static DCCountDownTime *_instance;
+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+ (DCCountDownTime *)sharedYaydTXCountDownTime{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color atBtn:(UIButton*)btn isHidden:(BOOL)isHidden titleColor:(UIColor *)tColor completeBlock:(CountComplete)complete {
    
    //倒计时时间
    self.timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        //倒计时结束，关闭
        if (self.timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                btn.hidden = false;
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitle:title forState:UIControlStateNormal];
                [btn setTitleColor:KMainColor forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
                if (complete) {
                    complete(true);
                }
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = self.timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                btn.hidden = isHidden;
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                btn.userInteractionEnabled = NO;
                if (tColor) {
                    [btn setTitleColor:tColor forState:UIControlStateNormal];
                } else {
                    [btn setTitleColor:KMainColor forState:UIControlStateNormal];
                }
                
            });
            self.timeOut--;
        }
    });
    dispatch_resume(_timer);
}

- (void)stopCountDownTimeAtBtn:(UIButton*)btn {
   
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        btn.userInteractionEnabled = YES;
        
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [btn setTitleColor:KMainColor forState:UIControlStateNormal];
    });
}
@end
