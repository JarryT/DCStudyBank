//
//  DCItemToolView.m
//  DCStudyBank
//
//  Created by fillinse on 2019/12/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCItemToolView.h"
@interface DCItemToolView ()
@property (nonatomic, copy) void(^itemClickBlock)(int type);
@property (nonatomic, strong) UIButton *lastBtn;//上一个选中的button
@end
@implementation DCItemToolView
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)array result:(void(^)(int type))result
{
    if (self = [super initWithFrame:frame]) {
        [self updateWithItems:array];
        _itemClickBlock = result;
    }
    return self;
}
- (void)updateWithItems:(NSArray *)items
{
    [self removeAllSubviews];
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.frame = self.bounds;
    [self addSubview:scroll];
    //目前没有启用scroll，如果启用可以吧item的宽固定，然后自适应scroll的contentsize.width
    CGFloat width = KScreenWidth/items.count;
    for (int i = 0; i < items.count; i ++) {
        NSDictionary *info = items[i];
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(0 + i * width, 0, width, self.bounds.size.height);
        [item setTitle:[info objectSafeKey:@"name"] forState:UIControlStateNormal];
        [item setTitle:[info objectSafeKey:@"name"] forState:UIControlStateSelected];
        item.tag = 100 + i;
        [item setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        [item setTitleColor:KMainColor forState:UIControlStateSelected];
        item.titleLabel.font = PF_R_Font(14);
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:item];
        if (i == 0) {
            [self itemClick:item];
        }
    }
}
- (void)itemClick:(UIButton *)item
{
    _lastBtn.selected = NO;
    _lastBtn = item;
    _lastBtn.selected = YES;
    if (_itemClickBlock) {
        _itemClickBlock((int)item.tag - 100);
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
