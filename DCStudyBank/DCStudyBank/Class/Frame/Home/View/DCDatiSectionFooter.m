//
//  DCDatiSectionFooter.m
//  DCStudyBank
//
//  Created by 汤军 on 2019/12/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCDatiSectionFooter.h"
#import <Masonry.h>

@implementation DCDatiSectionFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _answerLabel = [self label];
        _answerLabel.text = @"答案";
        _answerLabel.textColor = [UIColor  lightGrayColor];
        [self addSubview:_answerLabel];

        _answerTextLabel = [self label];
        _answerTextLabel.text = @"答案1";
        _answerTextLabel.textColor = [UIColor  blackColor];
        [self addSubview:_answerTextLabel];

        _jieXiLabel = [self label];
        _jieXiLabel.text = @"解析";
        _jieXiLabel.textColor = [UIColor  lightGrayColor];
        [self addSubview:_jieXiLabel];

       _jieXiTextLabel = [self label];
        _jieXiTextLabel.text = @"解析1";
       _jieXiTextLabel.textColor = [UIColor  blackColor];
        [self addSubview:_jieXiTextLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _answerLabel.frame = CGRectMake(10, 20, KScreenWidth - 20, 15);

    _answerTextLabel.frame = CGRectMake(10, CGRectGetMaxY(_answerLabel.frame) + 10, KScreenWidth - 20, 15);

    _jieXiLabel.frame = CGRectMake(10, CGRectGetMaxY(_answerTextLabel.frame) + 10, KScreenWidth - 20, 15);

    _jieXiTextLabel.frame = CGRectMake(10, CGRectGetMaxY(_jieXiLabel.frame) + 10, KScreenWidth - 20, self.frame.size.height - 15*3 - 80);
}

- (void)setAnswer:(NSString *)answer info:(NSString *)info {

}

- (UILabel *)label {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

@end
