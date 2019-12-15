//
//  BasicBlock.h
//  CTTAPP
//
//  Created by 汤军 on 2017/10/31.
//  Copyright © 2017年 TJarry. All rights reserved.
//

#ifndef BasicBlock_h
#define BasicBlock_h

#if NS_BLOCKS_AVAILABLE
typedef void (^ActionBlock)(void);
typedef void (^ActionBool)(BOOL Bool);
typedef void (^ActionNSString)(NSString *string);
typedef void (^ActionDictionary)(NSDictionary *dictionary);
typedef void (^ActionArray)(NSArray *array);
typedef void (^ActionInteger)(NSInteger integer);
typedef void (^ActionCGFloat)(CGFloat cgFloat);

#endif

#endif /* BasicBlock_h */
