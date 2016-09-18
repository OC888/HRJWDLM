//
//  PayOnlineController.m
//  PayObject
//
//  Created by aaa on 16/8/20.
//  Copyright © 2016年 王泉. All rights reserved.
//

#import "PayOnlineController.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#define myDotNumbers     @"0123456789.\n"
#define myNumbers          @"0123456789\n"
@interface PayOnlineController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *mobielNum;//    手机号
@property (nonatomic,strong) UITextField *moneyNum;//    金额数
@property (nonatomic,strong) UIView *tapMoneyView;//    选择金额
@property (nonatomic,strong) UIButton *payButton;//    充值按钮
@end
static NSDictionary *userDIC;
@implementation PayOnlineController

- (void)viewDidLoad {
    [super viewDidLoad];
//    取出登录账号信息
    NSString *doucumentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *filePath = [doucumentsPath stringByAppendingPathComponent:@"Villlogin.text"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    userDIC = dic;
    [self layoutSubViews];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)layoutSubViews {
//    手机号
    self.mobielNum = [[UITextField alloc]init];
    _mobielNum.placeholder = @"请输入要充值的手机号";
    _mobielNum.textAlignment = NSTextAlignmentCenter;
    _mobielNum.backgroundColor = [UIColor whiteColor];
    _mobielNum.layer.cornerRadius = 14;
    _mobielNum.layer.borderWidth = 1.0;
    
    self.mobielNum.delegate = self;
    [self.view addSubview:_mobielNum];
    [_mobielNum makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(HEIGHT / 16);
        make.size.equalTo(CGSizeMake(WIDTH - 40, 40));
    }];
//    金额数
    self.moneyNum = [[UITextField alloc]init];
    _moneyNum.placeholder = @"请选择或输入金额";
    _moneyNum.textAlignment = NSTextAlignmentCenter;
    _moneyNum.layer.cornerRadius = 14;
    _moneyNum.layer.borderWidth = 1.0;
    self.moneyNum.delegate = self;
    [self.view addSubview:_moneyNum];
    [_moneyNum makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_mobielNum.bottom).offset(30);
        make.size.equalTo(_mobielNum);
    }];
    
//    选择金额
    self.tapMoneyView = [[UIView alloc]init];
    _tapMoneyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tapMoneyView];
    [_tapMoneyView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_moneyNum.bottom).offset(20);
        make.size.equalTo(CGSizeMake(WIDTH - 40, HEIGHT / 16));
        make.centerX.equalTo(self.view);
    }];
    NSArray *moneyArr = @[@"100",@"200",@"500",@"1000"];
    for (int i = 0;i < moneyArr.count; i++) {
        float width = (WIDTH - 40 - 10 * (moneyArr.count - 1)) / moneyArr.count;
        float height = (HEIGHT / 16) - 20;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = 14;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:moneyArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickMoney:) forControlEvents:UIControlEventTouchUpInside];
        [self.tapMoneyView addSubview:button];
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(width, height));
            make.left.equalTo(_tapMoneyView.left).offset(i * (width + 10));
            make.top.equalTo(_tapMoneyView);
        }];
    }
//    充值按钮
    self.payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _payButton.backgroundColor = BJCOLOR;
    _payButton.layer.cornerRadius = 14;
    [_payButton setTitle:@"充值" forState:UIControlStateNormal];
    [_payButton addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payButton];
    [_payButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(- HEIGHT / 6);
        make.size.equalTo(CGSizeMake(WIDTH / 2, HEIGHT /15));
    }];
}

- (void)clickMoney:(UIButton *)sender {
    self.moneyNum.text = [sender titleForState:UIControlStateNormal];
}

//充值按钮方法
- (void)payAction:(UIButton *)sender {
    if ([self.mobielNum.text isEqualToString:@""]||![self isMobileNumber:_mobielNum.text]) {
        [self alertMessage:@"请输入正确的手机号"];
    }
    else {
        if ([self.moneyNum.text isEqualToString:@""]) {
            [self alertMessage:@"请输入金额"];
        } else {
#pragma  充值手机号
            
            NSString *userNum = userDIC[@"user_name"];
            NSString *ip = [self getIPAddress];
            !self.payClick?:self.payClick(_moneyNum.text,userNum,_mobielNum.text,ip);
        }
        
    }

}

//弹窗
- (void)alertMessage:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}

//检测手机号码是否合乎规格
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//特殊字符限制判断
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *cs;
//    判断金额输入框只能输入数字或小数点    小数点后不超过三位
        if ([textField isEqual:_moneyNum]){
        NSUInteger nDotLoc = [textField.text rangeOfString:@"."].location;
        if (NSNotFound == nDotLoc && 0!= range.location) {
            cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers]invertedSet];
        } else {
            cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers]invertedSet];
        }
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if (!basicTest) {
            [self alertMessage:@"只能输入数字和小数点"];
            return NO;
        }
        if (NSNotFound != nDotLoc && range.location > nDotLoc + 3) {
            [self alertMessage:@"小数点后最多三位"];
            return NO;
        }
    }
//    判断手机输入框只能输入数字
    if ([textField isEqual:_mobielNum]) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers]invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if (!basicTest) {
            [self alertMessage:@"只能输入数字"];
            return NO;
        }
    }
    return YES;
}

//点击空白收回键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

//获取终端ip
- (NSString *)getIPAddress {
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    
    //    if (sockfd <</span> 0)
    //        return nil;
    
    NSMutableArray *ips = [NSMutableArray array];
    int BUFFERSIZE = 4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    
    NSString *deviceIP = @"";
    
    for (int i=0; i < ips.count; i++)
    {
        if (ips.count > 0)
        {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
