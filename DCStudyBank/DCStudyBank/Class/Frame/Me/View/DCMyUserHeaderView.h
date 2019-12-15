//
//  DCMyUserHeaderView.h
//  DCStudyBank
//
//  Created by mac on 2019/11/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCMyUserHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *headerIcon;
@property (weak, nonatomic) IBOutlet UILabel *userNike;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@property (weak, nonatomic) IBOutlet UIButton *levBtn;

@property(nonatomic,copy)ActionInteger loginHeaderBtnblock;
@end

NS_ASSUME_NONNULL_END
