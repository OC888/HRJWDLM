//
//  SearchViewController.m
//  HuarenjieMarket
//
//  Created by 赵一 on 16/5/10.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//
#define HalfURL @"http://zghrj.cn/wap/tmpl/product_list.html?keyword="
#import "ShopTableViewControllerTow.h"
#import "SearchViewController.h"
#import "SearchWebViewController.h"
@interface SearchViewController ()

@property(nonatomic,copy)NSString *str ;
@property(nonatomic,strong)UITextField * textfield;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//URLEncoding编码
-(NSString *)URLEncodedString:(NSString *)str
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)str,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    //获取到用户输入的文字，调用系统方法，转换成万国码
    NSString * encodingString = [self URLEncodedString:self.searchTextField.text];
    PCLog(@"拼接之前的enc=%@",encodingString);
    _str = [NSString stringWithFormat:@"%@%@",HalfURL,encodingString];
    PCLog(@"拼接好的str=%@",_str);
    SearchWebViewController *searchWeb = [segue destinationViewController];
    
    searchWeb.URLStr = _str;
    
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

@end
