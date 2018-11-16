//
//  HHUserAPIManager.h
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@end

@interface KCUserAPIManager : KCAPIManager

/** TODO: 获取验证码 */
- (RACSignal *)getVerifyCodeSignalWithPhoneNumber:(NSString *)phoneNumber;

/** TODO: 注册 */
- (RACSignal *)registerSignalWithAccount:(NSString *)account password:(NSString *)password verifyCode:(NSString *)verifyCode;

/** TODO: 登陆 */
- (RACSignal *)loginSignalWithAccount:(NSString *)account password:(NSString *)password;

/** TODO: 最新列表数据 */
- (RACSignal *)homeListSignalWithPage:(int)page pageSize:(int)pageSize;

/** TODO: 某条评论列表 */
- (RACSignal *)commentListSignalWithID:(NSString *)ID page:(int)page pageSize:(int)pageSize;

/** TODO: 给某条点赞/取消赞 */
- (RACSignal *)switchLikeStatusSignalWithID:(NSString *)ID isLike:(BOOL)isLike;

@end
