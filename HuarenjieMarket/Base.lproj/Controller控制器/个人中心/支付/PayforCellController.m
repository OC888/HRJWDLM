//
//  PayforCellController.m
//  PayObject
//
//  Created by aaa on 16/8/22.
//  Copyright © 2016年 王泉. All rights reserved.
//

#import "PayforCellController.h"
#import "PayCell.h"
#import "NetRequestObject.h"
#import "PayResultController.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import "AlipayHeader.h"
@interface PayforCellController ()<MBProgressHUDDelegate>
@property (nonatomic,copy) NSString *localIP;//终端IP
@property (nonatomic,strong) MBProgressHUD *HUD;
@end
static NSString *identifier = @"payCellIdentifier";
@implementation PayforCellController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    UINib *nib = [UINib nibWithNibName:@"PayCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
    self.tableView.rowHeight = 70;
//    接收通知 进行支付结果后的处理
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getOrderPayResult:) name:ORDER_PAY_NOTIFICATION object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PayCell" owner:self options:nil]lastObject];
    }
    if (indexPath.section == 0) {
        cell.PayImage.image = [UIImage imageNamed:@"绿色logo"];
        cell.payTitle.text = @"微信支付";
    } else {
        cell.PayImage.image = [UIImage imageNamed:@"120x120"];
        cell.payTitle.text = @"支付宝";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
//        微信支付
        [self WeiXinPay];
    } else {
//        支付宝支付
        [AlipayRequestConfig alipayWithPartner:kPartnerID seller:kSellerAccount tradeNO:[AlipayToolKit genTradeNoWithTime] productName:@"华人街话费" productDescription:@"话费" amount:_moneyNum notifyURL:kNotifyURL itBPay:@"30m" name:_userMobileNum phoneN:_accountMobileNum];
    }
    
}

//调起微信支付
- (void)WeiXinPay {
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
//    _HUD.dimBackground = YES;
//    判断用户是否安装微信
    if ([WXApi isWXAppInstalled]) {
        _HUD.delegate = self;
        _HUD.labelText = @"正在为您支付...";
        [_HUD show:YES];

        NSString *urlStr = [NSString stringWithFormat:WechatPayUrl,_moneyNum,_userMobileNum,_accountMobileNum,_userIp];
        //        向系统后台发送请求 获取支付调起所需
        [NetRequestObject NetRequestGETWithRequestURL:urlStr WithParameter:nil WithReturnValeuBlock:^(id returnValue) {
            [_HUD hide:YES];
            NSDictionary *returnDic = (NSDictionary *)returnValue;
                 if ([returnDic[@"result"] isEqualToString:@"success"]) {
                      if (returnDic[@"data"] != nil) {
                          NSDictionary *dataDic = returnDic[@"data"];
                          NSString *appid = dataDic[@"appid"];
                          NSString *noncestr = dataDic[@"noncestr"];
                          NSString *package = dataDic[@"package"];
                          NSString *partnerid = dataDic[@"partnerid"];
                          NSString *prepayid = dataDic[@"prepayid"];
                          NSString *sign = dataDic[@"sign"];
                          NSString *timestamp = dataDic[@"timestamp"];
                            [self WXPayRequest:appid nonceStr:noncestr package:package partnerId:partnerid prepayId:prepayid timeStamp:timestamp sign:sign];
                          } else {
                            [_HUD hide:YES];
                            [self alert:@"提示" msg:@"网络错误"];
                       }
                   } else {
                      [_HUD hide:YES];
                       NSString *message = [NSString stringWithFormat:@"%@,错误重试",returnDic[@"msg"]];
                      [self alert:@"错误重试" msg:message];
                }
            } WithErrorCodeBlock:^(id errorCode) {
                [_HUD hide:YES];
                [self alert:@"提示" msg:@"网络出错"];
         } WithFailureBlock:^(id reason) {
             NSLog(@"%@",reason);
             [_HUD hide:YES];
             [self alert:@"提示" msg:@"网络请求失败"];
        }];
    } else {
        _HUD.delegate = self;
        [_HUD hide:YES];
        [self alert:@"提示" msg:@"您未安装微信!"];
    }
}

//发起支付
#pragma mark - 发起支付请求
- (void)WXPayRequest:(NSString *)appId nonceStr:(NSString *)nonceStr package:(NSString *)package partnerId:(NSString *)partnerId prepayId:(NSString *)prepayId timeStamp:(NSString *)timeStamp sign:(NSString *)sign{
    //调起微信支付
    PayReq* wxreq             = [[PayReq alloc] init];
//    wxreq.openID              = WXAppId;
    /** 商家向财付通申请的商家id */
    wxreq.partnerId           = partnerId;
    /** 预支付订单 */
    wxreq.prepayId            = prepayId;
    /** 随机串，防重发 */
    wxreq.nonceStr            = nonceStr;
    /** 时间戳，防重发 */
    wxreq.timeStamp           = [timeStamp intValue];
    /** 商家根据财付通文档填写的数据和签名 */
    wxreq.package             = package;
    /** 商家根据微信开放平台文档对数据做的签名 */
    //    加密处理
    wxreq.sign                = sign;
    //    进入微信客户端，支付订单
    [WXApi sendReq:wxreq];
}

//通知信息
- (void)getOrderPayResult:(NSNotification *)notification {
    if ([notification.object isEqualToString:@"success"])
    {
        [_HUD hide:YES];
        PayResultController *resultVC = [[PayResultController alloc]init];
        resultVC.money = self.moneyNum;
        resultVC.result = @"订单支付成功!";
        resultVC.payNum = _accountMobileNum;
        [self presentViewController:resultVC animated:YES completion:nil];
        
    }
    else
    {
        [_HUD hide:YES];
        PayResultController *resultVC = [[PayResultController alloc]init];
        resultVC.money = self.moneyNum;
        resultVC.result = @"订单支付失败!";
        resultVC.payNum = _accountMobileNum;
        [self presentViewController:resultVC animated:YES completion:nil];
        
    }
}

//弹窗
//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}


//移除通知
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [_HUD removeFromSuperview];
    _HUD = nil;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
