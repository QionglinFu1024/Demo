//
//  KCAPIManager.m
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "KCAPIManager.h"

#pragma mark - KCRequestConfiguration

@implementation KCRequestConfiguration

- (instancetype)init {
    if (self = [super init]) {
        self.requestType = KCNetworkRequestTypeGET;
    }
    return self;
}

@end

@implementation KCTaskConfiguration
@end

@implementation KCDataTaskConfiguration
@end

@implementation KCUploadTaskConfiguration
@end

#pragma mark - KCAPIManager

@interface KCAPIManager ()

@property (nonatomic, strong) NSMutableArray<NSNumber *> *loadingTaskIdentifies;

@end

@implementation KCAPIManager
- (instancetype)init {
    if (self = [super init]) {
        
        self.loadingTaskIdentifies = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
    [self cancelAllTask];
}

#pragma mark - Interface

- (void)cancelAllTask {
    
    for (NSNumber *taskIdentifier in self.loadingTaskIdentifies) {
        [[KCNetworkClient sharedInstance] cancelTaskWithTaskIdentifier:taskIdentifier];
    }
    [self.loadingTaskIdentifies removeAllObjects];
}

- (void)cancelTask:(NSNumber *)taskIdentifier {
    // id
    [[KCNetworkClient sharedInstance] cancelTaskWithTaskIdentifier:taskIdentifier];
    [self.loadingTaskIdentifies removeObject:taskIdentifier];
}

- (NSURLSessionDataTask *)dataTaskWithConfiguration:(KCDataTaskConfiguration *)config completionHandler:(KCNetworkTaskCompletionHander)completionHandler {
    
    // session --> 网络框架的封装  ---> manager : session回调
    // request --> config ---> session ---> task
    
    
    return [[KCNetworkClient sharedInstance] dataTaskWithUrlPath:config.urlPath requestType:config.requestType params:config.requestParameters header:config.requestHeader completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        !completionHandler ?: completionHandler([self formatError:error], responseObject);
    }];
}

// VC VIEWMODEL PRESENT  : completionHandler @[MODEL]
// Net  --->  UI  ---> RAC  --> SIGNAL
// signal subscriber { mdoel    [ui setmodel] }

