//
//  KCNetworkCacheManager.m
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/21.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "KCNetworkCacheManager.h"
#define ValidTimeInterval 60

@interface KCNetworkCache ()

@property (strong, nonatomic) id data;
@property (nonatomic) NSTimeInterval cacheTime;
@property (nonatomic) NSUInteger validTimeInterval;

@end


// AFN + RAC

@implementation KCNetworkCache

+ (instancetype)cacheWithData:(id)data {
    return [self cacheWithData:data validTimeInterval:ValidTimeInterval];
}

+ (instancetype)cacheWithData:(id)data validTimeInterval:(NSUInteger)interterval {
    
    KCNetworkCache *cache = [KCNetworkCache new];
    cache.data = data;
    cache.cacheTime = [[NSDate date] timeIntervalSince1970];
    cache.validTimeInterval = interterval > 0 ? interterval : ValidTimeInterval;
    return cache;
}

- (BOOL)isValid {
    
    if (self.data) {
        return [[NSDate date] timeIntervalSince1970] - self.cacheTime < self.validTimeInterval;
    }
    return NO;
}

@end

#pragma mark - HHNetworkCacheManager

@interface KCNetworkCacheManager ()

// afn ---> sd (内存,沙盒) 网络(便捷) 操作
@property (strong, nonatomic) NSCache *cache;

@end

@implementation KCNetworkCacheManager

+ (instancetype)sharedManager {
    static KCNetworkCacheManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedManager = [[super allocWithZone:NULL] init];
        [sharedManager configuration];
    });
    return sharedManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedManager];
}

- (void)configuration {
    
    self.cache = [NSCache new];
    self.cache.totalCostLimit = 1024 * 1024 * 20;
}

#pragma mark - Interface

- (void)setObjcet:(KCNetworkCache *)object forKey:(id)key {
    [self.cache setObject:object forKey:key];
}

- (void)removeObejectForKey:(id)key {
    [self.cache removeObjectForKey:key];
}

- (KCNetworkCache *)objcetForKey:(id)key {
    
    return [self.cache objectForKey:key];
}

@end
