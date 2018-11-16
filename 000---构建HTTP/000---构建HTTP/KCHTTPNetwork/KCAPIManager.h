//
//  KCAPIManager.h
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


#pragma mark - KCAPIConfiguration

typedef void(^KCNetworkTaskProgressHandler)(CGFloat progress);

@interface KCRequestConfiguration : NSObject

@property (nonatomic, copy) NSString *urlPath;
@property (nonatomic, strong) NSDictionary *requestParameters;

@property (nonatomic, strong) NSDictionary *requestHeader;
@property (nonatomic, assign) KCNetworkRequestType requestType;
@end

@interface KCTaskConfiguration : KCRequestConfiguration

@property (nonatomic, strong) Class deserializeClass;
@property (nonatomic, copy) NSString *deserializePath;

@end

@interface KCDataTaskConfiguration : KCTaskConfiguration

@property (nonatomic, assign) NSTimeInterval cacheValidTimeInterval;

@end

@interface KCUploadTaskConfiguration : KCTaskConfiguration

@property (nonatomic, strong) NSArray<KCUploadFile *> * uploadContents;

@end

#pragma mark - KCAPIManager

@interface KCAPIManager : NSObject

- (void)cancelAllTask;
- (void)cancelTask:(NSNumber *)taskIdentifier;

- (NSURLSessionDataTask *)dataTaskWithConfiguration:(KCDataTaskConfiguration *)config completionHandler:(KCNetworkTaskCompletionHander)completionHandler;
- (NSNumber *)dispatchDataTaskWithConfiguration:(KCDataTaskConfiguration *)config completionHandler:(KCNetworkTaskCompletionHander)completionHandler;
- (NSNumber *)dispatchUploadTaskWithConfiguration:(KCUploadTaskConfiguration *)config progressHandler:(KCNetworkTaskProgressHandler)progressHandler completionHandler:(KCNetworkTaskCompletionHander)completionHandler;



@end
