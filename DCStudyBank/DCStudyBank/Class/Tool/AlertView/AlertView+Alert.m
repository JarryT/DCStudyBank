//
//  AlertView+Alert.m
//  JiaMei
//
//  Created by 汤军 on 2018/4/10.
//  Copyright © 2018年 TJarry. All rights reserved.
//

#import "AlertView+Alert.h"

@implementation AlertView (Alert)

- (instancetype)initWithContent:(NSString *)content cancelBlock:(ActionBlock)cancel doneBlock:(ActionBlock)done{
    return [self initWithIconName:nil title:nil content:content isSingleAction:NO cancelBlock:cancel doneBlock:done];
}
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content cancelBlock:(ActionBlock)cancel doneBlock:(ActionBlock)done{
    return [self initWithIconName:nil title:title content:content isSingleAction:NO cancelBlock:cancel doneBlock:done];
}

- (instancetype)initWithIconName:(NSString *)iconName content:(NSString *)content cancelBlock:(ActionBlock)cancel doneBlock:(ActionBlock)done{
    return [self initWithIconName:iconName title:nil content:content isSingleAction:NO cancelBlock:cancel doneBlock:done];
}

- (instancetype)initWithContent:(NSString *)content completeBlock:(ActionBlock)complete{
    return [self initWithIconName:nil title:nil content:content isSingleAction:YES cancelBlock:nil doneBlock:complete];
}

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content completeBlock:(ActionBlock)complete{
    return [self initWithIconName:nil title:title content:content isSingleAction:YES cancelBlock:nil doneBlock:complete];
}
- (instancetype)initWithIconName:(NSString *)iconName content:(NSString *)content completeBlock:(ActionBlock)complete{
    return [self initWithIconName:iconName title:nil content:content isSingleAction:YES cancelBlock:nil doneBlock:complete];
}

@end
