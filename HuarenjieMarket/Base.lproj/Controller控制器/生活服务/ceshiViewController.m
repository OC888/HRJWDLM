//
//  ceshiViewController.m
//  temp
//
//  Created by l x on 16/5/27.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ceshiViewController.h"

@interface ceshiViewController ()<UIWebViewDelegate>
{
    UIWebView *webView;
    UIView *bgView;
    UIImageView *imageView;
}
@end

@implementation ceshiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNav];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0]};
    webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.view addSubview:webView];
    webView.scrollView.bounces=NO;
    //webView.delegate=self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];

}
-(void)creatNav{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
-(void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
//    
//    //调整字号
//    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '95%'";
//    [webView stringByEvaluatingJavaScriptFromString:str];
//    
//    //js方法遍历图片添加点击事件 返回图片个数
//    static  NSString * const jsGetImages =
//    @"function getImages(){\
//    var objs = document.getElementsByTagName(\"img\");\
//    for(var i=0;i<objs.length;i++){\
//    objs[i].onclick=function(){\
//    document.location=\"myweb:imageClick:\"+this.src;\
//    };\
//    };\
//    return objs.length;\
//    };";
//    
//    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
//    
//    //注入自定义的js方法后别忘了调用 否则不会生效（不调用也一样生效了，，，不明白）
//    NSString *resurlt = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
//    //调用js方法
//    //    NSLog(@"---调用js方法--%@  %s  jsMehtods_result = %@",self.class,__func__,resurlt);
//}
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    //将url转换为string
//    NSString *requestString = [[request URL] absoluteString];
//    //    NSLog(@"requestString is %@",requestString);
//    
//    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
//    if ([requestString hasPrefix:@"myweb:imageClick:"]) {
//        NSString *imageUrl = [requestString substringFromIndex:@"myweb:imageClick:".length];
//        //        NSLog(@"image url------%@", imageUrl);
//        
//        if (bgView) {
//            //设置不隐藏，还原放大缩小，显示图片
//            bgView.hidden = NO;
//            imageView.frame = CGRectMake(10, 10, WIDTH-40, 220);
//            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"imageView"]];
//        }
//        else
//            [self showBigImage:imageUrl];//创建视图并显示图片
//        
//        return NO;
//    }
//    return YES;
//}
//
//
//#pragma mark 显示大图片
//-(void)showBigImage:(NSString *)imageUrl{
//    //创建灰色透明背景，使其背后内容不可操作
//    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
//    [bgView setBackgroundColor:[UIColor colorWithRed:0.3
//                                               green:0.3
//                                                blue:0.3
//                                               alpha:0.7]];
//    [self.view addSubview:bgView];
//    
//    //创建边框视图
//    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH-20, 240)];
//    //将图层的边框设置为圆脚
//    borderView.layer.cornerRadius = 8;
//    borderView.layer.masksToBounds = YES;
//    //给图层添加一个有色边框
//    borderView.layer.borderWidth = 8;
//    borderView.layer.borderColor = [[UIColor colorWithRed:0.9
//                                                    green:0.9
//                                                     blue:0.9
//                                                    alpha:0.7] CGColor];
//    [borderView setCenter:bgView.center];
//    [bgView addSubview:borderView];
//    
//    //创建关闭按钮
//    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    [closeBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
//    closeBtn.backgroundColor = [UIColor redColor];
//    [closeBtn addTarget:self action:@selector(removeBigImage) forControlEvents:UIControlEventTouchUpInside];
//    [closeBtn setFrame:CGRectMake(borderView.frame.origin.x+borderView.frame.size.width-20, borderView.frame.origin.y-6, 26, 27)];
//    [bgView addSubview:closeBtn];
//    
//    //创建显示图像视图
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(borderView.frame)-20, CGRectGetHeight(borderView.frame)-20)];
//    imgView.userInteractionEnabled = YES;
//    [imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"house_moren"]];
//    [borderView addSubview:imgView];
//    
//    //添加捏合手势
//    [imgView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)]];
//    
//}
//
////关闭按钮
//-(void)removeBigImage
//{
//    bgView.hidden = YES;
//}
//
//- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
//{
//    //缩放:设置缩放比例
//    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
//    recognizer.scale = 1;
//}
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
