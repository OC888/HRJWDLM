//
//  ViewController.m
//  PhoneCallBack
//
//  Created by Smartios2012 on 15/7/29.
//  Copyright (c) 2015年 com.hjl. All rights reserved.
//

#import "LoginViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIView+Toast.h"
#import "RequestManager.h"
#import "RegisterViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)CAGradientLayer *gradientLayer;

@end

@implementation LoginViewController
- (IBAction)toregist:(id)sender {
    RegisterViewController *rV = [self.storyboard instantiateViewControllerWithIdentifier:@"regist"];
    [self presentViewController:rV animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.mobileTxtF) {
         [self.pwdTxtF becomeFirstResponder];
        return YES;
    }
    return [textField resignFirstResponder];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    //返回一个BOOL值指明是否允许根据用户请求清除内容
    //可以设置在特定条件下才允许清除内容
    
    if (textField == self.pwdTxtF) {
        return YES;
    }
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(asdf:) name:@"RegestS" object:nil];
    
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status==0) {
            SHOW_MESSAGE(@"亲，网络错误，请检查后重试");
        }
    }];

    self.mobileTxtF.returnKeyType = UIReturnKeyNext;
    self.pwdTxtF.returnKeyType = UIReturnKeyGo;
    
    self.mobileTxtF.delegate = self;
    self.pwdTxtF.delegate = self;
    self.pwdTxtF.secureTextEntry = YES;
    //自定义标题视图
//    self.mobileTxtF.text = @"18203650822";
//    self.pwdTxtF.text = @"111111";
    
   // [[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
    
    self.navigationController.navigationBarHidden = YES;
    UILabel *titleLabel = [[UILabel
                            alloc] initWithFrame:CGRectMake(0,
                                                            0, 150, 66)];
    
    
//    titleLabel.backgroundColor = [UIColor
//                                  redColor];
    
    
    titleLabel.font = [UIFont
                       boldSystemFontOfSize:16];
    
    
    titleLabel.textColor = [UIColor 
                            blackColor];
    
    
    titleLabel.textAlignment = 
    NSTextAlignmentCenter;
    
    
    titleLabel.text = 
    @"手机号登录";
    
    
    
    self.navigationItem.titleView = titleLabel;

}

- (void)asdf:(NSNotification *)noti {
    _mobileTxtF.text =  noti.userInfo[@"UserId"];
    _pwdTxtF.text = noti.userInfo[@"Psw"];
}

// 随机颜色方法
-(UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

// 定时器触发方法
-(void)textColorChange {
    _gradientLayer.colors = @[(id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor];
}

- (void)btnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1001: {
            
            if (self.mobileTxtF.text.length == 0) {
                [self.view.window makeToast:@"请输入手机号码" duration:2.0 position:@"center"];
                return;
            }
            if (self.pwdTxtF.text.length == 0) {
                [self.view.window makeToast:@"请输入密码" duration:2.0 position:@"center"];
                return;
            }
            __block MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view.window addSubview:hud];
            hud.labelText = @"正在登录...";
            [hud show:YES];
            [[RequestManager shareInstance] login:self.mobileTxtF.text password:self.pwdTxtF.text completion:^(NSDictionary *jsonData) {
                if (jsonData) {
                    [hud hide:YES];
                    
                    if ([[jsonData objectForKey:@"type"] isEqualToString:@"success"]) {
 
                        NSDictionary *params = @{@"user_name":self.mobileTxtF.text,@"user_pwd":self.pwdTxtF.text};

                        NSString *doucumentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
                        NSString *filePath = [doucumentsPath stringByAppendingPathComponent:@"Villlogin.text"];
                        [params writeToFile:filePath atomically:YES];

                        
                        [self.view.window makeToast:@"登录成功" duration:2.0 position:@"center"];
                        NSDictionary *dict = [jsonData objectForKey:@"data"];
                        [[NSUserDefaults standardUserDefaults] setObject:self.mobileTxtF.text forKey:@"UserId"];
                        [[NSUserDefaults standardUserDefaults] setObject:self.pwdTxtF.text forKey:@"PSW"];
//                        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"UserInfo"];
                        [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"key"] forKey:@"DesKey"];
                        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
                        self.view.window.rootViewController = vc;
                    } else {
                        [self.view.window makeToast:[jsonData objectForKey:@"msg"] duration:2.0 position:@"center"];
                    }
                }
            }];
        }
            break;
        case 1002: {
            [self performSegueWithIdentifier:@"ToRegister" sender:nil];
        }
            break;
        case 1003: {
            [self performSegueWithIdentifier:@"ToForgetPwd" sender:nil];
        }
            break;
        default:
            break;
    }
}

-(BOOL)prefersStatusBarHidden
{
return YES;
    
}
 @end
