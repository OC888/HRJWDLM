//
//  MyNetWorking.m
//  MyGCDs
//
//  Created by 赵一 on 16/5/17.
//  Copyright © 2016年 赵一. All rights reserved.
//

#import "MyNetWorking.h"

@interface MyNetWorking ()



@end

@implementation MyNetWorking

+(id)CreatObject {
    static MyNetWorking *net = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        net = [[MyNetWorking alloc] init];
    });
    return net;
}


-(void)CreatNetWorkingWithURL:(NSString *)urls Parameter:(NSString *)body ParserData:(netWorkingBlock)passValue {
    
    NSString *urlStr = [urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    if (body || ![body isEqualToString:@" "]) {
        [request setHTTPMethod:@"POST"];
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
    }
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
//            if (isArray) {
//                NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                passValue(data);
//            }else {
//            NSDictionary *Array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            passValue(data);
//            }
            
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            passValue(array);
            NSLog(@"array=%@",array);
            
        }else if(error){
            NSLog(@"///%@///",error);
        }
       
    }];
    [task resume];
}






@end
