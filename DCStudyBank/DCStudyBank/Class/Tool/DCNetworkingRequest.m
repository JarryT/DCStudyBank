//
//  DCNetworkingRequest.m
//  DCStudyBank
//
//  Created by mac on 2019/12/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCNetworkingRequest.h"
#import "Reachability.h"
#import "AFNetworking.h"
#import "SDImageCache.h"
@implementation DCNetworkingRequest
+ (instancetype)share{
    static DCNetworkingRequest *request = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[DCNetworkingRequest alloc] init];
    });
    return request;
}

+ (void)requestWithURLString:(NSString *)URLString params:(NSDictionary *)params method:(HTTPMethod)method withMappingObject:(NSString*)className success:(void (^)(id responseObject))sucessBlock
   fail:(void (^)(NSError *error, NSString *errorDescription))failBlock{
    
    //无网络
    if ([Reachability reachabilityForInternetConnection].isReachable) {
        AFHTTPSessionManager *session = [[DCNetworkingRequest share] sessionManager];
        //header
        NSDictionary *headers = [[DCNetworkingRequest share] headerWithParams:params];
        for (NSString *key in headers) {
            [session.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
        NSString *urlString = [ServerAddressURL stringByAppendingString:URLString];
        if (method == POST) {
            [session POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    //处理成功请求
                NSError *error = nil;
                NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];

                NSLog(@"--url=%@-%@--%@",task.currentRequest.URL.absoluteString,jsonObject,[jsonObject objectSafeKey:@"msg"]);
                if (className) {
                    id c = [NSClassFromString(className) mj_objectWithKeyValues:responseObject];
                    if (sucessBlock) {
                         sucessBlock(c);
                    }
                }else{
                   if (sucessBlock){ sucessBlock(jsonObject); };
                }
               
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failBlock){ failBlock(error,error.localizedDescription); };
            }];

        } else {

            [session GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    //处理成功请求
            
                NSError *error = nil;
                NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
                NSLog(@"--url=%@-%@",task.currentRequest.URL.absoluteString,jsonObject);
                if (error) {
                    
                } else {
                   
                    if (className) {
                        id c = [NSClassFromString(className) mj_objectWithKeyValues:responseObject];
                        if (sucessBlock) {
                            sucessBlock(c);
                        }
               
                    }else{
                   
                        if (sucessBlock){
                            sucessBlock(jsonObject);
                        
                        };
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failBlock){ failBlock(error,error.localizedDescription); };
            }];
        }
    }else{
        [DCNetworkingRequest share].shouldStop = false;
        if (failBlock){ failBlock(nil, NetworkingErrorDescription);};
    }
}

//上传图片
+ (void)postUploadImageAndVideoToPath:(NSString *)URLString uploadImage:(UIImage *)uploadImage method:(HTTPMethod)method withMappingObject:(NSString*)className success:(void (^)(id responseObject))sucessBlock fail:(void (^)(NSError *error, NSString *errorDescription))failBlock{
       AFHTTPSessionManager *session = [[DCNetworkingRequest share] sessionManager];
    NSDictionary *headers = [[DCNetworkingRequest share] headerWithParams:@{}];
           for (NSString *key in headers) {
               [session.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
       
        if (method == POST) {
            NSString *urlString = [ServerAddressURL stringByAppendingString:URLString];
            [session POST:urlString parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

                      // 上传文件  服务器对应[file]
                    NSData *imageData = UIImageJPEGRepresentation(uploadImage,0.6);
                   NSString *dataStr = [imageData base64EncodedStringWithOptions:0];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"yyyyMMddHHmmss";
                      NSString *str = [formatter stringFromDate:[NSDate date]];
                     NSString*fileName=[NSString stringWithFormat:@"%@.jpg",str];
                     [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:fileName];

                  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                      NSError *error = nil;
                      NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
                NSLog(@"--url=%@-%@",task.currentRequest.URL.absoluteString,jsonObject);
                      if (error) {
                                         
                                     } else {
                                        
                                         if (className) {
                                             id c = [NSClassFromString(className) mj_objectWithKeyValues:responseObject];
                                             if (sucessBlock) {
                                                 sucessBlock(c);
                                             }
                                    
                                         }else{
                                        
                                             if (sucessBlock){
                                                 sucessBlock(jsonObject);
                                };
                            }
                        }

                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

                       if (failBlock){ failBlock(error,error.localizedDescription); };

                  }];
;

           } else {
             
           }
    
}
+ (void)dealWith:(id)responseObject success:(void (^)(id))sucessBlock fail:(void (^)(NSError *, NSString *))failBlock{
    NSInteger success = [[responseObject objectForKey:@"success"] integerValue];
    if (success == 1) {
        if (sucessBlock){ sucessBlock(responseObject[@"resultMap"]); };
    } else{
        NSString *desc = responseObject[@"description"];
        if (failBlock){ failBlock(nil,desc); };
    }
}


- (NSDictionary *)headerWithParams:(NSDictionary *)parameter{
    
    NSString *jwtToken = @"";
    if ([DCUerLoginManger shareLoginInfoIntents].isUerLogin) {
        jwtToken = [DCUerLoginManger shareLoginInfoIntents].jwtToken;
    }
    NSString *keyVlue = [NSString stringWithFormat:@"Bearer %@",jwtToken];
    NSDictionary *params = @{@"authorization":keyVlue};
    
    return params;
}


- (AFHTTPSessionManager *)sessionManager{
    static AFHTTPSessionManager *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [AFHTTPSessionManager manager];
        // 加上这行代码，https ssl 验证。
//        [session setSecurityPolicy:[self customSecurityPolicy]];
        AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
        serializer.timeoutInterval = 15;
        session.requestSerializer = serializer;
        session.responseSerializer = [AFHTTPResponseSerializer serializer];
        session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return session;
}

- (AFSecurityPolicy*)customSecurityPolicy {
    
    //先导入证书
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ytFinanceCA" ofType:@"cer"];//证书的路径
//    NSData *certData = [NSData dataWithContentsOfFile:cerPath];

    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;

//    securityPolicy.pinnedCertificates = @[certData];

    return securityPolicy;
}


//获取缓存
- (NSInteger)cache_size{
    NSInteger size = 0; size = [[SDImageCache sharedImageCache] totalDiskCount];
    size += [[NSURLCache sharedURLCache] currentDiskUsage];
    return size;
}
//清除缓存
- (void)cache_clear{
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    NSURLCache *cache = (NSURLCache *)[NSURLCache sharedURLCache];[cache removeAllCachedResponses];
}

@end
