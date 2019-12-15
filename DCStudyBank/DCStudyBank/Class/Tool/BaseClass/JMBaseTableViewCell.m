//
//  JMBaseTableViewCell.m
//  JiaMei
//
//  Created by 汤军 on 2018/4/11.
//  Copyright © 2018年 TJarry. All rights reserved.
//

#import "JMBaseTableViewCell.h"

@implementation JMBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.separatorHidden = false;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.separatorHidden = false;
    }
    return  self;
}

@end
