//
//  ViewController.m
//  000---构建HTTP
//
//  Created by Cooci on 2018/8/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"
#import "KCUserAPIManager.h"

@interface ViewController ()
@property (nonatomic, strong) NSNumber *taskIdentifier;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}
- (IBAction)didClickAFNAction:(id)sender {
    
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    
    NSString *url  =@"http://127.0.0.1:8080/postMethod/";
    
    //将父类的属性等于数据请求的返回值
    
//    [manager GET:url parameters:nil progress:^(NSProgress* _Nonnull downloadProgress) {
//
//    }success:^(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject) {
//
//        NSLog(@"success : %@",responseObject);
//
//    }failure:^(NSURLSessionDataTask*_Nullabletask,NSError*_Nonnull error) {
//
//        NSLog(@"failure, error:%@", error);
//
//    }];
    
    NSDictionary *dict = @{@"username":@"123"};
    
    [manager POST:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"success : %@",responseObject);

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure, error:%@", error);
    }];
    
    
}
- (IBAction)didClickKCAction:(id)sender {
    
    self.taskIdentifier = [[KCNetworkClient sharedInstance] dispatchTaskWithUrlPath:@"/pythonJson" requestType:KCNetworkRequestTypeGET params:nil header:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {

        NSLog(@"response == %@",response);
        NSLog(@"responseObject == %@",responseObject);
        NSLog(@"error == %@",error);

    }];
 
}

- (IBAction)didClickCacheNetworking:(id)sender {
    
    // 网络  --->  UI
    [[[KCUserAPIManager new] homeListSignalWithPage:1 pageSize:20] subscribeNext:^(id  _Nullable x) {
        NSLog(@"返回数据%@",x);
    }];
    
}

- (void)uplod{
    
    //用AFN的AFHTTPSessionManager
    AFHTTPSessionManager *sharedManager = [[AFHTTPSessionManager alloc]init];
    sharedManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
    sharedManager.requestSerializer.timeoutInterval =20;
    NSString *url = [NSString stringWithFormat:@"http://kingdee.tunnel.qydev.com/platform-file/file/public/UploadVide.json"];
    // 视频-->Data
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Test.mp4" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    [sharedManager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:@"fileName" fileName:@"Test.mp4" mimeType:@"video/mp4"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"上传中%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"成功了:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败:%@",error);
    }];
    
    
    //    sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    [sharedManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //    [sharedManager.requestSerializer setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
