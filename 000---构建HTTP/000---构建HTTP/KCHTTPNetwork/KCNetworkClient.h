//
//  KCNetworkClient.h
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^KCCompletionHandle)(NSURLResponse *response,id responseObject,NSError *error);

@interface KCNetworkClient : NSObject

+ (instancetype)sharedInstance;

- (NSURLSessionDataTask *)dataTaskWithUrlPath:(NSString *)urlPath
                                  requestType:(KCNetworkRequestType)requestType
                                       params:(NSDictionary *)params
                                       header:(NSDictionary *)header
                            completionHandler:(KCCompletionHandle)completionHandler;

- (NSNumber *)uploadDataWithUrlPath:(NSString *)urlPath
                             params:(NSDictionary *)params
                           contents:(NSArray<KCUploadFile *> *)contents
                             header:(NSDictionary *)header
                    progressHandler:(void(^)(NSProgress *))progressHandler
                  completionHandler:(KCCompletionHandle)completionHandler;

- (NSNumber *)dispatchTask:(NSURLSessionTask *)task;

- (NSNumber *)dispatchTaskWithUrlPath:(NSString *)urlPath
                          requestType:(KCNetworkRequestType)requestType
                               params:(NSDictionary *)params
                               header:(NSDictionary *)header
                    completionHandler:(KCCompletionHandle)completionHandler;

- (void)cancelAllTask;
- (void)cancelTaskWithTaskIdentifier:(NSNumber *)taskIdentifier;

@end
