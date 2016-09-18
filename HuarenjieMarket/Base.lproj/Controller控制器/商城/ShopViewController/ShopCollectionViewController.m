//
//  ShopCollectionViewController.m
//  shangchengDemo
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "ShopCollectionViewController.h"
#import "ShopCollectionViewCell1.h"
#import "ShopCollectionViewCell2.h"
#import "ShopCollectionReusableView.h"
#import "ShopCollectionReusableViewFoot.h"
#import "SDCycleScrollView.h"
#import "AFHTTPRequestOperationManager.h"
#import "goodModel.h"
#import "UIImageView+WebCache.h"
#import "ShopTableViewControllerTow.h"
#import "ShopWebViewController.h"
#import "SearchViewController.h"
#import "SearchWebViewController.h"


#define ScreenW [UIScreen mainScreen].bounds.size.width
#define Space 10
#define url @"http://zghrj.cn/mobile/index.php?act=index&op=special&special_id=5"
#define imageURL(A) [NSString stringWithFormat:@"http://zghrj.cn/admin/control/getlunboygg.php?n=%d",A]


@interface ShopCollectionViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)NSMutableArray *goodArray;
@property (nonatomic, strong)NSMutableArray *homeArray;
@property (nonatomic, strong)NSMutableArray *foodArray;
@property (nonatomic, strong)NSMutableArray *packArray;

@property (nonatomic, strong)NSMutableArray *imageArr;
@property (nonatomic, strong)NSMutableArray *urlArr;

@property (strong, nonatomic) IBOutlet UITextField *textfields;

@property (nonatomic, strong)NSMutableArray *goldArray;
@end

@implementation ShopCollectionViewController

static NSString * const reuseIdentifier = @"Cell";



- (void)viewDidLoad {
    [super viewDidLoad];
    self.goodArray = [NSMutableArray array];
    self.homeArray = [NSMutableArray array];
    self.foodArray = [NSMutableArray array];
    self.packArray = [NSMutableArray array];
    self.goldArray = [NSMutableArray array];
    self.imageArr = [NSMutableArray array];
    self.urlArr = [NSMutableArray array];
    
    _textfields.delegate = self;
    
    
    // 返回按钮
    UIButton *backbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    backbutton.bounds=CGRectMake(0, 0, 50, 40);
    [backbutton setTitle:@"返回" forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(fanhuiAction) forControlEvents:UIControlEventTouchUpInside];
    [backbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:backbutton];
    self.navigationItem.leftBarButtonItem=leftItem;

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self requestURL];
    
    for (int i = 4; i < 7; i ++) {
        [self parseURL:i];
    }
    
}

- (void)fanhuiAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---轮播图
- (void)parseURL:(int)A {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    __weak ShopCollectionViewController *shopVC = self;
    [manager GET:imageURL(A) parameters:self success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [shopVC requestJSON:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
    }];
}
- (void)requestJSON:(NSMutableDictionary *)responseObject {
    [self.imageArr addObject:responseObject[@"imglink"]];
    
    [self.urlArr addObject:responseObject[@"urllink"]];
    
    if (self.imageArr.count > 2) {
    [self.collectionView reloadData];
    }
    
}



- (void)requestURL {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    __weak ShopCollectionViewController *shopV = self;
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [shopV startParseJSONData:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
        NSLog(@"111111111111%@",error);
        
    }];
}

