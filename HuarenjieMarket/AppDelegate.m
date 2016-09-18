//
//  AppDelegate.m
//  HuarenjieMarket
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 dujiaqi. All rights reserved.

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

#import "AppDelegate.h"
#import "MainTableViewControllerNew.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "RequestManager.h"
#import "UIView+Toast.h"
#import "EaseMob.h"
#import "IQKeyboardManager.h"
#import "AlipayHeader.h"
#import "WXApi.h"
#import "WXApiManager.h"
@interface AppDelegate ()<IChatManagerDelegate>


@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    PCLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]);
    
//    注册微信应用
    [WXApi registerApp:AppID];
   
    [ShareSDK registerApp:@"1534c7c8fdd7c"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
                 
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeRenren:
                 [appInfo        SSDKSetupRenRenByAppId:@"226427"
                                                 appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                                              secretKey:@"f29df781abdd4f49beca5a2194676ca4"
                                               authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeGooglePlus:
                 [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
                                           clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
                                            redirectUri:@"http://localhost"];
                 break;
             default:
                 break;
         }
     }];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
   
   
    NSString *doucumentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *filePath = [doucumentsPath stringByAppendingPathComponent:@"Villlogin.text"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
 
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    
    
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"huarenjie123#honghaitao123" apnsCertName:@"chatdemoui"];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [[EaseMob sharedInstance].chatManager enableAutoLogin];
    [[EaseMob sharedInstance].chatManager setIsAutoFetchBuddyList:YES];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];

    
    
    if (!dic) {
    self.window.rootViewController = loginVC;
        
    }else {
            PCLog(@"%@",dic[@"user_name"]);
            PCLog(@"===%@",dic[@"user_pwd"]);
        //        self.loginV.mobileTxtF.text = @"18203650822";
        //        self.loginV.pwdTxtF.text = @"111111";
        //        self.window.rootViewController = self.loginV;
        
        __block MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.window];
        [self.window addSubview:hud];
        hud.labelText = @"正在登录...";
        
//        UILabel *lab = [[UILabel alloc]init];
//        lab.backgroundColor = [UIColor redColor];
//        lab.text = @"";
//        [self.window addSubview:lab];
        
        [hud show:YES];
        [[RequestManager shareInstance] login:dic[@"user_name"] password:dic[@"user_pwd"] completion:^(NSDictionary *jsonData) {
            if (jsonData) {
                [hud hide:YES];
                if ([[jsonData objectForKey:@"type"] isEqualToString:@"success"]) {
                    
                    [self.window makeToast:@"登录成功" duration:2.0 position:@"center"];
                    NSDictionary *dict = (NSDictionary *)[jsonData objectForKey:@"data"];
                    [[NSUserDefaults standardUserDefaults] setObject:dic[@"user_name"] forKey:@"UserId"];
//                    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"UserInfo"];
                    [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"key"] forKey:@"DesKey"];
                    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Main"];
                    self.window.rootViewController = vc;
                }
        
    }
        
         }];

    }
    [self.window makeKeyAndVisible];

    return YES;
}
 
//跳转处理
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        return YES;
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        return YES;
    }
    else if ([sourceApplication isEqualToString:@"com.tencent.xin"]){
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    } else {
        return YES;
    }
}

//回调
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    //创建通知体
    NSNotification *notif= [NSNotification notificationWithName:@"phoneBreak" object:nil userInfo:nil];
    //注册通知中心
    [[NSNotificationCenter defaultCenter] postNotification:notif];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
