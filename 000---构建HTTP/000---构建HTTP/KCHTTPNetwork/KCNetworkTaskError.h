//
//  KCNetworkTaskError.h
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#ifndef KCNetworkTaskError_h
#define KCNetworkTaskError_h

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    KCNetworkTaskSuccess = 1,
    KCNetworkTaskErrorTimeOut = 101,
    KCNetworkTaskErrorCannotConnectedToInternet = 102,
    KCNetworkTaskErrorCanceled = 103,
    KCNetworkTaskErrorDefault = 104,
    KCNetworkTaskErrorNoData = 105,
    KCNetworkTaskErrorNoMoreData = 106
} KCNetworkTaskError;

static NSError *KCError(NSString *domain, NSInteger code) {
    return [NSError errorWithDomain:domain code:code userInfo:nil];
}

static NSString *KCNoDataErrorNotice = @"这里什么也没有~";
static NSString *KCNetworkErrorNotice = @"当前网络差, 请检查网络设置~";
static NSString *KCTimeoutErrorNotice = @"请求超时了~";
static NSString *KCDefaultErrorNotice = @"请求失败了~";
static NSString *KCNoMoreDataErrorNotice = @"没有更多了~";

typedef void(^KCNetworkTaskCompletionHander)(NSError *error,NSDictionary *result);
#endif 
