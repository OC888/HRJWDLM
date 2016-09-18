//
//  Header.h
//  temp
//
//  Created by l x on 16/5/19.
//  Copyright © 2016年 wangli. All rights reserved.
//


#ifndef Header_h
#define Header_h

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)(id reason);
//微信支付后台接口
#define WechatPayUrl @"http://zghrj.cn/wxpay/unipay.php?total_amount=%@&name=%@&account=%@&ip=%@"
//微信支付通知名称
#define ORDER_PAY_NOTIFICATION @"WeChatPay"


#define SHOW_MESSAGE(message) MBProgressHUD *mb =[[MBProgressHUD alloc]init];\
[self.view addSubview:mb];\
mb.mode= MBProgressHUDModeText;\
mb.alpha=0.3;\
mb.labelText=message;\
[mb show:YES];\
[mb hide:YES afterDelay:2];

#define MW [UIScreen mainScreen].bounds.size.width
#define MH [UIScreen mainScreen].bounds.size.height

#define SHOW_NOALERT(msg) UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {\
[self.navigationController popViewControllerAnimated:YES];\
}];\
[alertController addAction:okAction];\
[self presentViewController:alertController animated:YES completion:nil];

#define SHOW_ALERT(msg) UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {\
}];\
[alertController addAction:okAction];\
[self presentViewController:alertController animated:YES completion:nil];

#define NUMBERS @"0123456789"
#define BJCOLOR [UIColor colorWithRed:252/255.0 green:110/255.0 blue:120/255.0 alpha:1]
#define LINECOLOR [UIColor colorWithRed:200/255.0 green:190/255.0 blue:204/255.0 alpha:1]
#define BUTTON_WIDTH self.bounds.size.width
#define BUTTON_HEIGHT self.bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

//微信支付ID和商户号
#define AppID @"wxabaf4a671d6b9d60"
#define mchID @"1280576001"
// 只要添加了这个宏，就不用带mas_前缀
#define MAS_SHORTHAND
// 只要添加了这个宏，equalTo就等价于mas_equalTo
#define MAS_SHORTHAND_GLOBALS

// 这个头文件一定要放在上面两个宏的后面
#import "Masonry.h"



#import "AFHttpManager.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "PickerView.h"
#import "BottomView.h"
#import "CarButton.h"
#import "JobListViewController.h"
#import "ResumeInfo.h"
#import "CarInfo.h"
#import "BikeInfo.h"
#import "FullTimeInfo.h"
#import "ErShouGoods.h"
#import "ErShouFangQiuGouInfo.h"
#import "ErShouFangInfo.h"
#import "PartTimeInfo.h"
#import "ShangPuInfo.h"
#import "SDCycleScrollView.h"
#import "NewHouseInfo.h"
#import "HeZuInfo.h"
#import "QiuZuInfo.h"
#import "RiZuDuanZu.h"
#import "MBProgressHUD.h"
#import "CheckText.h"
#import "WXApi.h"
#import "WXApiObject.h"

#endif /* Header_h */

#ifdef DEBUG //调试阶段
#define PCLog(...) NSLog(__VA_ARGS__)
#else   //发布阶段
#define PCLog(...) //NSLog(__VA_ARGS__)
#endif

