//
//  KCUploadFile.m
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "KCUploadFile.h"

@interface KCUploadFile()

@property (nonatomic, copy) NSString *uploadKey;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *fileType;
@property (nonatomic, copy) NSString *md5String;
@property (nonatomic, strong) NSData *fileData;

@end

@implementation KCUploadFile

- (instancetype)initWithFileData:(NSData *)data fileName:(NSString *)name fileType:(KCUploadFileType)type uploadKey:(NSString *)key {
    if (self = [super init]) {
        
        self.fileData = data;
        self.uploadKey = key;
        
        switch (type) {
            case KCUploadFileTypePng: {
                
                self.fileType = @"image/png";
                self.fileName = [name stringByAppendingString:@".png"];
            }   break;
                
            case KCUploadFileTypeJpg: {
                
                self.fileType = @"image/jpeg";
                self.fileName = [name stringByAppendingString:@".jpeg"];
            }   break;
                
            case KCUploadFileTypeMp3: {
                
                self.fileType = @"audio/mp3";
                self.fileName = [name stringByAppendingString:@".mp3"];
            }   break;
        }
        
    }
    return self;
}

+ (instancetype)pngImageWithFileData:(NSData *)data imageName:(NSString *)name {
    return [[KCUploadFile alloc] initWithFileData:data fileName:name fileType:KCUploadFileTypePng uploadKey:nil];
}

+ (instancetype)jpgImageWithFileData:(NSData *)data imageName:(NSString *)name {
    return [[KCUploadFile alloc] initWithFileData:data fileName:name fileType:KCUploadFileTypeJpg uploadKey:nil];
}

+ (instancetype)mp3AudioWithFileData:(NSData *)data audioName:(NSString *)name {
    return [[KCUploadFile alloc] initWithFileData:data fileName:name fileType:KCUploadFileTypeMp3 uploadKey:nil];
}

+ (instancetype)pngImageWithFileData:(NSData *)data imageName:(NSString *)name uploadKey:(NSString *)key {
    return [[KCUploadFile alloc] initWithFileData:data fileName:name fileType:KCUploadFileTypePng uploadKey:key];
}

+ (instancetype)jpgImageWithFileData:(NSData *)data imageName:(NSString *)name uploadKey:(NSString *)key {
    return [[KCUploadFile alloc] initWithFileData:data fileName:name fileType:KCUploadFileTypeJpg uploadKey:key];
}

+ (instancetype)mp3AudioWithFileData:(NSData *)data audioName:(NSString *)name uploadKey:(NSString *)key {
    return [[KCUploadFile alloc] initWithFileData:data fileName:name fileType:KCUploadFileTypeMp3 uploadKey:key];
}


#pragma mark - Getter

- (NSString *)uploadKey {
    if (!_uploadKey) {
        _uploadKey = self.md5String;
    }
    return _uploadKey;
}

- (NSString *)md5String {
    if (!_md5String) {
        _md5String = self.fileData.length > 0 ? [KCHTTPNetworkTool kc_md5WithData:self.fileData] : @"";
    }
    return _md5String;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"\nfileName: %@\nfileType: %@\nuploadKey: %@\nfileLength: %ld",self.fileName,self.fileType,self.uploadKey,self.fileData.length];
}

@end
