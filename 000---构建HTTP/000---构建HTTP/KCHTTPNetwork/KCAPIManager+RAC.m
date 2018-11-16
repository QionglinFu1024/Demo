//
//  HHAPIManager+RAC.m
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "KCAPIManager+RAC.h"

@implementation KCAPIManager (RAC)

- (RACSignal *)dataSignalWithConfig:(KCDataTaskConfiguration *)config {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSNumber *taskIdentifier = [self dispatchDataTaskWithConfiguration:config completionHandler:^(NSError *error, id result) {
            if (error) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:result];
                [subscriber sendCompleted];
            }
        }];
        return [RACDisposable disposableWithBlock:^{
            [self cancelTask:taskIdentifier];
        }];
    }].deliverOnMainThread;
}

- (RACSignal *)uploadSignalWithConfig:(KCUploadTaskConfiguration *)config {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSNumber *taskIdentifier = [self dispatchUploadTaskWithConfiguration:config progressHandler:^(CGFloat progress) {
            [subscriber sendNext:RACTuplePack(@(progress), nil)];
        } completionHandler:^(NSError *error, id result) {
            
            if (error) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:RACTuplePack(@1, result)];
                [subscriber sendCompleted];
            }
        }];
        return [RACDisposable disposableWithBlock:^{
            [self cancelTask:taskIdentifier];
        }];
    }].deliverOnMainThread;
}

@end
