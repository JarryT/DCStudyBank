//
//  PersistManager+Archieve.m
//  CTTAPP
//
//  Created by 汤军 on 2017/11/3.
//  Copyright © 2017年 TJarry. All rights reserved.
//

#import "PersistManager+Archieve.h"

@implementation PersistManager (Archieve)




+ (BOOL)archieveForUser:(NSString *)userId withObject:(id)object forKey:(NSString *)key{
    
    NSString *path = [self documentDirectoryPathForUser:userId withKey:key];
    
    return [NSKeyedArchiver archiveRootObject:object toFile:path];
}

+ (id)objectForUser:(NSString *)userId withKey:(NSString *)key{
    
    NSString *path = [self documentDirectoryPathForUser:userId withKey:key];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

+ (BOOL)deleteObjectForUser:(NSString *)userId withKey:(NSString *)key{
    
    NSString *filePath = [self documentDirectoryPathForUser:userId withKey:key];
    
    NSError *error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        return [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    }else{
        return NO;
    }
}


+ (NSString *)documentDirectoryPathForUser:(NSString *)userId withKey:(NSString *)key{
    NSString *documentDirectoryPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    if (userId == nil) { userId = @""; }
    NSString *pathStr=[documentDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",userId, key]];
    return pathStr;
}

//Archieved Data is NSMutableArray
+ (BOOL)deleteObjectForUser:(NSString *)userId withKey:(NSString *)key atIndex:(NSInteger)index{
    NSMutableArray *temp = [PersistManager objectForUser:userId withKey:key];
    if (!temp) { temp = [NSMutableArray array];}
    if (temp.count > index) {
        [temp removeObjectAtIndex:index];
    }
    return [PersistManager archieveForUser:userId withObject:temp forKey:key];
}

+ (BOOL)inserObject:(id)object forUser:(NSString *)userId withKey:(NSString *)key atIndex:(NSInteger)index{
    NSMutableArray *temp = [PersistManager objectForUser:userId withKey:key];
    if (!temp) { temp = [NSMutableArray array];}
    [temp insertObject:object atIndex:index];
    return [PersistManager archieveForUser:userId withObject:temp forKey:key];
}

+ (BOOL)addObject:(id)object forUser:(NSString *)userId withKey:(NSString *)key{
    NSMutableArray *temp = [PersistManager objectForUser:userId withKey:key];
    if (!temp) { temp = [NSMutableArray array];}
    [temp addObject:object];
    return [PersistManager archieveForUser:userId withObject:temp forKey:key];
}

+ (BOOL)moveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2 forUser:(NSString *)userId withKey:(NSString *)key{
    NSMutableArray *temp = [PersistManager objectForUser:userId withKey:key];
    if (!temp) { temp = [NSMutableArray array];}
    if (temp.count > index1 && temp.count > index2) {
        id object = [temp objectAtIndex:index1];
        [temp removeObjectAtIndex:index1];
        [temp insertObject:object atIndex:index2];
    }
    return [PersistManager archieveForUser:userId withObject:temp forKey:key];
}
+ (BOOL)exchangeObjectAtIndex:(NSUInteger)index1 withObjectAtIndex:(NSUInteger)index2 forUser:(NSString *)userId withKey:(NSString *)key{
    NSMutableArray *temp = [PersistManager objectForUser:userId withKey:key];
    if (!temp) { temp = [NSMutableArray array];}
    if (temp.count > index1 && temp.count > index2) {
        [temp exchangeObjectAtIndex:index1 withObjectAtIndex:index2];        
    }
    return [PersistManager archieveForUser:userId withObject:temp forKey:key];
}
+ (id)objectForUser:(NSString *)userId withKey:(NSString *)key atIndex:(NSUInteger)index{
    NSMutableArray *temp = [PersistManager objectForUser:userId withKey:key];
    if (!temp) { temp = [NSMutableArray array];}
    if (temp.count > index) {
       return [temp objectAtIndex:index];
    }
    return nil;
}


+ (BOOL)containsText:(NSString *)text withTextKey:(NSString *)textKey forUser:(NSString *)userId withArchieveKey:(NSString *)archieveKey{

    NSMutableArray *temp = [PersistManager objectForUser:userId withKey:archieveKey];
    if (!temp) { return NO;}

    BOOL contains = NO;
    int count = 0;
    for (NSDictionary *dict in temp) {
        if (count >= 20) {
            return NO;
        }
        if ((contains = [dict[textKey] isEqualToString:text])) {
            return YES;
        }
        count ++;
    }

    return NO;
}

+ (NSUInteger)indexForText:(NSString *)text withTextKey:(NSString *)textKey forUser:(NSString *)userId withArchieveKey:(NSString *)archieveKey{

    NSMutableArray *temp = [PersistManager objectForUser:userId withKey:archieveKey];

    BOOL contains = NO;
    for (NSDictionary *dict in temp) {
        if ((contains = [dict[textKey] isEqualToString:text])) {
            return [temp indexOfObject:dict];
        }
    }
    return 0;
}
@end
