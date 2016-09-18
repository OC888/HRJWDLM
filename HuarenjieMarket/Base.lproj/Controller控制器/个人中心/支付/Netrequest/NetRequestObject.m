//
//  NetRequestObject.m
//  PayObject
//
//  Created by aaa on 16/8/22.
//  Copyright © 2016年 王泉. All rights reserved.
//

#import "NetRequestObject.h"

@implementation NetRequestObject

#pragma  -- mark GET 请求方式
+ (void)NetRequestGETWithRequestURL:(NSString *)requestURLString WithParameter:(NSDictionary *)parameter WithReturnValeuBlock:(ReturnValueBlock)block WithErrorCodeBlock:(ErrorCodeBlock)errorBlock WithFailureBlock:(FailureBlock)failureBlock {
    AFHTTPRequestOperationManager  *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager GET:requestURLString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
}



@end
