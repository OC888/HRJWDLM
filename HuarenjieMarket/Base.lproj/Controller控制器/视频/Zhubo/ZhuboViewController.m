//
//  ZhuboViewController.m
//  AideoPlayProject
//
//  Created by aaa on 16/5/3.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ZhuboViewController.h"
#import "ZhuboCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "TLCycleScrollView.h"
//#import "DeViewController.h"
#import "AFNetworking.h"
#define URL(A) [NSString stringWithFormat:@"http://acshow.kugou.com/show7/rank/json/v2/cdn/room/piazza_star?areaCode=-1&baiduCode=-1&constellation=-1&page=%d&pageSize=80&platform=1&sex=-1&sign=0cefff64c301bcea&starLevel=-1&timeType=-1&version=8066", (A)]
#import "ZhuboModel.h"
#import "UIImageView+WebCache.h"
@interface ZhuboViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ZhuboViewController

static NSString * const reuseIdentifier = @"Cell";

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self netWorking:1];
    
    
    // Do any additional setup after loading the view.
}

- (void)netWorking:(int)value {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text", @"application/json", @"xml", @"script",  nil];
    __weak ZhuboViewController *zhuboVC = self;
    
    [manager GET:URL(value) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //数据解析
        [zhuboVC parseData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)parseData:(id)responseObject {
    NSMutableDictionary *data = responseObject[@"data"];
    NSMutableArray *piazzaList = data[@"piazzaList"];
    for (NSMutableDictionary *Dic in piazzaList) {
        ZhuboModel *model = [[ZhuboModel alloc] init];
        [model setValuesForKeysWithDictionary:Dic];
        [self.dataSource addObject:model];
    }
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil message:@"直播暂未开通哦" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeFireMethod:) userInfo:alertV repeats:NO];
    [alertV show];
}

//时间计时器
- (void)timeFireMethod:(NSTimer *)theTime {
    UIAlertView *alertV = (UIAlertView *)[theTime userInfo];
    [alertV dismissWithClickedButtonIndex:0 animated:NO];
}

#pragma mark <UICollectionViewDataSource>
//返回分区个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//返回每个分区Item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZhuboCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ZhuboModel *model = _dataSource[indexPath.row];
    if (_dataSource.count ) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"d3.jpg"]];
        cell.detailLabel.text = model.nickName;
        cell.playCountLabel.text = [NSString stringWithFormat:@"%ld", (long)model.viewerNum];
    }
    
    return cell;
}

//返回区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = nil;
    
    TLCycleScrollView *tlc = [[TLCycleScrollView alloc] initWithImageArr:[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"aa.jpg"],[UIImage imageNamed:@"bb.jpg"],[UIImage imageNamed:@"cc.jpg"], nil] withY:0 withAspectRatio:0.4 withImageChangeTimeInterval:2];
    HeaderCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    [view addSubview:tlc];
    headerView = view;
    return view;
    
}

#pragma mark <UICollectionViewDelegateFlowLayout>
//动态返回item高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.bounds.size.width - 2)/2, ([UIScreen mainScreen].bounds.size.height-64)/3);
}
//动态返回区头高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, self.view.bounds.size.width*0.4);
}

- (BOOL)shouldAutorotate {
    return NO;
}

#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    DeViewController *DetailVC = [segue destinationViewController];
    [DetailVC.imageView1 setImage:[UIImage imageNamed:@"d2.jpg"]];
    [DetailVC.imageView2 setImage:[UIImage imageNamed:@"d2.jpg"]];
}
*/
@end