- (void)startParseJSONData:(NSMutableDictionary *)responseObject {
    NSMutableArray *dataArr = responseObject[@"datas"];
    //化妆品
    NSMutableDictionary *firstDic = dataArr.firstObject;
    NSMutableDictionary *goodDic = firstDic[@"goods"];
    NSMutableArray *itemArr = goodDic[@"item"];
    for (NSMutableDictionary *tempDic in itemArr) {
        goodModel *goodM = [[goodModel alloc]init];
        [goodM setValuesForKeysWithDictionary:tempDic];
        [self.goodArray addObject:goodM];
    }
    
    //家具
    NSMutableDictionary *homeDic = [dataArr objectAtIndex:1];
    NSMutableDictionary *homeGoodDic = homeDic[@"goods"];
    NSMutableArray *homeItemArr = homeGoodDic[@"item"];
    for (NSMutableDictionary *homeTempDic in homeItemArr) {
        goodModel *goodM = [[goodModel alloc]init];
        [goodM setValuesForKeysWithDictionary:homeTempDic];
        [self.homeArray addObject:goodM];
    }
    
    //箱包
    NSMutableDictionary *packDic = [dataArr objectAtIndex:2];
    NSMutableDictionary *packGoodDic = packDic[@"goods"];
    NSMutableArray *packItemArr = packGoodDic[@"item"];
    for (NSMutableDictionary *packTempDic in packItemArr) {
        goodModel *goodM = [[goodModel alloc]init];
        [goodM setValuesForKeysWithDictionary:packTempDic];
        [self.packArray addObject:goodM];

    }
    
    //美食
    NSMutableDictionary *foodDic = [dataArr objectAtIndex:3];
    NSMutableDictionary *foodGoodDic = foodDic[@"goods"];
    NSMutableArray *foodItemArr = foodGoodDic[@"item"];
    for (NSMutableDictionary *foodTempDic in foodItemArr) {
        goodModel *goodM = [[goodModel alloc]init];
        [goodM setValuesForKeysWithDictionary:foodTempDic];
        [self.foodArray addObject:goodM];
    }
    
    //首饰
    NSMutableDictionary *goldDic = [dataArr objectAtIndex:4];
    NSMutableDictionary *goldGoodDic = goldDic[@"goods"];
    NSMutableArray *goldItemArr = goldGoodDic[@"item"];
    for (NSMutableDictionary *goldTempDic in goldItemArr) {
        goodModel *goodM = [[goodModel alloc]init];
        [goodM setValuesForKeysWithDictionary:goldTempDic];
        [self.goldArray addObject:goodM];
    }
    
    [self.collectionView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}


#pragma mark -----返回按钮

- (IBAction)backAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"toShopTwo"]) {
        ShopTableViewControllerTow *shopV = [segue destinationViewController];
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
      switch (indexPath.row) {
            case 0:{
                //服饰鞋帽,礼品箱包
               [shopV.urlArr removeAllObjects];
                NSArray *tempArr = [NSArray arrayWithObjects:@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"151",@"152",@"153",@"154",@"155", nil];
                [shopV.urlArr addObjectsFromArray:tempArr];
            }
                break;
                
            case 1:{
                //家居服装  数码办公
                [shopV.urlArr removeAllObjects];
                NSArray *tempArr = [NSArray arrayWithObjects:@"200",@"201",@"202",@"203",@"204",@"205",@"258",@"259", @"260", @"261", @"390", @"391", @"392", @"393", @"394",@"395", @"1034", nil];
                [shopV.urlArr addObjectsFromArray:tempArr];
            }
                break;
            case 2:{
                //家用电器 个护化妆
                [shopV.urlArr removeAllObjects];
                NSArray *tempArr = [NSArray arrayWithObjects:@"309",@"310",@"311",@"312",@"313",@"471",@"472",@"473",@"474",@"475",@"476",@"477", nil];
                [shopV.urlArr addObjectsFromArray:tempArr];
            }
                break;
              
            case 3:{
                //珠宝手表
                [shopV.urlArr removeAllObjects];
                NSArray *tempArr = [NSArray arrayWithObjects:@"531",@"532",@"533",@"534",@"535",@"536",@"537",@"538",@"539",@"540", nil];
                [shopV.urlArr addObjectsFromArray:tempArr];
                
            }
                break;
            case 4:{
                //食品饮料 运动健康
                [shopV.urlArr removeAllObjects];
                NSArray *tempArr = [NSArray arrayWithObjects:@"594",@"595",@"596",@"597",@"598",@"599",@"560",@"561",@"562",@"563",@"663",@"664",@"665",@"666",@"667",@"668",@"669",@"670", nil];
                [shopV.urlArr addObjectsFromArray:tempArr];
                
            }
                break;
            case 5:{
                //汽车用品
                [shopV.urlArr removeAllObjects];
                NSArray *tempArr = [NSArray arrayWithObjects:@"731",@"732",@"733",@"734",@"735",@"736",@"737",nil];
                [shopV.urlArr addObjectsFromArray:tempArr];
            }
                break;
            case 6:{
                //玩具  乐器  虚拟充值
                [shopV.urlArr removeAllObjects];
                NSArray *tempArr = [NSArray arrayWithObjects:@"826",@"827",@"828",@"829",@"830",@"831",@"832",@"833",@"834",@"835",@"836",@"837",@"1054",@"1041",@"1042",  nil];
                [shopV.urlArr addObjectsFromArray:tempArr];
                }
                break;
            case 7:{
                //厨具, 母婴用品
                [shopV.urlArr removeAllObjects];
                NSArray *tempArr = [NSArray arrayWithObjects:@"889",@"890",@"891",@"892",@"893",@"935",@"960",@"961",@"962",@"963",@"964",@"965",@"966",@"967", nil];
                [shopV.urlArr addObjectsFromArray:tempArr];
            }
                break;
              
            default:
                break;
              
        }
    }
    
    //跳转到详情界面
    if ([segue.identifier isEqualToString:@"toWebView"]) {
        ShopWebViewController *shopWeb = segue.destinationViewController;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
      
        if (indexPath.section == 1) {
            goodModel *goodM = self.goodArray[indexPath.row];
            shopWeb.good_ID = goodM.goods_id;
            
        }
        else if (indexPath.section == 2) {
            goodModel *goodM = self.homeArray[indexPath.row];
            shopWeb.good_ID = goodM.goods_id;
        }
        else if (indexPath.section == 3) {
            goodModel *goodM = self.packArray[indexPath.row];
            shopWeb.good_ID = goodM.goods_id;
        }
        else if (indexPath.section == 4) {
            goodModel *goodM = self.foodArray[indexPath.row];
            shopWeb.good_ID = goodM.goods_id;
        }
        else if (indexPath.section == 5) {
            goodModel *goodM = self.goldArray[indexPath.row];
            shopWeb.good_ID = goodM.goods_id;
        }
    }
    
    
}