- (NSNumber *)dispatchDataTaskWithConfiguration:(KCDataTaskConfiguration *)config completionHandler:(KCNetworkTaskCompletionHander)completionHandler{
    
    NSString *cacheKey;
    if (config.cacheValidTimeInterval > 0) {
        NSMutableString *mString = [NSMutableString stringWithString:config.urlPath];
        NSMutableArray *requestParameterKeys = [config.requestParameters.allKeys mutableCopy];
        if (requestParameterKeys.count > 1) {
            [requestParameterKeys sortedArrayUsingComparator:^NSComparisonResult(NSString * _Nonnull obj1, NSString * _Nonnull obj2) {
                return [obj1 compare:obj2];
            }];
        }
        
        [requestParameterKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
            [mString appendFormat:@"&%@=%@",key, config.requestParameters[key]];
        }];
        
        cacheKey = [KCHTTPNetworkTool kc_md5String:[mString copy]];
        KCNetworkCache *cache = [[KCNetworkCacdaheManager sharedManager] objcetForKey:cacheKey];
//        KCNetworkCache *cache = [KCNetworkCache cacheWithData:nil validTimeInterval:config.cacheValidTimeInterval];
        if (!cache.isValid) {
            [[KCNetworkCacheManager sharedManager] removeObejectForKey:cacheKey];
        } else {
            NSLog(@"走cachen内存咯");
            completionHandler ? completionHandler(nil, cache.data) : nil;
            return @-1;
        }
    }

    // 缓存
    // 网络 --> client
    // response --> 序列化
    NSMutableArray *taskIdentifier = [NSMutableArray arrayWithObject:@-1];
    taskIdentifier[0] = [[KCNetworkClient sharedInstance] dispatchTaskWithUrlPath:config.urlPath requestType:config.requestType params:config.requestParameters header:config.requestHeader completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        id result = responseObject;
        NSError *formatError = [self formatError:error];
        if (formatError != nil) {/** 通用错误格式化 */
            
            int code = [result[@"code"] intValue];
            if (code != KCNetworkTaskSuccess) {
                formatError = KCError(result[@"msg"] ?: KCDefaultErrorNotice, code);
            }
        }
        
        if (formatError == nil && config.deserializeClass != nil) {/** 通用json解析 */
            
            NSDictionary *json = responseObject;
            
            KCNetworkCache *cache = [KCNetworkCache cacheWithData:responseObject validTimeInterval:config.cacheValidTimeInterval];
            [[KCNetworkCacheManager sharedManager] setObjcet:cache forKey:cacheKey];

            // json
            
            if (config.deserializePath.length > 0) {
                json = [json valueForKeyPath:config.deserializePath];
            }
            
            if ([json isKindOfClass:[NSDictionary class]]) {
                
                if (json.count > 0) { // 对象
                    result = [config.deserializeClass yy_modelWithJSON:json];
                } else {
                    formatError = KCError(KCNoDataErrorNotice, KCNetworkTaskErrorNoData);
                }
            } else if ([json isKindOfClass:[NSArray class]]) {
                
                result = [NSArray yy_modelArrayWithClass:config.deserializeClass json:json];
                if ([result count] == 0) {
                    
                    NSInteger page = [config.requestParameters[@"page"] integerValue];
                    if (page == 0) {
                        formatError = KCError(KCNoDataErrorNotice, KCNetworkTaskErrorNoData);
                    } else {
                        formatError = KCError(KCNoMoreDataErrorNotice, KCNetworkTaskErrorNoMoreData);
                    }
                }
            }
        }
        
        !completionHandler ?: completionHandler(formatError, result);
    }];
    [self.loadingTaskIdentifies addObject:taskIdentifier.firstObject];
    return taskIdentifier.firstObject;
}

- (NSNumber *)dispatchUploadTaskWithConfiguration:(KCUploadTaskConfiguration *)config progressHandler:(KCNetworkTaskProgressHandler)progressHandler completionHandler:(KCNetworkTaskCompletionHander)completionHandler {
    
    NSMutableArray *taskIdentifier = [NSMutableArray arrayWithObject:@-1];
    taskIdentifier[0] = [[KCNetworkClient sharedInstance] uploadDataWithUrlPath:config.urlPath params:config.requestParameters contents:config.uploadContents header:config.requestHeader progressHandler:^(NSProgress *progress) {
        
        progressHandler ? progressHandler(progress.completedUnitCount * 1.0 / progress.totalUnitCount) : nil;
    } completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        NSError *formatError = [self formatError:error];
        if (formatError == nil) {
            
            int code = [responseObject[@"code"] intValue];
            if (code != KCNetworkTaskSuccess) {
                formatError = KCError(responseObject[@"msg"] ?: KCDefaultErrorNotice, code);
            }
        }
        !completionHandler ?: completionHandler(formatError, responseObject);
    }];
    [self.loadingTaskIdentifies addObject:taskIdentifier.firstObject];
    return taskIdentifier.firstObject;
}

#pragma mark - Utils

- (NSError *)formatError:(NSError *)error {
    
    if (error != nil) {
        switch (error.code) {
            case NSURLErrorTimedOut: return KCError(KCTimeoutErrorNotice, KCNetworkTaskErrorTimeOut);
            case NSURLErrorCancelled: return KCError(KCDefaultErrorNotice, KCNetworkTaskErrorCanceled);
                
            case NSURLErrorCannotFindHost:
            case NSURLErrorCannotConnectToHost:
            case NSURLErrorNotConnectedToInternet: {
                return KCError(KCNetworkErrorNotice, KCNetworkTaskErrorCannotConnectedToInternet);
            }
                
            default: return KCError(KCDefaultErrorNotice, KCNetworkTaskErrorDefault);
        }
    }
    return error;
}

@end
