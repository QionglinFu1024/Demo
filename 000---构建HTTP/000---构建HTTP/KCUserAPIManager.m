//
//  HHUserAPIManager.m
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "KCUserAPIManager.h"

@implementation UserModel
@end

@implementation KCUserAPIManager

/** TODO: 获取验证码 */
- (RACSignal *)getVerifyCodeSignalWithPhoneNumber:(NSString *)phoneNumber {
    return arc4random() % 2 ? [RACSignal error:KCError(KCDefaultErrorNotice, 999)] : [RACSignal return:@YES];
}

/** TODO: 注册 */
- (RACSignal *)registerSignalWithAccount:(NSString *)account password:(NSString *)password verifyCode:(NSString *)verifyCode {
    return arc4random() % 2 ? [RACSignal error:KCError(KCDefaultErrorNotice, 999)] : [RACSignal return:@YES];
}

/** TODO: 登陆 */
- (RACSignal *)loginSignalWithAccount:(NSString *)account password:(NSString *)password {
    return [RACSignal return:@YES];
}

/** TODO: 最新列表数据 */
- (RACSignal *)homeListSignalWithPage:(int)page pageSize:(int)pageSize{
    KCDataTaskConfiguration *config = [KCDataTaskConfiguration new];
    config.urlPath = @"/postMethod/";
    config.requestType = KCNetworkRequestTypePOST;
    config.requestParameters = @{@"page": @(page),
                                 @"username": [NSString stringWithFormat:@"%d",pageSize]};
    
    config.deserializePath = @"data";
    config.cacheValidTimeInterval = 1;
    config.deserializeClass = [UserModel class]; // 放你要处理的模型
    return [self dataSignalWithConfig:config];
}

/** TODO: 某条评论列表 */
- (RACSignal *)commentListSignalWithID:(NSString *)ID page:(int)page pageSize:(int)pageSize{
    
    if (page == 3) {
        return [RACSignal error:KCError(@"", KCNetworkTaskErrorNoMoreData)];
    }
    
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        //模型数据处理
    }
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        });
        return nil;
    }];
}

/** TODO: 给某条点赞/取消赞 */
- (RACSignal *)switchLikeStatusSignalWithID:(NSString *)ID isLike:(BOOL)isLike{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (arc4random() % 2) {
                [subscriber sendError:KCError(@"操作失败~", KCNetworkTaskErrorDefault)];
            } else {
                [subscriber sendNext:@YES];
                [subscriber sendCompleted];
            }
        });
        return nil;
    }];
}


#pragma mark - Utils

- (RACSignal *)cachedWeiboListSignalWithPage:(NSInteger)page {
    
    page = MAX(0, page - 1);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSArray *cache; // 取缓存
            if (page >= cache.count) {
                [subscriber sendError:KCError(@"", KCNetworkTaskErrorNoMoreData)];
            } else {
                
                [subscriber sendNext:[NSArray yy_modelArrayWithClass:[NSObject class] json:cache[page]]];
                [subscriber sendCompleted];
            }
        });
        return nil;
    }];
}



@end
