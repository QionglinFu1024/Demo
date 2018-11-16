//
//  KCUploadFile.h
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    KCUploadFileTypePng,
    KCUploadFileTypeJpg,
    KCUploadFileTypeMp3
} KCUploadFileType;

@interface KCUploadFile : NSObject
/**< 默认以data的md5值做uploadKey */
+ (instancetype)pngImageWithFileData:(NSData *)data imageName:(NSString *)name;
+ (instancetype)jpgImageWithFileData:(NSData *)data imageName:(NSString *)name;
+ (instancetype)mp3AudioWithFileData:(NSData *)data audioName:(NSString *)name;
+ (instancetype)pngImageWithFileData:(NSData *)data imageName:(NSString *)name uploadKey:(NSString *)key;
+ (instancetype)jpgImageWithFileData:(NSData *)data imageName:(NSString *)name uploadKey:(NSString *)key;
+ (instancetype)mp3AudioWithFileData:(NSData *)data audioName:(NSString *)name uploadKey:(NSString *)key;

- (instancetype)initWithFileData:(NSData *)data fileName:(NSString *)name fileType:(KCUploadFileType)type uploadKey:(NSString *)key;

- (NSData *)fileData;
- (NSString *)fileName;
- (NSString *)fileType;
- (NSString *)uploadKey;
- (NSString *)md5String;
@end
