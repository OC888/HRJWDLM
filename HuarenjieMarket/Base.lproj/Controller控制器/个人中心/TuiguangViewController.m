//
//  TuiguangViewController.m
//  HuarenjieMarket
//
//  Created by l x on 16/8/18.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "TuiguangViewController.h"
#import "MyNetWorking.h"
@interface TuiguangViewController ()

@end

@implementation TuiguangViewController
//开始网络请求，是否是代理
-(void)startNetWorkings {
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"];
   NSString * _DLSurl = [NSString stringWithFormat:@"http://zghrj.cn/interface/agent_check.php?name=%@",userid];
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
      NSString *  _res3 = [NSString stringWithFormat:@"http://zghrj.cn/wap/tmpl/member/enroll.php?from_id=%@",res2];
        NSLog(@"finalyUrl = %@",_res3);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray* imageArray = @[[UIImage imageNamed:@"aapp.png"]];
            //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
            if (imageArray) {
                
                NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
                [shareParams SSDKSetupShareParamsByText:@"充百元话费送流量，成就百万梦想！"

                                                 images:imageArray
                                                    url:[NSURL URLWithString:_res3]
                                                  title:@"华人街"
                                                   type:SSDKContentTypeAuto];
                //2、分享（可以弹出我们的分享菜单和编辑界面）
                [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                         items:nil
                                   shareParams:shareParams
                           onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                               
                               switch (state) {
                                   case SSDKResponseStateSuccess:
                                   {
                                       UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                           message:nil
                                                                                          delegate:nil
                                                                                 cancelButtonTitle:@"确定"
                                                                                 otherButtonTitles:nil];
                                       [alertView show];
                                       break;
                                   }
                                   case SSDKResponseStateFail:
                                   {
                                       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                       message:[NSString stringWithFormat:@"%@",error]
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"OK"
                                                                             otherButtonTitles:nil, nil];
                                       [alert show];
                                       break;
                                   }
                                   default:
                                       break;
                               }
                           }
                 ];}
        });
//        才可以分享
        

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
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"只有代理商允许分享" message:@"充值100元以上即可具备三级分销能力" preferredStyle:UIAlertControllerStyleAlert];
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

- (IBAction)backss:(id)sender {[self.navigationController dismissViewControllerAnimated:YES completion:nil];}

- (IBAction)shares:(id)sender {
    [self startNetWorkings];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetworking];
    self.navigationController.navigationBar.barTintColor = BJCOLOR;
    
    
}

-(void)startNetworking {
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"];
    MyNetWorking *mN = [MyNetWorking CreatObject];
    NSString *urls1 = [NSString stringWithFormat:@"http://zghrj.cn/interface/center_tuiguang.php?name=%@",userid];
    NSString *urls2 = [NSString stringWithFormat:@"http://zghrj.cn/interface/center_paynumber.php?name=%@",userid];
    
        [mN CreatNetWorkingWithURL:urls1 Parameter:nil ParserData:^(id data) {
            [self prasedata:data];
        }];
        [mN CreatNetWorkingWithURL:urls2 Parameter:nil ParserData:^(id data) {
            [self prasedata2:data];
        }];
    
}

-(void)prasedata:(NSDictionary *)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
      NSString *str1 = sender[@"one"];
    NSString *str2 = sender[@"two"];
    NSString *str3 = sender[@"three"];
    _j1.text = str1;
    _j2.text = str2;
    _j3.text = str3;  
    });
    

    
}
-(void)prasedata2:(NSDictionary *)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
       NSString *str1 = sender[@"one"];
    NSString *str2 = sender[@"two"];
    NSString *str3 = sender[@"three"];
    _c1.text = str1;
    _c2.text = str2;
    _c3.text = str3;  
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
