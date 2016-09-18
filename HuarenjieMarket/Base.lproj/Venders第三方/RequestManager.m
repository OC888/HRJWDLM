//
//  RequestManager.m
//  TrafficPlusPlus
//
//  Created by Smartios2012 on 15/7/27.
//  Copyright (c) 2015年 com.plusplus. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

+ (RequestManager *)shareInstance {
    __strong static RequestManager *requestManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestManager = [[RequestManager alloc] init];
    });
    return requestManager;
}

- (void)login:(NSString *)user_name password:(NSString *)user_pwd completion:(void (^)(NSDictionary *))completion {
    
    NSDictionary *params = @{@"user_name":user_name,@"user_pwd":user_pwd};
    
    
//    NSString *doucumentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
//    NSString *filePath = [doucumentsPath stringByAppendingPathComponent:@"Villlogin.text"];
//    [params writeToFile:filePath atomically:YES];

    
    [[DownloadManager shareInstance] requestData:Method_Login params:params completion:^(NSString *JSONObject) {
        if (JSONObject) {
            NSData *data = [JSONObject dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if (completion) {
                completion(dictionary);
            }
        } else {
            if (completion) {
                completion(nil);
            }
        }
    }];
}

- (void)registerUser:(NSString *)username password:(NSString *)password email:(NSString *)email completion:(void (^)(NSDictionary *jsonData))completion {
    NSDictionary *params = @{@"username":username,@"password":password,@"password_confirm":password,@"client":@"wap"};
    [[DownloadManager shareInstance] requestData:Method_Register params:params completion:^(NSString *JSONObject) {
        if (JSONObject) {
            NSData *data = [JSONObject dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if (completion) {
                completion(dictionary);
            }
        } else {
            if (completion) {
                completion(nil);
            }
        }
    }];
}

- (void)getUser:(NSString *)login_status user_id:(NSString *)user_id completion:(void (^)(NSDictionary *))completion {
    NSString *key = [[NSUserDefaults standardUserDefaults] objectForKey:@"DesKey"];
    NSDictionary *params = @{@"login_status":login_status,@"user_id":[self encrypt:user_id encryptOrDecrypt:kCCEncrypt key:key]};
    [[DownloadManager shareInstance] requestData:Method_GetUser params:params completion:^(NSString *JSONObject) {
        if (JSONObject) {
            NSData *data = [JSONObject dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if (completion) {
                completion(dictionary);
            }
        } else {
            if (completion) {
                completion(nil);
            }
        }
    }];
}

- (void)getAccount:(void (^)(NSDictionary *))completion {
    [[DownloadManager shareInstance] requestData:Method_GetAccount params:nil completion:^(NSString *JSONObject) {
        if (JSONObject) {
            NSData *data = [JSONObject dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if (completion) {
                completion(dictionary);
            }
        } else {
            if (completion) {
                completion(nil);
            }
        }
    }];
}

- (void)call:(NSString *)member_id caller:(NSString *)caller called:(NSString *)called completion:(void (^)(NSDictionary *))completion {
    
    NSString *key = [[NSUserDefaults standardUserDefaults] objectForKey:@"DesKey"];

    NSDictionary *params = @{@"login_status":@"1",@"member_id":[self encrypt:member_id encryptOrDecrypt:kCCEncrypt key:key],@"caller":caller,@"called":called};
    [[DownloadManager shareInstance] requestData:Method_Call params:params completion:^(NSString *JSONObject) {
        if (JSONObject) {
            
            NSData *data = [JSONObject dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if (completion) {
                completion(dictionary);
            }
        } else {
            if (completion) {
                completion(nil);
            }
        }
    }];
}

- (void)getCallIP:(void (^)(NSString *))completion {
    [[DownloadManager shareInstance] requestData:Method_GetCallIP params:nil completion:^(NSString *JSONObject) {
        if (completion) {
            completion(JSONObject);
        }
    }];
}

- (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key{
    const void *dataIn;
    size_t dataInLength;
    if (encryptOperation == kCCDecrypt) {
        NSData *decryptData = [[NSData alloc] initWithBase64EncodedData:[sText dataUsingEncoding:NSUTF8StringEncoding] options:0];//[GTMBase64 decodeData:];
        dataInLength = [decryptData length];
        dataIn = [decryptData bytes];
    } else {
        NSData *encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
        dataInLength = [encryptData length];
        dataIn = (const void *)[encryptData bytes];
    }
    uint8_t *dataOut = NULL;
    size_t dataOutAvailable = 0;
    size_t dataOutMoved = 0;
    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);
    NSString *initIv = @"12345678";
    const void *vkey = (const void *)[key UTF8String];
    const void *iv = (const void *)[initIv UTF8String];
    CCCrypt(encryptOperation,
            kCCAlgorithmDES,
            kCCOptionPKCS7Padding | kCCOptionECBMode,
            vkey,
            kCCKeySizeDES,
            iv,
            dataIn,
            dataInLength,
            (void *)dataOut,
            dataOutAvailable,
            &dataOutMoved);
    NSString *result = nil;
    if (encryptOperation == kCCDecrypt) {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved] encoding:NSUTF8StringEncoding];
    } else {
        NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
        result = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    return result;
}

@end
