//
//  HHAPIManager+RAC.h
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "KCAPIManager.h"

@interface KCAPIManager (RAC)

- (RACSignal *)dataSignalWithConfig:(KCDataTaskConfiguration *)config;

- (RACSignal *)uploadSignalWithConfig:(KCUploadTaskConfiguration *)config;

@end
