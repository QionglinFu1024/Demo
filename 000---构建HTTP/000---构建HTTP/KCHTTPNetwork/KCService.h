//
//  KCService.h
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KCService <NSObject>
@optional
- (NSString *)testEnvironmentBaseUrl;
- (NSString *)developEnvironmentBaseUrl;
- (NSString *)releaseEnvironmentBaseUrl;

@end

@interface KCService : NSObject<KCService>
@property (nonatomic) KCServiceType type;
@property (nonatomic, assign) KCServiceEnvironment environment;

+ (KCService *)defaultService;
+ (KCService *)serviceWithType:(KCServiceType)type;
- (NSString *)baseUrl;
@end



