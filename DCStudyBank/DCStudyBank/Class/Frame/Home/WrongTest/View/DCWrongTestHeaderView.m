
//
//  DCWrongTestHeaderView.m
//  DCStudyBank
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCWrongTestHeaderView.h"

@interface DCWrongTestHeaderView()

@property (nonatomic, strong) NSMutableArray *buttonArray;
//底部
@property (nonatomic, strong) UIView *lineView;
@end

@implementation DCWrongTestHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setUpStatusButtonWithTitle:(NSArray *)titleArray
                       normalColor:(UIColor *)normalColor
                     selectedColor:(UIColor *)selectedColor
                         lineColor:(UIColor *)lineColor{
    NSInteger count = titleArray.count;
    float     width = self.frame.size.width / count;
    
    //线条
    if (lineColor) {
        self.lineView.frame = CGRectMake(width, 0, width, self.frame.size.height);
        _lineView.layer.cornerRadius = self.frame.size.height/2;
        _lineView.layer.masksToBounds = true;
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    
    
    //按钮创建
    for (int i = 0; i < count; i++) {
        UIButton *button = [self createButtonByIndex:i normalColor:normalColor selectedColor:selectedColor];
        CGFloat buttonX = width * i;
        button.frame     = CGRectMake(buttonX,
                                      0,
                                      width,
                                      self.frame.size.height);
        /// 标题
        [button setTitle:titleArray[i]
                forState:UIControlStateNormal];
    }
    
}
/// 创建button
- (UIButton *)createButtonByIndex:(NSInteger)index
                      normalColor:(UIColor *)normalColor
                    selectedColor:(UIColor *)selectedColor {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:(normalColor) ? normalColor: RGB(139, 141, 141) forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    /// 点击
    button.tag = index;
    [button addTarget:self action:@selector(buttonTouchEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [self.buttonArray addObject:button];
    /// 第一个默认选中
    if (index == 0) {
        button.selected = YES;
    }
    return button;
}

//状态切换
- (void)buttonTouchEvent:(UIButton *)button{
    if (button.tag == self.currentIndex) {
        return;
    }
    //代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(statusViewSelectIndex:)]) {
        [self.delegate statusViewSelectIndex:button.tag];
    }
    if (!_isScroll) {
        [self changeTag:button.tag];
    }
}

-(void)changeTag:(NSInteger)tag{
    // 选择当前的状态
    self.currentIndex = tag;
    UIButton *button  = self.buttonArray[tag];
    button.selected   = YES;
    // 关闭上一个选择状态
    for (int i = 0; i < self.buttonArray.count; i++) {
        if (i != self.currentIndex) {
            UIButton *button = self.buttonArray[i];
            button.selected = NO;
        }
    }
    // 移动横线到对应的状态
    if (self.lineView) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.lineView.frame;
            CGFloat count = tag;
            float origin = self.frame.size.width / self.buttonArray.count*count;
            frame.origin.x = origin;
            self.lineView.frame = frame;
        }];
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

//下面滑动的背景
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        [self addSubview:self.lineView];
    }
    return _lineView;
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    [self changeTag:selectIndex];
}

@end
