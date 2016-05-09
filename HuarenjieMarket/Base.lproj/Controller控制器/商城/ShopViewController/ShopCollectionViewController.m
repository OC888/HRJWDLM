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
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define Space 10
#define url @"http://zghrj.cn/mobile/index.php?act=index&op=special&special_id=5"


@interface ShopCollectionViewController ()

@property (nonatomic, strong)NSMutableArray *goodArray;
@property (nonatomic, strong)NSMutableArray *homeArray;
@property (nonatomic, strong)NSMutableArray *foodArray;
@property (nonatomic, strong)NSMutableArray *packArray;
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
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self requestURL];
    
}


- (void)requestURL {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    __weak ShopCollectionViewController *shopV = self;
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [shopV startParseJSONData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"toShopTwo"]) {
        ShopTableViewControllerTow *shopTwo = segue.destinationViewController;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
//        switch (indexPath.row) {
//            case 0:
//                 shopTwo.
//                break;
//                
//            default:
//                break;
//        }
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
        return 8;
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
        return CGSizeMake(ScreenW / 4 - Space,ScreenW / 4 - Space);
        
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
        
        SDCycleScrollView *sdCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, 150) imageURLStringsGroup:imageArr];
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
        
        // Configure the cell

        return cell1;
    }
    else if (indexPath.section == 1) {
        ShopCollectionViewCell2 *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];

        
        
            goodModel *goodM = self.goodArray[indexPath.row];
            cell2.good_name.text = goodM.goods_name;
           [cell2.good_image sd_setImageWithURL:[NSURL URLWithString:goodM.goods_image]];
 
            

        return cell2;
    }
    else if (indexPath.section == 2) {
        ShopCollectionViewCell2 *cell3 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        
        goodModel *goodM = self.homeArray[indexPath.row];
        cell3.good_name.text = goodM.goods_name;
        [cell3.good_image sd_setImageWithURL:[NSURL URLWithString:goodM.goods_image]];
        
        
        return cell3;
    }
    else if (indexPath.section == 3) {
        ShopCollectionViewCell2 *cell4 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        
        
        goodModel *goodM = self.packArray[indexPath.row];
        cell4.good_name.text = goodM.goods_name;
        [cell4.good_image sd_setImageWithURL:[NSURL URLWithString:goodM.goods_image]];
        
        
        return cell4;
    }
    else  if (indexPath.section == 4) {
        ShopCollectionViewCell2 *cell5 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        
        goodModel *goodM = self.foodArray[indexPath.row];
        cell5.good_name.text = goodM.goods_name;
        [cell5.good_image sd_setImageWithURL:[NSURL URLWithString:goodM.goods_image]];
        
        return cell5;
    }
    else {
        ShopCollectionViewCell2 *cell6 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        
        goodModel *goodM = self.goldArray[indexPath.row];
        cell6.good_name.text = goodM.goods_name;
        [cell6.good_image sd_setImageWithURL:[NSURL URLWithString:goodM.goods_image]];
        
        
        return cell6;
    }
}

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

@end
