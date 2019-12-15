//
//  DCItemToolView.h
//  DCStudyBank
//
//  Created by fillinse on 2019/12/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCItemToolView : UIView
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)array result:(void(^)(int type))result;
@end

NS_ASSUME_NONNULL_END
