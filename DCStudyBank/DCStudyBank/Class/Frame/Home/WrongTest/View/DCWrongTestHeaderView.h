//
//  DCWrongTestHeaderView.h
//  DCStudyBank
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DCWrongTestHeaderViewDelegate <NSObject>
/// 选中某个tab
- (void)statusViewSelectIndex:(NSInteger)index;
@end
@interface DCWrongTestHeaderView : UIView
/// 是否正在滑动
@property (nonatomic, assign) BOOL isScroll;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger selectIndex;
/// 代理
@property (nonatomic, weak) id <DCWrongTestHeaderViewDelegate>delegate;
/// 界面初始化
- (void)setUpStatusButtonWithTitle:(NSArray *)titleArray
                       normalColor:(UIColor *)normalColor
                     selectedColor:(UIColor *)selectedColor
                         lineColor:(UIColor *)lineColor;
/// 切换tag
-(void)changeTag:(NSInteger)tag;

@end

NS_ASSUME_NONNULL_END
