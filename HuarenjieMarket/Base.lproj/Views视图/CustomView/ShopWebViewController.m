//
//  ShopWebViewController.m
//  HuarenjieMarket
//
//  Created by apple on 16/5/7.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "ShopWebViewController.h"

@interface ShopWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *shopWeb;

@end

@implementation ShopWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.shopWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://zghrj.cn/wap/tmpl/product_detail.html?goods_id=%@",self.good_ID]]]];

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
