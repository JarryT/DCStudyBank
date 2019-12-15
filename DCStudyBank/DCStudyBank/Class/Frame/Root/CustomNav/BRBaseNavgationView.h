//
//  BRBaseNavgationView.h
//  BROA
//
//  Created by fillinse on 2019/10/24.
//  Copyright © 2019 fillinse. All rights reserved.
//

typedef NS_ENUM(NSUInteger, BRBaseNavgationViewType) {
    BRBaseNavgationViewTypeBack,
};
#import <UIKit/UIKit.h>
#import "SYButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface BRBaseNavgationView : UIView
@property (nonatomic, assign) BOOL hasBack;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) BOOL titleCenter;
@property (nonatomic, assign) BOOL isRed;//红包头
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (nonatomic, assign) BOOL hasSearch;
@property (weak, nonatomic) IBOutlet UIView *backView1;
@property (weak, nonatomic) IBOutlet SYButton *rightFirstBtn;
@property (weak, nonatomic) IBOutlet SYButton *rightSecondBtn;
@property (weak, nonatomic) IBOutlet UIView *backView2;
@property (weak, nonatomic) IBOutlet UIView *sepView;
@property (nonatomic, assign) BOOL isBagImage;
@property (nonatomic, assign) BOOL isShowWhiteImg;
- (void)handleItemClickBlock:(void(^)(BRBaseNavgationViewType type))block;
//启用右边第一个按钮
- (void)setRightFirstName:(NSString *)name icon:(NSString *)icon btnType:(BtnType)btnType resultAction:(ActionBlock)block;
//启用右边第二个按钮
- (void)setRightSecondName:(NSString *)name icon:(NSString *)icon btnType:(BtnType)btnType resultAction:(ActionBlock)block;
//重置右边的按钮状态
- (void)resetRightBtnState;

- (void)handleSearchBarTextChangeClick:(void(^)(NSString *context))block;

- (void)updateRightBtn:(NSString *)right;


- (void)setRrihtFirstBtnImg:(NSString *)iconName name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
