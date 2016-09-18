//
//  AdviseViewController.m
//  HuarenjieMarket
//
//  Created by l x on 16/8/20.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "AdviseViewController.h"

@interface AdviseViewController ()

@end

@implementation AdviseViewController
- (IBAction)backss:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)ddfdfs:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提交成功" message:@"谢谢您的建议，请耐心等待客服给您回复" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:act1];
    [self.navigationController presentViewController:alert animated:YES completion:nil];

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = BJCOLOR;
    self.navigationController.navigationBar.translucent = YES;
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
