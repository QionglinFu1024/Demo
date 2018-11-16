//
//  KCNetworkConfig.h
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#ifndef KCNetworkConfig_h
#define KCNetworkConfig_h

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    KCService0,
    KCService1,
    KCService2
} KCServiceType;
#define ServiceCount 3

typedef enum : NSUInteger {
    KCServiceEnvironmentTest,
    KCServiceEnvironmentDevelop,
    KCServiceEnvironmentRelease
} KCServiceEnvironment;

#define BulidService KCService0
#define BulidServiceEnvironment KCServiceEnvironmentTest

typedef enum : NSUInteger {
    KCNetworkRequestTypeGET,
    KCNetworkRequestTypePOST
} KCNetworkRequestType;

#define RequestTimeoutInterval 8

#endif
