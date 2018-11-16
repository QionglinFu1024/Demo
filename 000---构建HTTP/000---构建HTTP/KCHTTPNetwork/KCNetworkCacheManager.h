//
//  KCNetworkCacheManager.h
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/21.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCNetworkCache : NSObject
+ (instancetype)cacheWithData:(id)data;
+ (instancetype)cacheWithData:(id)data validTimeInterval:(NSUInteger)interterval;

- (id)data;
- (BOOL)isValid;
@end

@interface KCNetworkCacheManager : NSObject
+ (instancetype)sharedManager;
- (void)removeObejectForKey:(id)key;
- (void)setObjcet:(KCNetworkCache *)object forKey:(id)key;
- (KCNetworkCache *)objcetForKey:(id)key;
@end

