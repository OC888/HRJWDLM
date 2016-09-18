//
//  RequestManager.h
//  TrafficPlusPlus
//
//  Created by Smartios2012 on 15/7/27.
//  Copyright (c) 2015年 com.plusplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadManager.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

#define CURRENT_USERID [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"]

@interface RequestManager : NSObject

/**
 请求数据的特定方法的单例
 
 @return 返回RequestManager的一个单例
 */
+ (RequestManager *)shareInstance;

//返回消息：
//msg对象
//{type:'success',data:{},extras:{},msg:""}
//
//type:响应结果  success  error  (通用)
//data: 返回的json数据 (详见接口说明)
//msg：错误信息	(通用)

/**
 登录
 
 @param user_name 用户名
 @param user_pwd 密码
 @param completion block回调返回数据
 */
- (void)login:(NSString *)user_name password:(NSString *)user_pwd completion:(void (^)(NSDictionary *jsonData))completion;

/**
 获取会员信息

 返回数据：
	data ：
	{
 member_id:1,			//用户id
 member_name:'',		//用户名
 member_truename:'', 	//真实姓名
 member_avator:'',		//会员头像
 member_sex:1,			//1=男  0=女
 available_predeposit:88.88, //预存款可用金额
 freeze_predeposit:20.65,	//预存款冻结金额
 is_free:1,					//是否为免费用户(部分用户会赠送一年话费)
 timeout:'2016-08-09',		//免费用户到期时间(只要不过期 可以随意打电话，无需发送扣款请求)
 net_price:0.05				//话费价格 元/分钟
 
	}
 
 @param login_status (登录状态): 0 未登录，1已登录
 @param user_id 使用加密密钥 进行des加密
 @param completion block回调返回数据
 */
- (void)getUser:(NSString *)login_status user_id:(NSString *)user_id completion:(void (^)(NSDictionary *jsonData))completion;

/**
 用户打电话扣费接口
 打电话前 要先获取用户信息 得到余额，根据价格 计算出最多通话时间，不能超过这个时间
 
 返回数据：
	data ： {	}
	msg:"扣费成功"
	
 
 用户登陆之后的数据可以离线存储 (如登陆状态，用户Id 用户名，头像等)
 
 及时更新用户余额
 
 @param login_status (登录状态): 0 未登录，1已登录
 @param member_id 使用加密密钥 进行des加密
 @param call_min (通话时长): 整数 (如5分30秒 只要超过5分  全部按6分钟计算)
 @param completion block回调返回数据
 */
- (void)netPrice:(NSString *)login_status member_id:(NSString *)member_id call_min:(NSString *)call_min completion:(void (^)(NSDictionary *jsonData))completion;

/**
 用户注册：(此接口非api定义  返回内容格式不同  注意解析)
 password_confirm	确认密码  界面如果没有此项 将此项的值设置为password的值 传过来
 client: 注册来源，默认为wap 写死即可
 
 返回数据：
 错误的数据格式：
 {"code":200,"datas":{"error":"\u5bc6\u7801\u4e0e\u786e\u8ba4\u5bc6\u7801\u4e0d\u76f8\u540c"}}
 error为错误信息 json解码为汉字即可
 
 成功的数据格式：
 {"code":200,"datas":{"username":"admin002","key":"38233a24ef6bc5438e9f03f8acd60230"}}
 username 为注册成功的用户名   key是系统自动加密的内容  忽略即可
 
 成功后  可根据用户输入的用户名和密码 通过上面的登录接口 获取用户信息
 
 @param username	用户名
 @param password		密码
 @param email：邮箱 		客户端请做好验证
 @param completion block回调返回数据
 */
- (void)registerUser:(NSString *)username password:(NSString *)password email:(NSString *)email completion:(void (^)(NSDictionary *jsonData))completion;

/**
 为了方便后台设置总账号 如密码变更等 现增加获取打电话的总账号接口  在打电话前请求
 获取总账号
 
 成功示例
 {type:'success',data:38233a24ef6bc,msg:"获取成功"}
 
 总账号 在data里面  需要使用 用户登陆后获取的key值(加密密钥) 对data 进行DES解密  得到的格式是 账号|密码  如  admin|123456  admin即是账号  123456是密码
 
 错误示例：
 {type:'error',data:'',msg:"总账号未设置"}

 @param completion block回调返回数据
 */
- (void)getAccount:(void (^)(NSDictionary *jsonData))completion;

- (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key;

- (void)call:(NSString *)member_id caller:(NSString *)caller called:(NSString *)called completion:(void (^)(NSDictionary *jsonData))completion;

- (void)getCallIP:(void (^)(NSString *jsonData))completion;

@end
