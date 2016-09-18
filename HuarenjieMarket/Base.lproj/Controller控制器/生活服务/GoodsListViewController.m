//
//  GoodsListViewController.m
//  temp
//
//  Created by l x on 16/5/22.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "GoodsListViewController.h"
#import "ResumeGoodsViewController.h"

@interface GoodsListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchResultsUpdating>
@property (nonatomic,strong) NSMutableArray *resultArr;

@end

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self creatCollectionView];
    [self creatNavigationItem];
}
//创建导航栏按钮
-(void)creatNavigationItem{
    
    self.search =[[UISearchController alloc]initWithSearchResultsController:nil];
    self.search.searchBar.backgroundColor=[UIColor clearColor];
    self.search.searchBar.barTintColor=BJCOLOR;
    [self.search.searchBar sizeToFit];
    self.search.dimsBackgroundDuringPresentation=NO;
    self.search.searchResultsUpdater=self;
    self.search.hidesNavigationBarDuringPresentation = NO;
    self.search.searchBar.layer.masksToBounds=YES;
    self.search.searchBar.layer.cornerRadius=14;
    self.navigationItem.titleView=self.search.searchBar;
    
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(writeRsume)];
    [rightItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem=rightItem;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
-(void)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
//导航右栏按钮绑定方法
-(void)writeRsume{
    
    ResumeGoodsViewController *resumeVC=[[ResumeGoodsViewController alloc]init];
    [self.navigationController pushViewController:resumeVC animated:YES];
}
#pragma mark searchResultsUpdater
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [_resultArr removeAllObjects];
    
    //    NSString *filterString = searchController.searchBar.text;
    //    NSMutableArray *nameArr =[[NSMutableArray alloc]initWithCapacity:0];
    //    for (ResumeInfo *info in _arr) {
    //        [nameArr addObject:info.name];
    //        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@", filterString];
    //
    //        NSMutableArray *nameResultArr = [NSMutableArray arrayWithArray:[nameArr filteredArrayUsingPredicate:predicate]];
    //        for (NSString *name in nameResultArr) {
    //            if ([info.name isEqualToString:name]) {
    //                [_resultArr addObject:info];
    //                NSLog(@"%@-=%@-=%@",nameResultArr,name,self.resultArr);
    //            }
    //        }
    //    }
    //    [self.tableView reloadData];
}
-(void)creatCollectionView{
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    self.collectinView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:layout];
    self.collectinView.dataSource=self;
    self.collectinView.delegate=self;
    self.collectinView.backgroundColor=LINECOLOR;
    [self.collectinView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectinView];
}
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"cell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0,0 , cell.bounds.size.width, cell.bounds.size.height-30)];
    imageView.image=[UIImage imageNamed:@"fabu-01"];
    
    UILabel *goodsNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, cell.bounds.size.height-30+5, (cell.bounds.size.width-10)/3*2, 20)];
    goodsNameLabel.font=[UIFont systemFontOfSize:13.0];
    goodsNameLabel.textColor=[UIColor lightGrayColor];
    goodsNameLabel.text=@"大学路-电动车";
    
    UILabel *goodsPriceLabel =[[UILabel alloc]initWithFrame:CGRectMake(5+(cell.bounds.size.width-10)/3*2, cell.bounds.size.height-30+5, (cell.bounds.size.width-10)/3, 20)];
    goodsPriceLabel.font=[UIFont systemFontOfSize:13.0];
    goodsPriceLabel.textAlignment=NSTextAlignmentRight;
    goodsPriceLabel.textColor=[UIColor orangeColor];
    goodsPriceLabel.text=@"2350元";

    [cell addSubview:imageView];
    [cell addSubview:goodsNameLabel];
    [cell addSubview:goodsPriceLabel];
    
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WIDTH/2-10, HEIGHT/3);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
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
