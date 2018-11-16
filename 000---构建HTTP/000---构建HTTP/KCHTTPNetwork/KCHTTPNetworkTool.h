//
//  KCHTTPNetworkTool.h
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/21.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCHTTPNetworkTool : NSObject

+ (NSString *)kc_md5WithData:(NSData *)data;

+ (NSString *)kc_md5String:(NSString *)string;

+ (BOOL)isNetworkReachable;
@end
