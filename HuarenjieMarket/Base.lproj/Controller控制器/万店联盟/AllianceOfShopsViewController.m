//
//  AllianceOfShopsViewController.m
//  HuarenjieMarket
//
//  Created by aaa on 16/9/13.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "AllianceOfShopsViewController.h"
#import "AllinceOfShopsCollectionCell.h"
#import "AllinceOfShopsReusableView.h"
@interface AllianceOfShopsViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegateFlowLayout,UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *searchResult;
@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) UITableViewController *searchResultVC;
@property (nonatomic,strong) UISearchBar *searchBar;

@end

static NSString *headerIdentifier = @"collectionHeaderView";
static NSString *tableViewIdentifier = @"tableViewCell";
@implementation AllianceOfShopsViewController

static NSString * const reuseIdentifier = @"AllinceCell";

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (NSMutableArray *)searchResult {
    if (!_searchResult) {
        self.searchResult = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _searchResult;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(100, 0, WIDTH - 200, 44.0)];
    [self.navigationController.navigationBar addSubview:self.searchBar];
    self.searchBar.placeholder = @"搜索店铺";
    self.searchBar.delegate = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Register cell classes
    UINib *nib = [UINib nibWithNibName:@"AllinceOfShopsCollectionCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[AllinceOfShopsReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    
    
    // Do any additional setup after loading the view.
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

#pragma mark <UISearchBarDelegate>
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    创建搜索结果视图控制器
    self.searchResultVC = [[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
    self.searchResultVC.tableView.frame = CGRectMake(0, 20, WIDTH, HEIGHT);
    self.searchResultVC.tableView.delegate = self;
    self.searchResultVC.tableView.dataSource = self;
    [self.searchResultVC.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewIdentifier];
//    创建搜索控制器
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:_searchResultVC];
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
//    弹出
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.placeholder = @"搜索店铺";
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, 20, self.searchController.searchBar.frame.size.width, 44.0);
    [self.searchResultVC.tableView.tableHeaderView addSubview:self.searchController.searchBar];
    [self presentViewController:self.searchController animated:YES completion:nil];
    self.searchBar.hidden = YES;
}
//轮播图点击方法
#pragma mark <SDCycleScrollViewDelegate>
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

#pragma mark <UISearchResultsUpdating>
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",_searchController.searchBar.text];
    if (self.searchResult != nil) {
        [self.searchResult removeAllObjects];
    }
    self.searchResult = [NSMutableArray arrayWithArray:[_searchResult filteredArrayUsingPredicate:preicate]];
}

//搜索页面消失时,原先的搜索框和view显示
- (void)didDismissSearchController:(UISearchController *)searchController {
    self.searchBar.hidden = NO;
}

//取消按钮触发方法,点击取消后
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.hidden = NO;
}

//当View将要出现时,View显示
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.searchBar.hidden = NO;
}
//控制器界面消失时,隐藏本界面搜索框
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.searchBar.hidden = YES;
}
//创建搜索结果视图
#pragma mark <UITableViewDelegateDateSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_searchResult.count == 0) {
        return 5;
    }
    return _searchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewIdentifier];
    }
    if (self.searchResult.count == 0) {
        cell.textLabel.text = @"没有您要找的内容";
    } else {
        cell.textLabel.text = @"这是要找的东西";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    PCLog(@"点击搜索结果跳转");
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AllinceOfShopsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AllinceOfShopsCollectionCell" owner:self options:nil]lastObject];
    }
    cell.icomImageView.image = [UIImage imageNamed:@"2"];
    cell.shopName.text = @"水密码";
    cell.descriptionLabel.text = @"双十一爆款";
    cell.distanceLabel.text = @"<600";
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    PCLog(@"点击店铺");
}

#pragma mark <UICollectionViewDelegate>
//创建页眉头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    AllinceOfShopsReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
    headerView.cycleScrollView.delegate = self;
    headerView.titlesArr = @[@"优质生活",@"敬请期待...",@"爆款顺丰包邮"];
//    分类按钮点击事件回调block
    headerView.block = ^{
        PCLog(@"点击了按钮");
    };

    NSArray * imageArr = @[@"12.png",@"13.png",@"2.png"];
    headerView.imagesArr = imageArr;
    [headerView setSDCycleScrollView:self];
    return headerView;
}


#pragma mark <UICollectionViewDelegateFlowLayout>
//设置分区缩进量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
        return UIEdgeInsetsMake(10, 20, 0, 20);
}

//设置分区页眉大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return  CGSizeMake(WIDTH, 150 + WIDTH / 5 * 1.25);
}


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
