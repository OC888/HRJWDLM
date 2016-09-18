//
//  MainTableViewControllerNew.m
//  PhoneCallBack
//
//  Created by 赵一 on 16/4/23.
//  Copyright © 2016年 com.hjl. All rights reserved.
//
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
#import "DetailViewController.h"
#import "MyNetWorking.h"
#import "MainTableViewControllerNew.h"
#import "MainCustomView.h"
#import "SDCycleScrollView.h"
#import <CoreLocation/CoreLocation.h>
#import "TSLocateView.h"
#import "ShopCollectionViewController.h"
#import "MainQDViewCell.h"
#import "MainCellWebController.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define URL @"www.baidu.com"
#import "JianjieViewController.h"
#import "ViewController.h"
#import "WeatherView.h"
#import "AFNetworking.h"
#import "WeatherModel.h"
#import "WalViewController.h"
#import "H5ViewController.h"
#import "AllianceOfShopsViewController.h"
@interface MainTableViewControllerNew ()<CLLocationManagerDelegate,ZBarReaderDelegate>

@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic)int tempH;
@property (nonatomic, strong)CLGeocoder *geocoder;
@property (nonatomic, strong)NSDictionary *dicc;
@property (nonatomic, strong)TSLocateView *tsLocation;
@property (nonatomic, strong)WeatherView *wV;
@property (nonatomic)BOOL isLocation;//地图选择器
@property (nonatomic, strong)UIButton *leftbutton;
@property (nonatomic, strong)UIButton *rightButton;

@end

@implementation MainTableViewControllerNew

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
    }
    return _locationManager;
}

- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
        
    }
    return _geocoder;
}

//点击按钮，扫码
- (void)saomaAction {
    ZBarReaderViewController * reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    ZBarImageScanner * scanner = reader.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    
    reader.showsZBarControls = YES;
    
    [self presentViewController:reader animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainCellWebController *maincell = [[MainCellWebController alloc] init];
    NSLog(@"url = %@",URL);
    maincell.urlstr = URL;
    [self.navigationController pushViewController:maincell animated:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol * symbol;
    for(symbol in results)
        break;
    
    //    _imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //    [picker dismissViewControllerAnimated:YES completion:nil];
    //    _label.text = symbol.data;
    
    
    //如果扫描成功
    if (symbol.data) {
//        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请求" message:@"您确定要打开其它来源的网页吗？" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//            //调用safari展示
//            NSURL* urls = [[ NSURL alloc ] initWithString:symbol.data];
//            [[UIApplication sharedApplication ] openURL: urls] ;
//            
//        }];
//        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        [alertC addAction:action1];
//        [alertC addAction:action2];
//        [self presentViewController:alertC animated:YES completion:nil];
        NSURL* urls = [[ NSURL alloc ] initWithString:symbol.data];
        [[UIApplication sharedApplication ] openURL: urls] ;
    }
}

#pragma mark viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:BJCOLOR];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"华人街";
    
   // 定位按钮
    self.leftbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftbutton.bounds=CGRectMake(0, 0, 50, 40);
   
    [self.leftbutton addTarget:self action:@selector(dingweiAction) forControlEvents:UIControlEventTouchUpInside];
    [self.leftbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:self.leftbutton];
    self.navigationItem.leftBarButtonItem=leftItem;

    // 扫码按钮
    self.rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.bounds=CGRectMake(MainScreenWidth - 50, 0, 50, 40);
    [self.rightButton addTarget:self action:@selector(saomaAction) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setImage:[UIImage imageNamed:@"saomaclear"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    
    self.navigationItem.titleView = titleLabel;
    // 定位
    if ([[[UIDevice currentDevice] systemVersion ]doubleValue] > 8.0) {
        //设置定位权限\  仅ios8.0 以上有意义
        [self.locationManager requestAlwaysAuthorization];
        
    }
    [self.locationManager startUpdatingLocation];
    
    self.isLocation = NO;
 
    //  请求天气数据
    [self startWeatherNetworking];

}
#pragma mark 天气数据解析网络请求
//天气网络请求
-(void)startWeatherNetworking {

    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString *urlString=@"http://apicloud.mob.com/v1/weather/query?key=14027d249dbe4&city=通州&province=北京";
   NSString * url = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        [self praseData:arr];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}

    
    

//天气数据解析
-(void)praseData:(id)sender {
    NSArray *result= sender[@"result"];
    NSDictionary *dics = result[0];
    NSArray *arr = dics[@"future"];
    _dicc = arr[0];

   NSString *day = _dicc[@"dayTime"];
    _wV.num.text =[NSString stringWithFormat:@"白天:%@",day];
    
    _wV.numNight.text = [ NSString stringWithFormat:@"夜晚:%@",_dicc[@"night"]];

    _wV.highAndLow.text = _dicc[@"temperature"];
    
    _wV.wind.text = _dicc[@"wind"];
    _wV.todatData.text = dics[@"date"];
    _wV.air.text = [NSString stringWithFormat:@"空气质量:%@",dics[@"airCondition"]];
    
//    WeatherModel *model = [[WeatherModel alloc] init];
//    [model setValuesForKeysWithDictionary:dicc];
//    [_dataSource addObject:model];
}

#pragma mark - Table view data source
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
        MainCustomView *mainViewC = [[MainCustomView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,  MainScreenHeight * 0.41)];
        
        mainViewC.backgroundColor = [UIColor whiteColor];
        
        NSArray *imarr = [NSArray arrayWithObjects:@"http://zghrj.cn/data/upload/mobile/special/s0/s0_05112865774229021.png",@"http://zghrj.cn/data/upload/mobile/special/s0/s0_05129176853556915.png",@"http://zghrj.cn/data/upload/mobile/special/s0/s0_05129193963334291.png", nil];
        
        
        CGFloat wid = MainScreenHeight * 0.30;
        
        SDCycleScrollView *sdcURL = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MainScreenWidth, wid - Width / 5)  imageURLStringsGroup:imarr];
        
        [mainViewC addSubview:sdcURL];
        
        // 主页五个小图标、标题
        for (int i = 0; i < 5; i ++) {
            UIButton *btnHome = [[UIButton alloc]initWithFrame:CGRectMake(i * Width / 5, wid - Width / 5, Width / 5, Width / 5)];
            
            btnHome.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"home%d",i]];
            [btnHome setImage:[UIImage imageNamed:[NSString stringWithFormat:@"home%d",i]] forState:UIControlStateNormal];
            btnHome.tag = 100+ i;
            [btnHome addTarget:nil action:@selector(homeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [mainViewC addSubview:btnHome];
        //天气页面
            //创建天气页面底部视图
//            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, sdcURL.bounds.size.height + btnHome.bounds.size.height, self.view.bounds.size.width, btnHome.frame.size.height)];
//
//            view.backgroundColor  = [UIColor lightGrayColor];
            
        //创建现在气温label
            
            _wV = [[WeatherView alloc]init];
            _wV.frame = CGRectMake(0, sdcURL.frame.size.height + btnHome.frame.size.height, self.view.frame.size.width, btnHome.frame.size.height);
            UIImageView *imaV = [[UIImageView alloc] initWithFrame:_wV.frame];
            imaV.image = [UIImage imageNamed:@"detail.jpg"];
            [mainViewC addSubview:imaV];
            
            
            UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weather)];
            [_wV addGestureRecognizer:tapG];

            [mainViewC addSubview:_wV];
        }
        
        return mainViewC;
        
    }
    return nil;
}

