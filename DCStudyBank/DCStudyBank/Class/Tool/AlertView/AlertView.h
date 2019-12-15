//
//  AlertView.h
//  JiaMei
//
//  Created by 汤军 on 2018/4/8.
//  Copyright © 2018年 TJarry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicBlock.h"
//类型
typedef enum : NSUInteger {
    Alert,
    NoNetwork,
} AlertViewType;

//ContentView位置
typedef enum : NSUInteger {
    ContentViewAlignmentTopCenter,
    ContentViewAlignmentCenter,
}ContentViewAlignment;



@interface AlertView : UIView

@property (copy, nonatomic)NSString *cancelTitle;
@property (copy, nonatomic)NSString *doneTitle;

//布局
@property (assign, nonatomic)ContentViewAlignment contentViewAlignment;
@property (assign, nonatomic)CGFloat contentViewWidth;//content Width
@property (assign, nonatomic)CGSize iconViewSize;//icon Size

//修改view的样式
@property (strong, nonatomic)UIView *contentView;
@property (strong, nonatomic)UIImageView *iconView;
@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic)UILabel *contentLabel;
@property (strong, nonatomic)UIButton *doneButton;
@property (strong, nonatomic)UIButton *cancelButton;

@property (strong, nonatomic)UIView *lineH;
@property (strong, nonatomic)UIView *lineV;

@property (assign, nonatomic)AlertViewType alertType;

//点击确认后移除、默认yes
@property (assign, nonatomic)BOOL removeFromSuperWhenDoneClicked;


- (instancetype)initWithIconName:(NSString *)iconName title:(NSString *)title content:(NSString *)content isSingleAction:(BOOL)singleAction cancelBlock:(ActionBlock)cancel doneBlock:(ActionBlock)done;


//添加到父视图
- (void)showTo:(UIView *)superView;

- (void)showTo:(UIView *)superView frame:(CGRect )frame;
@end
