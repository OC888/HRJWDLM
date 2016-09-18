//
//  SearchWebViewController.m
//  HuarenjieMarket
//
//  Created by 赵一 on 16/5/10.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "SearchWebViewController.h"

@interface SearchWebViewController ()

@end

@implementation SearchWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchWeb.backgroundColor = [UIColor whiteColor];
    
    [self.searchWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URLStr]]];
    
    
    
//    self.view.backgroundColor = [UIColor blackColor];
//    self.searchWeb.backgroundColor = [UIColor yellowColor];
//    self.searchWeb.scrollView.backgroundColor= [UIColor cyanColor];
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
