//
//  WXApiManager.m
//  PayObject
//
//  Created by aaa on 16/8/23.
//  Copyright © 2016年 王泉. All rights reserved.
//

#import "WXApiManager.h"
static WXApiManager *singleWX;
@implementation WXApiManager
//创建单例对象
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleWX = [[WXApiManager alloc]init];
    });
    return singleWX;
}

#pragma mark - WXApiDelegate -
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]) {
//    支付返回结果,实际支付结果需要去微信服务器端查询
        NSString *strMsg;
        switch (resp.errCode) {
            case WXSuccess:{
                strMsg = @"支付成功!";
                NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
            default:{
                strMsg = [NSString stringWithFormat:@"支付失败 retCode = %d,retStr = %@",resp.errCode,resp.errStr];
                NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)onReq:(BaseReq *)req {

}

@end
