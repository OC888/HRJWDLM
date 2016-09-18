//
//  PayOnlineController.h
//  PayObject
//
//  Created by aaa on 16/8/20.
//  Copyright © 2016年 王泉. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^payBlock)(NSString *money,NSString *userMobile,NSString *accountMobile,NSString *IP);
@interface PayOnlineController : UIViewController
@property (nonatomic,copy) payBlock payClick;// 点击充值按钮的block回调
@end
