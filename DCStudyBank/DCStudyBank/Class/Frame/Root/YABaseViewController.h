//
//  YABaseViewController.h
//  亿安优选
//
//  Created by 邓培 on 2019/9/5.
//  Copyright © 2019 yayd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRBaseNavgationView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YABaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BRBaseNavgationView *navView;

@property (nonatomic,copy) NSString *navTitle;

@property (nonatomic, assign) BOOL hasBack;
@property (nonatomic, assign) BOOL isCenter;
@property (nonatomic, assign) BOOL isShowBgImag;
@property (nonatomic, assign) BOOL isShowWhiteImg;
- (void)handleItemClickType:(BRBaseNavgationViewType)type;

@property(nonatomic, strong)UITableView *plainTableView;
@property(nonatomic, strong)UITableView *groupTableView;
@property(nonatomic, strong)NSMutableArray *datasource;
@end

NS_ASSUME_NONNULL_END
