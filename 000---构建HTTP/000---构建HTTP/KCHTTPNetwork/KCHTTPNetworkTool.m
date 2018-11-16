//
//  KCHTTPNetworkTool.m
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/21.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "KCHTTPNetworkTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation KCHTTPNetworkTool
+ (NSString *)kc_md5WithData:(NSData *)data {
    unsigned char result[16];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    return [self kc_md5:result];
}

+ (NSString *)kc_md5String:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [self kc_md5:result];
}

+ (NSString *)kc_md5:(unsigned char [16])result{
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (BOOL)isNetworkReachable {
    
    ReachabilityStatus status = GLobalRealReachability.currentReachabilityStatus;
    return status == RealStatusViaWWAN || status == RealStatusViaWiFi;
}

@end
