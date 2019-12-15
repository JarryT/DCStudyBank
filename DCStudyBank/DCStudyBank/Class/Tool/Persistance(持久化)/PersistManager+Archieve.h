//
//  PersistManager+Archieve.h
//  CTTAPP
//
//  Created by 汤军 on 2017/11/3.
//  Copyright © 2017年 TJarry. All rights reserved.
//

#import "PersistManager.h"

@interface PersistManager (Archieve)
+ (BOOL)archieveForUser:(NSString *)userId withObject:(id)object forKey:(NSString *)key;
+ (BOOL)deleteObjectForUser:(NSString *)userId withKey:(NSString *)key;
+ (id)objectForUser:(NSString *)userId withKey:(NSString *)key;

//Archieved Data is NSMutableArray
+ (BOOL)deleteObjectForUser:(NSString *)userId withKey:(NSString *)key atIndex:(NSInteger)index;
+ (BOOL)inserObject:(id)object forUser:(NSString *)userId withKey:(NSString *)key atIndex:(NSInteger)index;
+ (BOOL)addObject:(id)object forUser:(NSString *)userId withKey:(NSString *)key;
+ (BOOL)exchangeObjectAtIndex:(NSUInteger)index1 withObjectAtIndex:(NSUInteger)index2 forUser:(NSString *)userId withKey:(NSString *)key;
+ (BOOL)moveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2 forUser:(NSString *)userId withKey:(NSString *)key;
+ (id)objectForUser:(NSString *)userId withKey:(NSString *)key atIndex:(NSUInteger)index;

//Archieved Data is NSMutableArray and NSMutableArray element is NSDictionary
+ (BOOL)containsText:(NSString *)text withTextKey:(NSString *)textKey forUser:(NSString *)userId withArchieveKey:(NSString *)archieveKey;
//Archieved Data is NSMutableArray and NSMutableArray element is NSDictionary，and text is Unique
+ (NSUInteger)indexForText:(NSString *)text withTextKey:(NSString *)textKey forUser:(NSString *)userId withArchieveKey:(NSString *)archieveKey;
@end
