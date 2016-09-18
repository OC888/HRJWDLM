//
//  UUViewController.m
//  HuarenjieMarket
//
//  Created by 赵一 on 16/6/14.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "UUViewController.h"

@interface UUViewController ()

@end

@implementation UUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = BJCOLOR;
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"敬请期待" message:@"UU聊天正在内测中，下个版本闪亮推出✨" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:action1];
    
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
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
