//
//  KCService.m
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "KCService.h"

@interface KCServiceX : KCService
@end

@interface KCServiceY : KCService
@end

@interface KCServiceZ : KCService
@end

@implementation KCService

#pragma mark - Interface

+ (KCService *)defaultService {
    return [self serviceWithType:0];
}

+ (KCService *)serviceWithType:(KCServiceType)type {
    
    KCService *service;
    switch (type) {
        case KCService0: service = [KCServiceX new];  break;
        case KCService1: service = [KCServiceY new];  break;
        case KCService2: service = [KCServiceZ new];  break;
    }
    service.type = type;
    service.environment = BulidServiceEnvironment;
    return service;
}

- (NSString *)baseUrl {
    
    switch (self.environment) {
        case KCServiceEnvironmentTest: return [self testEnvironmentBaseUrl];
        case KCServiceEnvironmentDevelop: return [self developEnvironmentBaseUrl];
        case KCServiceEnvironmentRelease: return [self releaseEnvironmentBaseUrl];
    }
}

@end

#pragma mark - KCServiceX

@implementation KCServiceX

- (NSString *)testEnvironmentBaseUrl {
    return @"http://127.0.0.1:8080";
}

- (NSString *)developEnvironmentBaseUrl {
    return @"http://127.0.0.1:12345";
}

- (NSString *)releaseEnvironmentBaseUrl {
    return @"https://api.weibo.com/2";
}

@end

#pragma mark - KCServiceY
// 根据你们的服务器 自己写
@implementation KCServiceY

- (NSString *)testEnvironmentBaseUrl {
    return @"testEnvironmentBaseUrl_Y";
}

- (NSString *)developEnvironmentBaseUrl {
    return @"developEnvironmentBaseUrl_Y";
}

- (NSString *)releaseEnvironmentBaseUrl {
    return @"releaseEnvironmentBaseUrl_Y";
}

@end

#pragma mark - KCServiceZ

@implementation KCServiceZ

- (NSString *)testEnvironmentBaseUrl {
    return @"testEnvironmentBaseUrl_Z";
}

- (NSString *)developEnvironmentBaseUrl {
    return @"developEnvironmentBaseUrl_Z";
}

- (NSString *)releaseEnvironmentBaseUrl {
    return @"releaseEnvironmentBaseUrl_Z";
}

@end
