//
//  AlertView.m
//  JiaMei
//
//  Created by 汤军 on 2018/4/8.
//  Copyright © 2018年 TJarry. All rights reserved.
//

#import "AlertView.h"

@interface AlertView()
@property (copy, nonatomic)ActionBlock cancelBlock;
@property (copy, nonatomic)ActionBlock doneBlock;
@property (assign, nonatomic)BOOL adjustSizeToSuperView;
@end


@implementation AlertView

- (instancetype)initWithIconName:(NSString *)iconName title:(NSString *)title content:(NSString *)content isSingleAction:(BOOL)singleAction cancelBlock:(ActionBlock)cancel doneBlock:(ActionBlock)done{

    if (self = [super init]) {

        self.clipsToBounds = YES;
        self.alertType = Alert;
        self.adjustSizeToSuperView = YES;
        self.removeFromSuperWhenDoneClicked = YES;
        self.contentViewAlignment = ContentViewAlignmentCenter;
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];//黑色遮罩
        [self addSubview:self.contentView];

        if (iconName) {
            self.iconView.image = [UIImage imageNamed:iconName];
            [self.contentView addSubview:self.iconView];
        }

        if (title) {
            self.titleLabel.text = title;
            [self.contentView addSubview:self.titleLabel];
        }

        self.contentLabel.text = content;
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.lineH];

        self.doneBlock = done;
        if (singleAction) {
            [self.contentView addSubview:self.doneButton];
        }else{
            self.cancelBlock = cancel;
            [self.contentView addSubview:self.cancelButton];
            [self.contentView addSubview:self.lineV];
            [self.contentView addSubview:self.doneButton];
        }
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];

    [self updateFrames];
}

- (void)updateFrames{

    CGFloat contentW = _contentViewWidth > 0 ? _contentViewWidth : 280;
    CGFloat contentH = 20;

    CGFloat pad = 10;//文字缩进
    CGFloat labelW = contentW - pad*2;

    CGFloat iconW = 40;
    CGFloat iconH = 40;
    if (_iconViewSize.width > 0 && _iconViewSize.width < contentW) {
        iconW = _iconViewSize.width;
    }
    if (_iconViewSize.height > 0) {
        iconH = _iconViewSize.height;
    }

    CGFloat lineWH = 0.5;
    CGFloat buttonW = (_doneButton.width > 0) ? _doneButton.width : contentW;
    CGFloat buttonH = (_doneButton.height > 0) ? _doneButton.height : 44;

    CGFloat space = 20;//竖直间距

    //计算文字高度
    CGFloat titleH = 25;
    if (self.titleLabel.text.length > 0) {
        titleH = [self.titleLabel.text sizeWithFont:self.titleLabel.font maxW:labelW].height + 5;
    }
    CGFloat textH = 0;
    if (self.contentLabel.text.length > 0){
        textH = [self.contentLabel.text sizeWithFont:self.contentLabel.font maxW:labelW].height + 5;
    }

    if (self.iconView.image) {//有图标（无标题）
        contentH = space*3 + iconH + textH + lineWH + buttonH;
    } else {//无图标
        if (self.titleLabel.text.length > 0) {//有标题
            contentH = space*3 + titleH + textH + lineWH + buttonH;
        } else {//没标题
            contentH = space*2 + textH + lineWH + buttonH;
        }
    }
    self.contentView.size = CGSizeMake(contentW, contentH);
    if (_contentViewAlignment == ContentViewAlignmentTopCenter){
        self.contentView.frame = CGRectMake((self.width - self.contentView.width)*0.5, 0, self.contentView.width, self.contentView.height);
    }else{//默认居中
        self.contentView.center = self.center;
    }

    //动态适应高度
    if (self.iconView.image) {//有图标（无标题）
        self.iconView.frame = CGRectMake((contentW - iconW)*0.5, space, iconW, iconH);
        self.contentLabel.frame = CGRectMake(pad, self.iconView.bottom + space, labelW, textH);
    } else {//无图标
        if (self.titleLabel.text.length > 0) {//有标题
            self.titleLabel.frame = CGRectMake(pad, space, labelW, titleH);
            self.contentLabel.frame = CGRectMake(pad, self.titleLabel.bottom + space, labelW, textH);
        } else {//没标题
            self.contentLabel.frame = CGRectMake(pad, space, labelW, textH);
        }
    }

    self.lineH.frame = CGRectMake(0, self.contentLabel.bottom + space, contentW, lineWH);
    
    if (self.cancelButton.superview) {
        buttonW = (contentW - lineWH)*0.5;
        self.cancelButton.frame = CGRectMake(0, self.lineH.bottom, buttonW, buttonH);
        self.lineV.frame = CGRectMake(self.cancelButton.right, self.lineH.bottom, lineWH, buttonH);
        self.doneButton.frame = CGRectMake(self.lineV.right, self.lineH.bottom, buttonW, buttonH);
    }else{
        self.doneButton.frame = CGRectMake((contentW - buttonW)*0.5, self.lineH.bottom, buttonW, buttonH);
    }

    self.lineH.hidden = (self.alertType == NoNetwork);
}

- (void)showTo:(UIView *)superView{

    if (self.adjustSizeToSuperView) {
        self.frame = superView.bounds;//to superView
        [self updateFrames];
    }
    [superView addSubview:self];
}

- (void)showTo:(UIView *)superView frame:(CGRect )frame{
    
    if (self.adjustSizeToSuperView) {
        self.frame = frame;//to superView
        [self updateFrames];
    }
    [superView addSubview:self];
}


- (void)cancelClick{
    [self removeFromSuperview];
    if (_cancelBlock) {
        _cancelBlock();
    }
}
- (void)doneClick{
    if (_removeFromSuperWhenDoneClicked) {
        [self removeFromSuperview];
    }
    if (_doneBlock) {
        _doneBlock();
    }
}


//setters
- (void)setCancelTitle:(NSString *)cancelTitle{
    _cancelTitle = cancelTitle;
    [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
}
- (void)setDoneTitle:(NSString *)doneTitle{
    _doneTitle = doneTitle;
    [self.doneButton setTitle:doneTitle forState:UIControlStateNormal];
}



//getters
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [self view];
        _contentView.layer.cornerRadius = 5;
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}
- (UIView *)lineH{
    if (!_lineH) {
        _lineH = [self view];
    }
    return _lineH;
}
- (UIView *)lineV{
    if (!_lineV) {
        _lineV = [self view];
    }
    return _lineV;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self label];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [self label];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconView;
}
- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [self button];
        [_cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:KTextColor forState:UIControlStateNormal];
    }
    return _cancelButton;
}
- (UIButton *)doneButton{
    if (!_doneButton) {
        _doneButton = [self button];
        [_doneButton addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
        [_doneButton setTitle:@"确定" forState:UIControlStateNormal];
        [_doneButton setTitleColor:KMainColor forState:UIControlStateNormal];
    }
    return _doneButton;
}

//convience
- (UILabel *)label{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = KMainColor;
    return label;
}

- (UIButton *)button{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = KFont(15);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    return button;
}
- (UIView *)view{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kTableViewCellSpColor;
    return view;
}
@end
