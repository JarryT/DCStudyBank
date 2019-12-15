//
//  UIButton+DCLayout.h
//  JGButtonLayout
//
//  Created by mac on 2019/8/9.
//  Copyright © 2019 JG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DCLayoutStatus){
    /** 正常位置，图左字右 */
    DCLayoutStatusNormal,
    /** 图右字左 */
    DCLayoutStatusImageRight,
    /** 图上字下 */
    DCLayoutStatusImageTop,
    /** 图下字上 */
    DCLayoutStatusImageBottom,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (DCLayout)

- (void)layoutWithStatus:(DCLayoutStatus)status andMargin:(CGFloat)margin;

@end

NS_ASSUME_NONNULL_END
