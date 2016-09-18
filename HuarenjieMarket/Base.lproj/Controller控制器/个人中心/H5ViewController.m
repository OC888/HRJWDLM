//
//  H5ViewController.m
//  HuarenjieMarket
//
//  Created by 赵一 on 16/6/22.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "H5ViewController.h"

@interface H5ViewController ()

@end

@implementation H5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webV = [[UIWebView alloc] initWithFrame:self.view.frame];
    [webV loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://e.eqxiu.com/s/5GmgtFUV"]]];
    [self.view addSubview:webV];

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
