//
//  PayResultController.m
//  PayObject
//
//  Created by aaa on 16/8/24.
//  Copyright © 2016年 王泉. All rights reserved.
//

#import "PayResultController.h"

@interface PayResultController ()
@property (weak, nonatomic) IBOutlet UILabel *payNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *PayResultLabel;

@end

@implementation PayResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.payNumLabel.text = self.payNum;
    self.moneyLabel.text = self.money;
    self.PayResultLabel.text = self.result;
    
}
//返回充值页面按钮方法
- (IBAction)backPayView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
