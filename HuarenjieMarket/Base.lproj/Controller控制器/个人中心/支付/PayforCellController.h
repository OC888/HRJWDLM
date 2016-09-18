//
//  PayforCellController.h
//  PayObject
//
//  Created by aaa on 16/8/22.
//  Copyright © 2016年 王泉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayforCellController : UITableViewController
@property (nonatomic,copy) NSString *moneyNum;//订单金额
@property (nonatomic,copy) NSString *userMobileNum;//账户手机号
@property (nonatomic,copy) NSString *accountMobileNum;//要充值手机号
@property (nonatomic,copy) NSString *userIp;//用户终端设备ip
@end
