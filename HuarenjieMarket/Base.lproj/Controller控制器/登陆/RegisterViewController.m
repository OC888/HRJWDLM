//
//  RegisterViewController.m
//  PhoneCallBack
//
//  Created by exlm-apple on 15/8/4.
//  Copyright (c) 2015年 com.hjl. All rights reserved.

#import "RegisterViewController.h"
#import "MBProgressHUD.h"
#import "UIView+Toast.h"
#import "RequestManager.h"
#import "MyNetWorking.h"
@interface RegisterViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnback;

@end

@implementation RegisterViewController
- (IBAction)backtobao:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)Register123:(id)sender {
    NSString *str = self.mobileTxtF.text;
    NSString *str1 = self.pwdTxtF.text;
    NSString *urls = [NSString stringWithFormat:@"http://zghrj.cn/wap/tmpl/member/enroll2.php?username=%@&password=%@&password_confirm=%@",str,str1,str1];
  BOOL isValidate =[self isValidateMobile:str];
    if (isValidate) {
        MyNetWorking *myN = [MyNetWorking CreatObject];
        [myN CreatNetWorkingWithURL:urls Parameter:nil ParserData:^(id data) {
            [self jiexi:data];
        }];
    }else {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"错误" message:@"请输入正确的手机号" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertVC addAction:action1];
        
        [self.navigationController presentViewController:alertVC animated:YES completion:nil];
    }
}

-(void)jiexi:(NSDictionary *) sender {
    NSLog(@"注册账号结果：%@",sender);
    NSString *resault = sender[@"result"];
    
    if ([resault isEqualToString:@"success"]) {
        NSLog(@"注册成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view.window makeToast:@"注册成功" duration:2.0 position:@"center"];
        });
        
    }else if ([resault isEqualToString:@"error"] || !resault) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view.window makeToast:@"注册失败" duration:2.0 position:@"center"];
        });
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpMenuButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction:(UIButton *)sender {
    if (self.mobileTxtF.text.length == 0) {
        [self.view.window makeToast:@"请输入手机号码" duration:2.0 position:@"center"];
        return;
    }
    if (![self isValidateMobile:self.mobileTxtF.text]) {
        [self.view.window makeToast:@"请输入有效的手机号" duration:2.0 position:@"center"];
        return;
    }
    if (self.pwdTxtF.text.length == 0) {
        [self.view.window makeToast:@"请输入密码" duration:2.0 position:@"center"];
        return;
    }
    if (self.pwd2TxtF.text.length == 0) {
        [self.view.window makeToast:@"请再输入密码" duration:2.0 position:@"center"];
        return;
    }
    if (![self.pwdTxtF.text isEqualToString:self.pwd2TxtF.text]) {
        [self.view.window makeToast:@"两次密码输入不一致" duration:2.0 position:@"center"];
        return;
    }
    __block MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view.window addSubview:hud];
    hud.labelText = @"正在注册...";
    [hud show:YES];
    [[RequestManager shareInstance] registerUser:self.mobileTxtF.text password:self.pwdTxtF.text email:@"" completion:^(NSDictionary *jsonData) {
        if (jsonData) {
            [hud hide:YES];
            NSDictionary *dict = [jsonData objectForKey:@"datas"];
            if ([dict objectForKey:@"error"]) {
                [self.view.window makeToast:[dict objectForKey:@"error"] duration:2.0 position:@"center"];
            } else {
                [self.view.window makeToast:@"注册成功" duration:2.0 position:@"center"];
//                转到上个界面
                [self dismissViewControllerAnimated:YES completion:nil];
//                携带创建好的账号密码
                NSDictionary *dic = @{@"UserId":_mobileTxtF.text,@"Psw":_pwdTxtF.text};
                [[NSNotificationCenter defaultCenter]postNotificationName:@"RegestS" object:nil userInfo:dic];
            }
        }
    }];
}

- (void)setUpMenuButton {
//    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftButton.frame = CGRectMake(0, 0, 40, 32);
//    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_button_normal"] forState:UIControlStateNormal];
//    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_button_normal"] forState:UIControlStateHighlighted];
//    [leftButton addTarget:self action:@selector(leftBackAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    self.navigationItem.leftBarButtonItem = leftBar;
// 
//    
}

- (void)leftBackAction:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)isValidateMobile:(NSString *)mobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
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
