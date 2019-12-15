//
//  DCNetworkingRequest.h
//  DCStudyBank
//
//  Created by mac on 2019/12/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSUInteger, RequestStatus){
    RequestStatusIdle = 1,//空闲
    RequestStatusLoading = 2,//请求中
    RequestStatusSucceed = 3,//成功
    RequestStatusFailed = 4,//失败
    RequestStatusCanceled = 5//取消
};

typedef NS_OPTIONS(NSInteger, HTTPMethod){
    POST = 1,
    GET = 2
};

@interface DCNetworkingRequest : NSObject

@property(nonatomic, copy)NSString *URLString;
@property(nonatomic, strong, readonly)NSMutableDictionary *parameters;

//创建单独的请求对象时，可自定义请求参数
@property (assign, nonatomic)CGFloat timeoutInterval;
@property (assign, nonatomic)HTTPMethod httpMethod;
@property (assign, nonatomic)RequestStatus status;
@property (assign, nonatomic)BOOL enableLogs;//是否打印请求日志

//重定向暂停《连续两次签名失败，暂停当前请求，提示错误》
@property(nonatomic, assign)BOOL shouldStop;


+ (instancetype)share;

+ (void)postUploadImageAndVideoToPath:(NSString *)URLString uploadImage:(UIImage *)uploadImage method:(HTTPMethod)method withMappingObject:(NSString*)className success:(void (^)(id responseObject))sucessBlock fail:(void (^)(NSError *error, NSString *errorDescription))failBlock;

//离散型 请求
+ (void)requestWithURLString:(NSString *)URLString
                      params:(NSDictionary *)params
                      method:(HTTPMethod)method
                     withMappingObject:(NSString*)className success:(void (^)(id responseObject))sucessBlock
                        fail:(void (^)(NSError *error, NSString *errorDescription))failBlock;

- (instancetype)initWithUrl:(NSString *)URLString;
//修改请求参数
- (void)setParameter:(NSDictionary *)parameter;
//开始请求
- (void)startRequest;
//取消请求
- (void)cancelRequest;

//获取缓存
- (NSInteger)cache_size;
//清除缓存
- (void)cache_clear;
@end

NS_ASSUME_NONNULL_END
