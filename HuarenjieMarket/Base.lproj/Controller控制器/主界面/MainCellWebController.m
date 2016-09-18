//
//  MainCellWebController.m
//  HuarenjieMarket
//
//  Created by 赵一 on 16/5/7.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "MainCellWebController.h"

@interface MainCellWebController ()

@end

@implementation MainCellWebController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlstr]];
    [self.MainWebView loadRequest:request];
    
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