#pragma mark 天气模块添加手势
-(void)weather {
    DetailViewController *DCV = [self.storyboard instantiateViewControllerWithIdentifier:@"weatherTableView"];
    [self.navigationController presentViewController:DCV animated:YES completion:nil];
}

#pragma mark 城市选择器的两个按钮

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TSLocateView *locateView = (TSLocateView *)actionSheet;
    TSLocation *location = locateView.locate;
    NSLog(@"city:%@ lat:%f lon:%f", location.city, location.latitude, location.longitude);
    
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }
    else {
        NSLog(@"Select");
    }
}

- (void)dingweiAction {
    
    if (self.isLocation == NO) {
        self.tsLocation = [[TSLocateView alloc] initWithTitle:@"定位城市" delegate:self];
        
        [ self.tsLocation showInView:self.view];
        __weak MainTableViewControllerNew *mainView = self;
        [self.tsLocation setBlock:^(NSString *string) {
           [mainView.leftbutton setTitle: string forState:UIControlStateNormal];
        }];
        self.isLocation = YES;
    }
    else {
        [self.tsLocation removeFromSuperview];
        self.isLocation = NO;
    }
    
}

#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    CLLocation *cl = [locations objectAtIndex:0];
    NSLog(@"精度 ----- %f,维度 ----- %f",cl.coordinate.latitude, cl.coordinate.longitude);
    
    // 编码失败
    if (cl.coordinate.latitude == 0||cl.coordinate.longitude == 0) {
        
        return;
    }else // 编码成功
    {
        CLLocation *location = [[CLLocation alloc]initWithLatitude:cl.coordinate.latitude longitude:cl.coordinate.longitude];
        
        //反地理编码
        [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error || placemarks.count == 0) {
                NSLog(@"你输入的地址没找到");
            }
            else {
                for (CLPlacemark *placeMark in placemarks) {
                    NSDictionary *test =[placeMark addressDictionary];
                    NSString *cityName = [[test objectForKey:@"City"] substringToIndex:[[test objectForKey:@"City"] length] - 1];
                    
                    [self.leftbutton setTitle:cityName forState:UIControlStateNormal];
                }
               
            }
        }];
    }
    [self.locationManager stopUpdatingLocation];
}

#pragma mark  主界面5个按钮点击事件
- (void)homeBtnAction:(UIButton *)sender {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"该功能暂未开通,敬请期待" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [alertC addAction: alertA];
    switch (sender.tag) {
        case 100:{
//            跳转万店联盟界面
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            layout.itemSize = CGSizeMake((WIDTH - 60)/ 2, 84);
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 20;
        
            AllianceOfShopsViewController *vc = [[AllianceOfShopsViewController alloc]initWithCollectionViewLayout:layout];
            
//            ShopCollectionViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"shopView"];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        case 101:
        {
         ViewController *VCC = [[ViewController alloc] init];
            [self.navigationController pushViewController:VCC animated:YES];
        }
            break;
    
        case 102:
        {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
            WalViewController *WalVC = [story instantiateViewControllerWithIdentifier:@"SecondStoryboard"];
            [self.navigationController presentViewController:WalVC animated:YES completion:nil];
        }
            break;
            
        case 103:
        {
            [self presentViewController:alertC animated:YES completion:nil];
        }
            break;
            
        case 104:
        {
        H5ViewController  * jianV = [[H5ViewController alloc] init];
            [self.navigationController 
             pushViewController:jianV animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0)
    {
        return MainScreenHeight * 0.41;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
    
        MainQDViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        
        cell.QDImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"lv%ld.jpg",(long)indexPath.row +1]];
        
        return cell;
        
    }
    if (indexPath.section == 1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}


@end
