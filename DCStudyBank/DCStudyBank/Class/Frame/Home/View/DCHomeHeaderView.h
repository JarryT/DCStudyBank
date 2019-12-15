//
//  DCHomeHeaderView.h
//  DCStudyBank
//
//  Created by mac on 2019/11/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol DCHomeHeaderViewDelegate <NSObject>
- (void)studyWithJihuoCenter;

- (void)menuItemBtnClickWith:(NSInteger)type;//菜单栏

@end
@interface DCHomeHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *circleProgressView;
@property (nonatomic, strong) CircleProgressView *circleProgress;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *mentView;
@property (weak, nonatomic) IBOutlet UIView *botmmView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mentViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *botmmViewH;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UILabel *scoreSubL;
@property (weak, nonatomic) IBOutlet UILabel *studyNum;
@property (weak, nonatomic) IBOutlet UILabel *totalStudyNum;

@property (weak, nonatomic) IBOutlet UILabel *keName;
@property(nonatomic,weak)id<DCHomeHeaderViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
