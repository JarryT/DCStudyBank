//
//  DCHomeStudyTopMangerView.h
//  DCStudyBank
//
//  Created by mac on 2019/12/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class EBCustomBannerView;
@protocol DCHomeStudyTopMangerViewDelegate <NSObject>
- (void)sureChooseStudyWith:(NSString *)studyId index:(NSString *)index;
- (void)scanceHindeStudyView;
@end
@interface DCHomeStudyTopMangerView : UIView
@property(nonatomic,strong)NSArray *keMulist;
@property(nonatomic, weak) EBCustomBannerView *customView;
@property(nonatomic,weak)id<DCHomeStudyTopMangerViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
