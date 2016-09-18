//
//  DownloadManager.m
//  TrafficPlusPlus
//
//  Created by Smartios2012 on 15/7/27.
//  Copyright (c) 2015年 com.plusplus. All rights reserved.
//

#import "DownloadManager.h"

static AFHTTPRequestOperationManager *manager = nil;

@implementation DownloadManager

- (instancetype)init {
    if (self = [super init]) {
        manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}

+ (DownloadManager *)shareInstance {
    __strong static DownloadManager *downloadManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadManager = [[DownloadManager alloc] init];
    });
    return downloadManager;
}

- (void)requestData:(NSString *)method params:(NSDictionary *)params completion:(void (^)(NSString *))completion {
    NSString *fullPath = [HTTP_SERVER_PATH stringByAppendingString:method];
    if ([method isEqualToString:Method_Register]) {
        fullPath = @"http://zghrj.cn/mobile/index.php?act=login&op=register";
    } else if ([method isEqualToString:Method_GetCallIP]) {
        fullPath = @"http://zghrj.cn/shop/index.php?act=phone_api";
    }
    [manager POST:fullPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode != 500) {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if (completion) {
                completion(responseString);
            }
            
            //字典写入文件
            [params writeToFile:[self filePath] atomically:YES];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(error.localizedDescription);
        }
    }];
}

- (NSString *)filePath {
    NSString *doucumentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *filePath = [doucumentsPath stringByAppendingPathComponent:@"login.text"];
 
    return filePath;
}

/**
 使用base64解码
 
 @param encodedString base64编码的字符串
 
 @return 返回使用base64解码的字符串
 */

- (NSString *)base64Decode:(NSString *)encodedString {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:encodedString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