#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 6;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    if (section == 0) {
        return 10;
    }
    else if (section == 1){
        
        return self.goodArray.count;
    }
    else if (section == 2){
        return self.homeArray.count;
    }
    else if (section == 3){
        return self.packArray.count;
    }
    else if (section == 4){
        return self.foodArray.count;
    }
    else {
        return self.goldArray.count;
    }
}

// 返回分区的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(ScreenW / 5 - Space,ScreenW / 5 - Space);
        
    }
    else {
        return CGSizeMake(ScreenW / 3 - Space, ScreenW / 3 + 20);
    }
}

//返回区头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(ScreenW, 150);
    }
    else {
        return CGSizeMake(0, 0);
    }
}

//返回区尾尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0 || section == 1 || section == 2 || section == 3 || section == 4) {
        return CGSizeMake(ScreenW, 50);
        
    }
    return CGSizeMake(0, 0);
}

//返回区头或区尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        ShopCollectionReusableView *shopHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ShopHeader" forIndexPath:indexPath];

        NSArray *imageArr = [NSArray arrayWithObjects:@"http://zghrj.cn/data/upload/mobile/special/s0/s0_05112865774229021.png",@"http://zghrj.cn/data/upload/mobile/special/s0/s0_05129176853556915.png",@"http://zghrj.cn/data/upload/mobile/special/s0/s0_05129193963334291.png", nil];
        
        SDCycleScrollView *sdCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, 150) imageURLStringsGroup:self.imageArr];
        [shopHeader addSubview:sdCycle];
        return shopHeader;
        
    }
    else {
        ShopCollectionReusableViewFoot *shopFoot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
        
        if (indexPath.section == 0) {
            shopFoot.title.text = @"化妆品";
        }else if (indexPath.section == 1){
            shopFoot.title.text = @"智能家居";
        }
        else if (indexPath.section == 2){
            shopFoot.title.text = @"箱包";
        }
        else if (indexPath.section == 3) {
            shopFoot.title.text = @"美食";
        }
        else if (indexPath.section == 4) {
            shopFoot.title.text = @"首饰";
        }
        
        return shopFoot;
    }
}

//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        ShopCollectionViewCell1 *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        
        cell1.imageName.image = [UIImage imageNamed:[NSString stringWithFormat:@"shangcheng1%ld",indexPath.row]];
        
        return cell1;
    }
    else if (indexPath.section == 1) {
        ShopCollectionViewCell2 *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        
        goodModel *goodM = self.goodArray[indexPath.row];
        [cell2 show:goodM];
 
        return cell2;
    }
    else if (indexPath.section == 2) {
        ShopCollectionViewCell2 *cell3 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        
        goodModel *goodM = self.homeArray[indexPath.row];
       
        [cell3 show:goodM];
        
        return cell3;
    }
    else if (indexPath.section == 3) {
        ShopCollectionViewCell2 *cell4 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        
        goodModel *goodM = self.packArray[indexPath.row];
        [cell4 show:goodM];
        
        return cell4;
    }
    else  if (indexPath.section == 4) {
        ShopCollectionViewCell2 *cell5 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        
        goodModel *goodM = self.foodArray[indexPath.row];
       
        [cell5 show:goodM];
        
        return cell5;
        
    }
    else {
        ShopCollectionViewCell2 *cell6 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        
        goodModel *goodM = self.goldArray[indexPath.row];
        [cell6 show:goodM];
        
        return cell6;
    }
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%ld",indexPath.section);
//    if (indexPath.section == 0) {
//        NSLog(@"%ld",indexPath.row);
//    }
//}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
 
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
   
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    SearchViewController *search1 = [self.storyboard instantiateViewControllerWithIdentifier:@"123"];
    
    [self.navigationController pushViewController:search1 animated:YES];
    
    return NO;
    
}

@end
