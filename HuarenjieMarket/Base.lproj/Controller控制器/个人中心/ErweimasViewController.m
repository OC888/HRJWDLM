//
//  ErweimasViewController.m
//  HuarenjieMarket
//
//  Created by 赵一 on 16/8/13.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "ErweimasViewController.h"
#import "MyNetWorking.h"

@interface ErweimasViewController ()
@property(copy,nonatomic)NSString *DLSurl;
@property(copy,nonatomic)NSString *res3;
@end

@implementation ErweimasViewController
- (IBAction)backb:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = BJCOLOR ;
    self.navigationController.navigationBar.translucent = YES;
    
    [self startNetWorking];
}
//开始网络请求，是否是代理
-(void)startNetWorking {
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"];
   _DLSurl = [NSString stringWithFormat:@"http://zghrj.cn/interface/agent_check.php?name=%@",userid];
    MyNetWorking *myN = [MyNetWorking CreatObject];
    [myN CreatNetWorkingWithURL:_DLSurl Parameter:nil ParserData:^(id data) {
        [self parsedata:data];
    }];
}
-(void)startNetWorking2 {
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"];
    NSString *urlss = [NSString stringWithFormat:@"http://zghrj.cn/interface/get_member_id.php?name=%@",userid];
    
    MyNetWorking *myN = [MyNetWorking CreatObject];
    
    [myN CreatNetWorkingWithURL:urlss Parameter:nil ParserData:^(id data) {
        
        [self parsedata2:data];
    }];
    
}
-(void)parsedata2:(NSDictionary *)sender {
    NSString *res = sender[@"result"];
    if ([res isEqualToString:@"success"]) {
        NSString *res2 = sender[@"member_id"];
        _res3 = [NSString stringWithFormat:@"http://zghrj.cn/wap/tmpl/member/enroll.php?from_id=%@",res2];
        NSLog(@"finalyUrl = %@",_res3);
        dispatch_async(dispatch_get_main_queue(), ^{
            //创建过滤器
            CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
            //恢复默认设置
            [filter setDefaults];
            //给过滤器添加数据
            
            NSData * data = [_res3 dataUsingEncoding:NSUTF8StringEncoding];
            [filter setValue:data forKey:@"inputMessage"];
            //输出获取的二维码
            CIImage * image = [filter outputImage];
            //CIImage转换成UIImage
            _shareEWMImageView.image = [self createNonInterpolatedUIImageFormCIImage:image withSize:200];
        });
    }
}
//数据解析是否是代理
-(void)parsedata:(NSDictionary *)sender {
    NSString *str = sender[@"result"];
    NSString *str1 = sender[@"check"];
    NSLog(@"result = %@,check = %@",str,str1);
    if ([str isEqualToString:@"success"]&&[str1 isEqualToString:@"true"]) {
        [self startNetWorking2];
       
//            是代理的话开始根据用户名即手机号获取member_id
            
        
        
    }else {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"二维码生成错误" message:@"请检查您是否是代理商/网络是否通畅" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVC addAction:action1];
        
        [self.navigationController presentViewController:alertVC animated:YES completion:nil];
    }
}
//锐化图片效果
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
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
