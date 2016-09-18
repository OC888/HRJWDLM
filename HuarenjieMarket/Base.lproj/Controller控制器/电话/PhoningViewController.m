//  PhoningViewController.m
//  PhoneCallBack
//  Created by Smartios2012 on 15/8/6.
//  Copyright (c) 2015年 com.hjl. All rights reserved.
#import "PhoningViewController.h"
#import "RequestManager.h"
#import "UIView+Toast.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+Twinkle.h"
@interface PhoningViewController () {
    AVAudioPlayer *avAudioPlayer;
}
@property (nonatomic, strong)UIButton *star;
@property (nonatomic, strong)NSTimer *timer;
@end

@implementation PhoningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(flashs) userInfo:nil repeats:YES];
    [_timer fire];

    _star.backgroundColor = BJCOLOR;
    _star = [[UIButton alloc] init];
    _star.frame = CGRectMake(0, 0, _timeLbl.frame.size.width,_timeLbl.frame.size.height);
    
    //添加通知中心，在程序被打断的时候（电话来的时候）调用方法返回上级界面
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(back) name:@"phoneBreak" object:nil];
    
    [self setUpMenuButton];
    if (self.phone) {
        NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"];
        NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"];
        if (self.name && ![self.name isEqualToString:@""]) {
             self.timeLbl.text = [NSString stringWithFormat:@"%@\n%@",self.name,self.phone];
        } else {
             self.timeLbl.text = self.phone;
            
        }
        if ([self isValidateMobile:userId]) {
            self.userInfo = userId;
        } else {
            self.userInfo = [userInfo objectForKey:@"member_mobile"];
            
        }
        if (!self.userInfo && [self.userInfo isEqualToString:@""]) {
            [self.view.window makeToast:@"用户手机号码为空，不能打电话" duration:2.0 position:@"center"];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
#pragma mark MP3
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"call.mp3" withExtension:nil];       
        avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        avAudioPlayer.numberOfLoops = -1;
        avAudioPlayer.volume = 1;
        [avAudioPlayer prepareToPlay];
        [avAudioPlayer play];
        
        [[RequestManager shareInstance] call:[userInfo objectForKey:@"member_id"] caller:self.userInfo called:self.phone completion:^(NSDictionary *jsonData) {
            if (jsonData) {
                if ([[jsonData objectForKey:@"type"] isEqualToString:@"success"]) {
                    [self.view.window makeToast:@"回拨成功" duration:2.0 position:@"center"];
                } else {
                    [self.view.window makeToast:[jsonData objectForKey:@"msg"] duration:2.0 position:@"center"];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }];
    }
}

- (void)btnAction:(UIButton *)sender {
    [avAudioPlayer stop];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)setUpMenuButton {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];     
    leftButton.frame = CGRectMake(0, 0, 40, 32);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_button_normal"] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_button_normal"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftBackAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBar;
    
}

- (void)leftBackAction:(id)sender {
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)flashs {
    [_timeLbl addSubview:_star];
    [_star twinkle];
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
-(void)back {
    [avAudioPlayer stop];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc {[_timer invalidate];}



@end
