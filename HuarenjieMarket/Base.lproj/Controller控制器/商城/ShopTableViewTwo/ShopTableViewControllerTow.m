//
//  ShopTableViewControllerTow.m
//  shangchengDemo
//
//  Created by apple on 16/5/5.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "ShopTableViewControllerTow.h"
#import "SDCycleScrollView.h"
#import "General.h"
#import "ShopTableViewCell.h"
#import "ScrollTableViewCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "goodModel.h"
#import "UIImageView+WebCache.h"
#import "ShopWebViewController.h"
#define url(A) [NSString stringWithFormat:@"http://zghrj.cn/mobile/index.php?act=goods&op=goods_list&key=4&page=10&curpage=1&gc_id=%d",A]

@interface ShopTableViewControllerTow ()

@property (nonatomic, strong)UIButton *btn;
@property (nonatomic, strong)NSMutableArray *goodArr;
@property (nonatomic, strong)NSMutableArray *priseArr;

@end

@implementation ShopTableViewControllerTow

- (NSMutableArray *)urlArr {
    if (!_urlArr) {
        self.urlArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _urlArr;
}

- (NSMutableArray *)priseArr {
    if (!_priseArr) {
        self.priseArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _priseArr;
}

+ (goodModel *)initWithName:(NSString *)prise {
    goodModel *goodM = [[goodModel alloc]init];
    goodM.goods_price = prise;
    return goodM;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.goodArr = [NSMutableArray array ];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
   
    //添加轮播图
    SDCycleScrollView *sdCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, 150) shouldInfiniteLoop:YES imageNamesGroup:[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"1"],[UIImage imageNamed:@"12"],[UIImage imageNamed:@"13"], nil]];
    
    self.tableView.tableHeaderView = sdCycle;
    
    for (int i = 0; i < self.urlArr.count; i ++) {
        int A = [[self.urlArr objectAtIndex:i]intValue];
        [self requestURL:A];

    };

}

#define mark ----------网络请求
- (void)requestURL:(int)A {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    __weak ShopTableViewControllerTow *shopTwo = self;
    [manager GET:url(A) parameters:self success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [shopTwo startParseJSONData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}







//数组数据解析
- (void)startParseJSONData:(NSMutableDictionary *)responseObject {
    NSMutableDictionary *dataDic = responseObject[@"datas"];
    NSMutableArray *listArr = dataDic[@"goods_list"];
    for (NSMutableDictionary *tempDic in listArr) {
        goodModel *goodM = [[goodModel alloc]init];
        [goodM setValuesForKeysWithDictionary:tempDic];
        [self.goodArr addObject:goodM];
        NSLog(@"%ld",self.goodArr.count);
    }
   
    [self.tableView reloadData];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
//    if (section ==0) {
//        return 1;
//    }
    return self.goodArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        ScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
//        
//        //创建button
//        
//    for (int i = 0; i<8 ; i++) {
//        if (i < 4) {
//            self.btn = [[UIButton alloc]initWithFrame:CGRectMake(i * ScreenW / 4, 0, ScreenW / 4, ScreenW / 4)];
//            self.btn.tag = 100 + i;
//            [self.btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"s%d.jpg",i+1]] forState:UIControlStateNormal];
//               
//            [cell.contentView addSubview:self.btn];
//            }
//        else {
//            self.btn = [[UIButton alloc]initWithFrame:CGRectMake((i - 4) * ScreenW / 4, ScreenW / 4, ScreenW / 4, ScreenW / 4)];
//            self.btn.tag = 100 + i;
//            [self.btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"s%d.jpg",i - 3]] forState:UIControlStateNormal];
//                
//            [cell.contentView addSubview:self.btn];
//            }
//        
//            [self.btn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
//            
//        }
//        
//        return cell;
//    }
//    if (_urls) {
//        ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
//        goodModel *goodM = _dataSource[indexPath.row];
//        [self.priseArr addObject:goodM.goods_price];
//        [cell show:goodM];
//        return cell;
//    }
    ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    goodModel *goodM = self.goodArr[indexPath.row];
    [self.priseArr addObject:goodM.goods_price];
    cell.shopOld.text = [NSString stringWithFormat:@"门市价%u",[goodM.goods_price intValue] + 58];
    cell.shopLocal.text = [NSString stringWithFormat:@"<%u米",(arc4random() % 1000) + 200];
    cell.shopDetail.text = @"20元抵用券一张";
    [cell show:goodM];
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
      //  return ScreenW / 2 ;
        return  0;
    }
    else {
    return 110;
 }
}

//btn 的点击事件
-(void)handleAction:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
            NSLog(@"点击第一个按钮");
            break;
        case 101:
            NSLog(@"点击第二个按钮");
            break;
        case 102:
            NSLog(@"点击第三个按钮");
            break;
        case 103:
            NSLog(@"点击第四个按钮");
            break;
        case 104:
            NSLog(@"点击第五个按钮");
            break;
        case 105:
            NSLog(@"点击第六个按钮");
            break;
        case 106:
            NSLog(@"点击第七个按钮");
            break;
        case 107:
            NSLog(@"点击第八个按钮");
            break;
            
        default:
            break;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        //创建底层view
        UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
        views.backgroundColor = [UIColor whiteColor];
        //创建button
 
        for (int i = 0; i<4; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * ScreenW / 4, 0, ScreenW / 4, 40)];
            
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-01",i+1]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(handleAB:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTag:301 + i];
            
            [views addSubview:btn];
        
        }
        return views;
    }
    return nil;
}

-(void)handleAB:(UIButton *)sender {
    switch (sender.tag) {
        case 301:{
            
            NSLog(@"(((((((((%@",self.goodArr);
    //        [self.goodArr sortedArrayUsingSelector:@selector(compareGood:)];
            NSLog(@"*********%@",self.goodArr);
//          [self.tableView reloadData];
        }
            break;
        case 302:
            NSLog(@"排序2");
            break;
        case 303:
            NSLog(@"排序3");
            break;
        case 304:
            NSLog(@"排序4");
            break;
            
        default:
            break;
  
    }
}

#pragma mark  -----价格比较
- (NSComparisonResult)compareGood:(goodModel *)goodM {
   
    NSComparisonResult result = [[NSNumber numberWithInt: [goodM.goods_price intValue]] compare:[NSNumber numberWithInt:[goodM.goods_price intValue]]];
    
    return result;
}

////自定义排序方法
//-(NSComparisonResult)comparePerson:(Person *)person{
//    //默认按年龄排序
//    NSComparisonResult result = [[NSNumber numberWithInt:person.age] compare:[NSNumber numberWithInt:self.age]];//注意:基本数据类型要进行数据转换
//    //如果年龄一样，就按照名字排序
//    if (result == NSOrderedSame) {
//        result = [self.name compare:person.name];
//    }
//    return result;
//}


// 返回区头尺寸
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 40;
    }
    return 0;
}


//点击返回上一层
- (IBAction)backAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

    if ([segue.identifier isEqualToString:@"TwoToWab"]) {
        ShopWebViewController *shopWeb = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath.section == 1) {
            goodModel *goodM = self.goodArr[indexPath.row];
            shopWeb.good_ID = goodM.goods_id;
        }
    }
    
    
}


@end
