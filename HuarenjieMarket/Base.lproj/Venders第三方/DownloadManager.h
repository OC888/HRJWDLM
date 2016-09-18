//
//  DownloadManager.h
//  TrafficPlusPlus
//
//  Created by Smartios2012 on 15/7/27.
//  Copyright (c) 2015年 com.plusplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define Method_Login                       @"phone_api&op=login"
#define Method_GetUser                     @"phone_api&op=get_user"
#define Method_NetPrice                    @"phone_api&op=net_price"
#define Method_Register                    @"login&op=register"
#define Method_GetAccount                  @"phone_api&op=get_account"
#define Method_Call                        @"phone_api&op=member_call"
#define Method_GetCallIP                   @"/API/CellPhone_GetApiIp.aspx?ID=4505"

#define HTTP_SERVER_PATH @"http://zghrj.cn/index.php?act="

//#define HTTP_SERVER_PATH [NSString stringWithFormat:@"http://%@:%@/webservice.asmx/",[[NSUserDefaults standardUserDefaults] objectForKey:@"IP"],[[NSUserDefaults standardUserDefaults] objectForKey:@"Port"]]
/**
 ---
 
 @param
 
 @return/@see
 */

@interface DownloadManager : NSObject

/**
 请求数据的通用单例
 
 @return 返回DownloadManager的一个单例对象
 */
+ (DownloadManager *)shareInstance;

//- (void)cancelRequest:(NSString *)vcName;

/**
 请求数据的通用方法
 
 @param method 接口方法名称
 @param params 接口参数的键值对
 @param completion block回调返回数据
 */
- (void)requestData:(NSString *)method params:(NSDictionary *)params completion:(void (^)(NSString *JSONObject))completion;

@end
