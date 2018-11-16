//
//  KCURLRequestGenerator.h
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCUploadFile.h"

@interface KCURLRequestGenerator : NSObject

+ (instancetype)sharedInstance;

/**
 普通网络请求

 @param urlPath 请求地址
 @param method 请求方式
 @param params 请求参数
 @param header 请求头
 @return request信息
 */
- (NSMutableURLRequest *)generateRequestWithUrlPath:(NSString *)urlPath
                                             method:(NSString *)method
                                             params:(NSDictionary *)params
                                             header:(NSDictionary *)header;


/**
 上传文件

 @param urlPath 请求地址
 @param params 请求参数
 @param header 请求头
 @return request信息
 */
- (NSMutableURLRequest *)generateUploadRequestUrlPath:(NSString *)urlPath
                                               params:(NSDictionary *)params
                                             contents:(NSArray<KCUploadFile *> *)contents
                                               header:(NSDictionary *)header;


- (void)switchService:(KCServiceType)type;
@end
