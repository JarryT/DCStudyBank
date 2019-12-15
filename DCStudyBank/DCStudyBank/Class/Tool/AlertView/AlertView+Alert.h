//
//  AlertView+Alert.h
//  JiaMei
//
//  Created by 汤军 on 2018/4/10.
//  Copyright © 2018年 TJarry. All rights reserved.
//

#import "AlertView.h"
#import "BasicBlock.h"
@interface AlertView (Alert)

//两个按钮
- (instancetype)initWithIconName:(NSString *)iconName content:(NSString *)content cancelBlock:(ActionBlock)cancel doneBlock:(ActionBlock)done;
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content cancelBlock:(ActionBlock)cancel doneBlock:(ActionBlock)done;
- (instancetype)initWithContent:(NSString *)content cancelBlock:(ActionBlock)cancel doneBlock:(ActionBlock)done;

//一个按钮
- (instancetype)initWithIconName:(NSString *)iconName content:(NSString *)content completeBlock:(ActionBlock)complete;
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content completeBlock:(ActionBlock)complete;
- (instancetype)initWithContent:(NSString *)content completeBlock:(ActionBlock)complete;

@end
