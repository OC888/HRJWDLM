//
//  DetailViewController.m
//  HuarenjieMarket
//
//  Created by 赵一 on 16/6/18.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailViewCell.h"
#import "MyNetWorking.h"
#import "AFNetworking.h"
#import "WeatherView.h"
#import "WeatherModel.h"
@interface DetailViewController ()
@property (nonatomic, strong)NSMutableArray *datasource;
@end

@implementation DetailViewController
-(NSMutableArray *)datasource {
    if (!_datasource) {
        self.datasource = [NSMutableArray  arrayWithCapacity:0];
    }
    return _datasource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startWeatherNetworking];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - 数据解析展示
-(void)startWeatherNetworking {
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString *urlString=@"http://apicloud.mob.com/v1/weather/query?key=14027d249dbe4&city=郑州&province=河南";
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
    for (NSDictionary *dic in arr) {
        WeatherModel *model = [[WeatherModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_datasource addObject:model];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (_datasource) {
        WeatherModel *model = self.datasource[indexPath.row];
        cell.rWind.text = model.wind;
        cell.rDate.text = model.date;
        cell.rLAH.text = model.temperature;
        cell.rD.text = model.dayTime;
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 103;
}
- (IBAction)backtopop:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
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

@end
