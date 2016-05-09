//
//  MainTableViewControllerNew.m
//  PhoneCallBack
//
//  Created by 赵一 on 16/4/23.
//  Copyright © 2016年 com.hjl. All rights reserved.
//
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
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
@interface MainTableViewControllerNew ()<CLLocationManagerDelegate,ZBarReaderDelegate>

@property (nonatomic, strong)CLLocationManager *locationManager;

@property (nonatomic, strong)CLGeocoder *geocoder;

@property (nonatomic, strong)TSLocateView *tsLocation;

@property (nonatomic)BOOL isLocation;//地图选择器

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
- (IBAction)QRCode:(UIBarButtonItem *)sender {
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
//    
//    _imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    
//    _label.text = symbol.data;
//    
    
    //如果扫描成功
    if (symbol.data) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请求" message:@"您确定要打开其它来源的网页吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //调用safari展示
            NSURL* urls = [[ NSURL alloc ] initWithString:symbol.data];
            [[UIApplication sharedApplication ] openURL: urls] ;
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertC addAction:action1];
        [alertC addAction:action2];
        [self presentViewController:alertC animated:YES completion:nil];
    }
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:219 green:80 blue:76 alpha:0.5]];
    // Uncomment the following line to preserve selection between presentations.
    // 定位
    if ([[[UIDevice currentDevice] systemVersion ]doubleValue] > 8.0) {
        //设置定位权限\  仅ios8.0 以上有意义
        [self.locationManager requestAlwaysAuthorization];
        
    }
    [self.locationManager startUpdatingLocation];
    
    self.isLocation = NO;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        MainCustomView *mainViewC = [[MainCustomView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight *0.35)];
        mainViewC.backgroundColor = [UIColor whiteColor];


        NSArray *imarr = [NSArray arrayWithObjects:@"http://zghrj.cn/data/upload/mobile/special/s0/s0_05112865774229021.png",@"http://zghrj.cn/data/upload/mobile/special/s0/s0_05129176853556915.png",@"http://zghrj.cn/data/upload/mobile/special/s0/s0_05129193963334291.png", nil];
        
        
        CGFloat wid = MainScreenHeight * 0.35;
        
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
            
    }
        
        return mainViewC;
    }
    return nil;
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

- (IBAction)locationAction:(id)sender {
    
    if (self.isLocation == NO) {
        self.tsLocation = [[TSLocateView alloc] initWithTitle:@"定位城市" delegate:self];
        
         [ self.tsLocation showInView:self.view];
        __weak MainTableViewControllerNew *mainView = self;
        [self.tsLocation setBlock:^(NSString *string) {
            mainView.LocationItem.title = string;
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
            CLPlacemark *firstPlacemark = [placemarks firstObject];
                
            NSString *cityName = firstPlacemark.name;
               
            self.LocationItem.title = [cityName  substringWithRange:NSMakeRange(5, 3)];
                
            }
        }];
    }
    [self.locationManager stopUpdatingLocation];
    
}

#pragma mark  主界面5个按钮点击事件
- (void)homeBtnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 100:{

        ShopCollectionViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"shopView"];
        [self presentViewController:vc animated:YES completion:nil];
        
        }
            break;
            
            case 101:
            NSLog(@"222");
            break;
            
            case 102:
            NSLog(@"333");
            break;
            
            case 103:
            NSLog(@"444");
            break;
            
            case 104:
            NSLog(@"555");
            break;
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
      return MainScreenHeight *0.35;
       
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
