//
//  ModuleTableViewController.m
//  HuarenjieMarket
//
//  Created by 赵一 on 16/8/12.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//
//#import <MobileCoreServices/MobileCoreServices.h>
//#import <AVFoundation/AVFoundation.h>
#import "MapViewController.h"
#import "CleanViewController.h"
#import "AboutUsViewController.h"
#import "TixianWEBViewController.h"
#import "SegmentViewController.h"
#import "AlreadyExchangeViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ModuleTableViewController.h"
#import "PsesonHeaderView.h"
#import "ErweimasViewController.h"
#import "ModuleViewCell.h"
#import "TuiguangViewController.h"
#import "GoldExchangeViewController.h"
#import "LoginViewController.h"
#import "AdviseViewController.h"
#import "MyNetWorking.h"
#import "PayViewController.h"

@interface ModuleTableViewController ()<UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UIAlertView *baseAlert;
@property(nonatomic,strong)UIAlertView *baseAlert1;
@property(nonatomic,strong)UIAlertView *baseAlert2;

@property (nonatomic, strong)PsesonHeaderView *persV;
@property (nonatomic, strong)NSMutableArray *datasource;
@property (nonatomic, strong)NSMutableArray *datasourceTwo;
@end

@implementation ModuleTableViewController

#pragma mark viewdidload
- (void)viewDidLoad {
    [super viewDidLoad];
    //    获取用户名
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
    
    
   
    //    在主线程里刷新UI
    dispatch_async(dispatch_get_main_queue(), ^{
        _persV.PPhoneLabel.text = userId;
         [self startNetWorking:[NSString stringWithFormat:@"http://zghrj.cn/interface/queryamount.php?regnum=%@",userId]];
        //    开始大区头的网络请求
        
        
    });
    
    //    cell分割线
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,10,0,10)];
    }
    self.navigationController.navigationBar.barTintColor = BJCOLOR;
    
    self.navigationController.navigationBar.translucent = YES;
    
    _datasource = [NSMutableArray arrayWithCapacity:0];
    _datasourceTwo = [NSMutableArray arrayWithCapacity:0];
    
    [_datasource addObjectsFromArray:[NSArray arrayWithObjects:@"我的店铺", @"话费充值",@"提现申请",@"我的订单",@"提交位置",@"意见反馈",@"关于我们",@"其他设置",nil]];
    [_datasourceTwo addObjectsFromArray:[NSArray arrayWithObjects:@"dianpu_01.png",@"phone_01.png",@"tixian_01.png",@"xunni_01.png",@"dizhi_01.png",@"fenxiang_01.png",@"help_01.png",@"shezhi_01.png",nil]];
    
}

#pragma mark 退出账号
- (IBAction)logout:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"退出账号？" message:@"是否需要退出当前账号并进入登录界面" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController presentViewController:alertVC animated:YES completion:nil];
        NSString *doucumentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
        NSString *filePath = [doucumentsPath stringByAppendingPathComponent:@"Villlogin.text"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
        
        LoginViewController *loginV = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
        self.view.window.rootViewController = loginV;
        
        
    }];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
}
#pragma mark 网络请求
-(void)startNetWorking:(id)sender{
    //    开始网络请求
    MyNetWorking *mV = [MyNetWorking CreatObject];
    [mV CreatNetWorkingWithURL:sender Parameter:nil ParserData:^(id data) {
        [self praseData:data];
    }];
}

#pragma mark 数据解析
//小区头上面的
-(void)praseData:(NSDictionary *)sender {
    NSLog(@"小区头sender = %@",sender);
    dispatch_async(dispatch_get_main_queue(), ^{
        _persV.PYUE.text =[NSString stringWithFormat:@"剩余时间:%@分钟",sender[@"Val"]];
        _persV.Pjiezhiriqi.text = [NSString stringWithFormat:@"截止日期至:%@",sender[@"outtime"]];
        _persV.PGold.text = [NSString stringWithFormat:@"金币：%@",sender[@"point"]];
    });
}


#pragma mark - Table view 的

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {return 1;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasource.count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ModuleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personcell" forIndexPath:indexPath];
    cell.Mlabel.text = _datasource[indexPath.row];
    cell.Mimage.image =[UIImage imageNamed:_datasourceTwo[indexPath.row]];
    return cell;
}

