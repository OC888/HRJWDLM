//
//  ApplyZhuBoViewController.m
//  AideoPlayProject
//
//  Created by aaa on 16/6/18.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ApplyZhuBoViewController.h"

@interface ApplyZhuBoViewController ()

@end

@implementation ApplyZhuBoViewController

- (IBAction)sengRequest:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"已发送" message:@"申请已经提交，请耐心等待" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:alertAction1];
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil message:@"该模块尚未开通" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:alertV repeats:NO];
    
//    [alertV show];
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(allocView:) userInfo:nil repeats:NO];
//    [timer fire];
}

//- (void)allocView:(NSTimer *)theTimer {
//    UILabel *viewL = (UILabel *)[theTimer userInfo];
//    viewL = [[UILabel alloc]init];
//    viewL.backgroundColor = [UIColor clearColor];
//    viewL.text = @"该模块尚未开通";
//    viewL.center = self.view.center;
//    viewL.frame =CGRectMake(self.view.frame.origin.x/2 , self.view.frame.origin.y/2, 150, 30);
//    [self.view addSubview:viewL];
//    [self.view addGestureRecognizer:viewL];
//}

//- (void)timerFireMethod:(NSTimer *)theTimer {
//    UIAlertView *alertV = (UIAlertView *)[theTimer userInfo];
//    [alertV dismissWithClickedButtonIndex:0 animated:NO];
//}

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
