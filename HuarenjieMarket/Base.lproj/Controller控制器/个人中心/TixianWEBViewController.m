//
//  TixianWEBViewController.m
//  HuarenjieMarket
//
//  Created by l x on 16/8/22.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "TixianWEBViewController.h"

@interface TixianWEBViewController ()

@end

@implementation TixianWEBViewController
- (IBAction)backss:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = BJCOLOR;
    self.navigationController.navigationBar.translucent = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWebView *web=  [[UIWebView alloc] initWithFrame:self.view.frame];
        NSString *uer =  [[NSUserDefaults standardUserDefaults]objectForKey:@"webu"];
        
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:uer]]];
        
        [self.view addSubview:web];
    });
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