#pragma mark didselect代理方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        _baseAlert1 = nil;
        _baseAlert1 = [[UIAlertView alloc]
                      
                      initWithTitle:@"店铺" message:@"对不起，您暂无店铺"
                      
                      delegate:self cancelButtonTitle:nil
                      
                      otherButtonTitles: nil];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector: @selector(performDismiss1:)
         
                                       userInfo:nil repeats:NO];
        
        [_baseAlert1 show];
    }
    if (indexPath.row == 1) {
//        SegmentViewController *Seg = [self.storyboard instantiateViewControllerWithIdentifier:@"Seg"];
//        [self.navigationController presentViewController:Seg animated:YES completion:nil];
        
//        跳转支付页面
        PayViewController *payVC = [[PayViewController alloc]init];
        [self.navigationController pushViewController:payVC animated:YES];
    }
    if (indexPath.row == 2) {
        TixianWEBViewController *tix = [self.storyboard instantiateViewControllerWithIdentifier:@"tixianWeb"];
       NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
        NSString *psw = [[NSUserDefaults standardUserDefaults]objectForKey:@"PSW"];
        NSString *webu = [NSString stringWithFormat:@"http://zghrj.cn/wap/tmpl/member/login_tixian.php?name=%@&pwd=%@",userId,psw];
        [[NSUserDefaults standardUserDefaults]setObject:webu forKey:@"webu"];
        [self.navigationController presentViewController:tix animated:YES completion:nil];
    }
    if (indexPath.row == 3) {
        _baseAlert = nil;
        _baseAlert = [[UIAlertView alloc]
                     
                     initWithTitle:@"订单" message:@"对不起，您暂无订单"
                     
                     delegate:self cancelButtonTitle:nil
                     
                     otherButtonTitles: nil];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector: @selector(performDismiss:)
         
                                       userInfo:nil repeats:NO];
        
        [_baseAlert show];
    }
    if (indexPath.row == 4) {
//        _baseAlert2 = nil;
//        _baseAlert2 = [[UIAlertView alloc]
//                      
//                      initWithTitle:@"地址" message:@"对不起，您没有对应的订单以及地址"
//                      
//                      delegate:self cancelButtonTitle:nil
//                      
//                      otherButtonTitles: nil];
//        
//        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector: @selector(performDismiss2:)
//         
//                                       userInfo:nil repeats:NO];
//        
//        [_baseAlert2 show];
        MapViewController *mapV = [[MapViewController alloc] init];
        [self.navigationController presentViewController:mapV animated:YES completion:nil];
    }
    if (indexPath.row == 5) {
        AdviseViewController *av = [self.storyboard instantiateViewControllerWithIdentifier:@"advise"];
        [self.navigationController presentViewController:av animated:YES completion:nil];
    }
    if (indexPath.row == 6) {
        AboutUsViewController *aV = [self.storyboard instantiateViewControllerWithIdentifier:@"aboutus"];
        [self.navigationController presentViewController:aV animated:YES completion:nil];
    }
}
#pragma mark 提示框自动消失
- (void) performDismiss: (NSTimer *)timer{
    [_baseAlert dismissWithClickedButtonIndex:0 animated:NO];//important
    
    _baseAlert = NULL;
}
- (void) performDismiss1:(NSTimer *)timer{
    [_baseAlert1 dismissWithClickedButtonIndex:0 animated:NO];//important
    _baseAlert1 = NULL;
    
}
- (void) performDismiss2: (NSTimer *)timer{
    [_baseAlert2 dismissWithClickedButtonIndex:0 animated:NO];
    _baseAlert2 = NULL;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return MH/4;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    _persV = [[PsesonHeaderView alloc] init];
    [_persV.Perweima addTarget:self action:@selector(handleActions:) forControlEvents:UIControlEventTouchUpInside];
    _persV.PTuiJianJiangLi.layer.masksToBounds = YES;
    _persV.PTuiJianJiangLi.layer.cornerRadius = 8;
    
//   -------------透明视图添加手势
    UITapGestureRecognizer *tapCV = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToIn:)];
    [_persV.cleanView addGestureRecognizer:tapCV];
    

    
//    金币添加手势
    UITapGestureRecognizer *tapGold = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToGold:)];
    [_persV.PGold addGestureRecognizer:tapGold];
//    推荐奖励添加手势
    UITapGestureRecognizer *tapTuijian = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToTuijian:)];
    [_persV.PTuiJianJiangLi addGestureRecognizer:tapTuijian];
//    推荐已兑换手势
    UITapGestureRecognizer *tapYiduihuan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToYiduihuan:)];
    [_persV.PYiduihuan addGestureRecognizer:tapYiduihuan];
    return _persV;
}
//点击进入新界面修改资料
-(void)tapToIn:(UITapGestureRecognizer *)sender {
    NSLog(@"点击透明大视图");
    CleanViewController *cleanV = [self.storyboard instantiateViewControllerWithIdentifier:@"cleanView"];
    [self.navigationController presentViewController:cleanV animated:YES completion:nil];
}
//已兑换手势执行方法
-(void)tapToYiduihuan:(UITapGestureRecognizer *)sender {
    NSLog(@"点击已兑换手势");
    AlreadyExchangeViewController *AV = [self.storyboard instantiateViewControllerWithIdentifier:@"alreadyexchange"];
    [self.navigationController presentViewController:AV animated:YES completion:nil];

}

//推荐奖励手势执行方法
-(void)tapToTuijian:(UITapGestureRecognizer *)sender {
    TuiguangViewController *tuiJ = [self.storyboard instantiateViewControllerWithIdentifier:@"tuiguang"];
    [self.navigationController presentViewController:tuiJ animated:YES completion:nil];
    NSLog(@"点击推荐奖励手势");
}

//金币手势执行方法
-(void)tapToGold:(UITapGestureRecognizer *)sender {
    NSLog(@"点击金币手势");
    GoldExchangeViewController *goldV = [self.storyboard instantiateViewControllerWithIdentifier:@"goldexchange"];
    [self.navigationController presentViewController:goldV animated:YES completion:nil];

}



-(void)handleActions:(UIButton *)sender {
    ErweimasViewController *erwei = [self.storyboard instantiateViewControllerWithIdentifier:@"gfdsa"];
    [self.navigationController presentViewController:erwei animated:YES completion:nil];
}
//-(void)viewWillAppear:(BOOL)animated {
//    self.navigationController.navigationBarHidden = YES;
//}
//-(void)viewWillDisappear:(BOOL)animated {
//    self.navigationController.navigationBarHidden = NO;
//}
// 判断设备是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
// 相册是否可用
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}
-(void)viewWillAppear:(BOOL)animated {
    dispatch_async(dispatch_get_main_queue(), ^{
        //    查询是否有用户头像
        NSData *UserPhoto = [[NSUserDefaults standardUserDefaults]objectForKey:@"UP"];
        if (UserPhoto) {
            _persV.PImageView.image = [UIImage imageWithData:UserPhoto];
            NSLog(@"UserPhotoIsAlready");
        }else {NSLog(@"未发现头像");}
    });
}

@end
