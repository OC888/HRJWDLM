//
//  CardKeyViewController.m
//  PayObject
//
//  Created by aaa on 16/8/20.
//  Copyright © 2016年 王泉. All rights reserved.
//

#import "CardKeyViewController.h"

@interface CardKeyViewController ()

@end

@implementation CardKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubViews];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)layoutSubViews {
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = BJCOLOR;
    label.text = @"卡密支付";
    label.layer.cornerRadius = 14;
    label.layer.masksToBounds = YES;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;
    label.tag = 120;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActive:)];
    [label addGestureRecognizer:tap];
    [self.view addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(CGSizeMake(100, 50));
    }];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)tapActive:(UITapGestureRecognizer *)sender {
    UILabel *label = [self.view viewWithTag:120];
    label.backgroundColor = [UIColor yellowColor];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提醒" message:@"这是OC方法" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];

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
