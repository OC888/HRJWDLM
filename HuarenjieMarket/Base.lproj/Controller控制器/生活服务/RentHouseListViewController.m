//
//  RentHouseListViewController.m
//  temp
//
//  Created by l x on 16/5/24.
//  Copyright © 2016年 wangli. All rights reserved.
//
#define XINFANGCHUSHOU_URL @"http://zghrj.cn/interface/house_xinfangsale_select.php"
#define ERSHOUFANGQIUGOU_URL @"http://zghrj.cn/interface/house_ershouqiugou_select.php"
#define ERSHOUFANGCHUSHOU_URL @"http://zghrj.cn/interface/house_ershousale_select.php"
#import "RentHouseListViewController.h"
#import "ResumeCarViewController.h"
#import "RentlistTableViewCell.h"
#import "RentHouseDetailViewController.h"
#import "ErShouFangQiuGouCell.h"
#import "ErShouFangQGDetailViewController.h"
#import "BuyErShouHouseViewController.h"
#import "SailErShouHouseViewController.h"
#import "ShangPuDetailViewController.h"
#import "SailShangPuViewController.h"
#import "SailXiezilouViewController.h"
#import "SailChangfangViewController.h"
#import "SailNewHouseViewController.h"

@interface RentHouseListViewController ()<UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *resultArr;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UISearchController *search;
@property (nonatomic,copy) NSMutableArray *houseArr;

@end

@implementation RentHouseListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    MBProgressHUD *mb=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mb.mode=MBProgressHUDAnimationFade;
    mb.labelText=@"华人街努力加载中...";
//买房
    if ([_tag isEqualToString:@"100"]||[_biaozhi isEqualToString:@"二手房"]) {
        [AFHttpManager parserErShouFangChuShouWithUrlString:ERSHOUFANGCHUSHOU_URL withArr:^(NSMutableArray *resumeArr) {
            [mb hide:YES];
            if (resumeArr.count<=0||resumeArr[0]==nil) {
                SHOW_NOALERT(@"亲，暂时没有相关信息，快去发布吧");
            }

            _houseArr=resumeArr;
            [_tableView reloadData];
        }];
    }
    if ([_tag isEqualToString:@"101"]) {
        [AFHttpManager parserErShouFangQiuGouWithUrlString:ERSHOUFANGQIUGOU_URL withArr:^(NSMutableArray *resumeArr) {
            [mb hide:YES];
            if (resumeArr.count<=0||resumeArr[0]==nil) {
                SHOW_NOALERT(@"亲，暂时没有相关信息，快去发布吧");
            }

            _houseArr=resumeArr;
            [_tableView reloadData];
        }];
    }
    if ([_tag isEqualToString:@"105"]) {
        [AFHttpManager parserNewHouseChuShouInfoWithTitle:nil withArr:^(NSMutableArray *resumeArr) {
            [mb hide:YES];
            if (resumeArr.count<=0||resumeArr[0]==nil) {
                SHOW_NOALERT(@"亲，暂时没有相关信息，快去发布吧");
            }

            _houseArr=resumeArr;
            [_tableView reloadData];
        }];
    }
    if ([_biaozhi isEqualToString:@"商铺出售"]||[_tag isEqualToString:@"200"]) {
        [AFHttpManager parserShangPuInfoWithTitle:@"商铺出售" withArr:^(NSMutableArray *resumeArr) {
            [mb hide:YES];
            if (resumeArr.count<=0||resumeArr[0]==nil) {
                SHOW_NOALERT(@"亲，暂时没有相关信息，快去发布吧");
            }

            _houseArr=resumeArr;
            [_tableView reloadData];
        }];
    }
    if ([_biaozhi isEqualToString:@"写字楼出售"]||[_tag isEqualToString:@"201"]) {
        [AFHttpManager parserShangPuInfoWithTitle:@"写字楼出售" withArr:^(NSMutableArray *resumeArr) {
            [mb hide:YES];
            if (resumeArr.count<=0||resumeArr[0]==nil) {
                SHOW_NOALERT(@"亲，暂时没有相关信息，快去发布吧");
            }

            _houseArr=resumeArr;
            [_tableView reloadData];
        }];
    }
    if ([_tag isEqualToString:@"202"]) {
        [AFHttpManager parserShangPuInfoWithTitle:@"厂房仓库土地" withArr:^(NSMutableArray *resumeArr) {
            [mb hide:YES];
            if (resumeArr.count<=0||resumeArr[0]==nil) {
                SHOW_NOALERT(@"亲，暂时没有相关信息，快去发布吧");
            }

            _houseArr=resumeArr;
            [_tableView reloadData];
        }];
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNavigationItem];
    [self creatTable];
    _houseArr=[NSMutableArray array];
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
    self.search.searchBar.placeholder=_placeholder;
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
    if ([_tag isEqualToString:@"200"]||[_biaozhi isEqualToString:@"商铺出售"]) {
        SailShangPuViewController *vc =[[SailShangPuViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_tag isEqualToString:@"201"]||[_biaozhi isEqualToString:@"写字楼出售"]) {
        SailXiezilouViewController *vc =[[SailXiezilouViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_tag isEqualToString:@"202"]){
        SailChangfangViewController *vc =[[SailChangfangViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_tag isEqualToString:@"101"]) {
        BuyErShouHouseViewController *resumeVC=[[BuyErShouHouseViewController alloc]init];
        [self.navigationController pushViewController:resumeVC animated:YES];
    }else if ([_tag isEqualToString:@"105"]) {
        SailNewHouseViewController *vc =[[SailNewHouseViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        SailErShouHouseViewController *vc =[[SailErShouHouseViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
//创建表
-(void)creatTable{
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.rowHeight=90;
    [self.tableView registerNib:[UINib nibWithNibName:@"ErShouFangQiuGouCell" bundle:nil] forCellReuseIdentifier:@"ErShouFangQiuGouCell"];
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _houseArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_tag isEqualToString:@"101"]) {
        ErShouFangQiuGouCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ErShouFangQiuGouCell"];
        ErShouFangQiuGouInfo *info =_houseArr[indexPath.row];
        cell.houseTitleLabel.text=info.title;
        cell.housePriceLabel.text=info.dec_qiwangprice;
        cell.houseAddressLabel.text=info.quyu;
        cell.houseRectLabel.text=info.huxing;
        cell.houseResumLabel.text=info.dt_datetime;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        return cell;
    }else if ([_biaozhi isEqualToString:@"商铺出售"]||[_tag isEqualToString:@"200"]||[_biaozhi isEqualToString:@"写字楼出售"]||[_tag isEqualToString:@"201"]||[_tag isEqualToString:@"202"]) {
        RentlistTableViewCell *cell = (RentlistTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell)
        {
            cell= (RentlistTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"RentlistTableViewCell" owner:self options:nil]  lastObject];
        }
         ShangPuInfo *info =_houseArr[indexPath.row];
        [cell.houseImageView sd_setImageWithURL:[NSURL URLWithString:info.img1] placeholderImage:[UIImage imageNamed:@"tu.png"] options:SDWebImageRefreshCached];
        if (![info.title isKindOfClass:[NSNull class]]) {
            cell.houseTitleLabel.text=info.title;
        }
        if (![info.dec_price isKindOfClass:[NSNull class]]) {
            cell.housePriceLabel.text=info.dec_price;
        }
        if (![info.dec_mianji isKindOfClass:[NSNull class]]) {
            cell.houseRectLabel.text=info.dec_mianji;
        }
        if (![info.quyu isKindOfClass:[NSNull class]]) {
            cell.houseAddressLabel.text=info.quyu;
        }
        if (![info.dt_datetime isKindOfClass:[NSNull class]]) {
            cell.houseResumTimeLabel.text=info.dt_datetime;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if ([_tag isEqualToString:@"105"]){
        
    RentlistTableViewCell *cell = (RentlistTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell)
    {
        cell= (RentlistTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"RentlistTableViewCell" owner:self options:nil]  lastObject];
    }
    NewHouseInfo *info =_houseArr[indexPath.row];
    [cell.houseImageView sd_setImageWithURL:[NSURL URLWithString:info.img1] placeholderImage:[UIImage imageNamed:@"tu.png"] options:SDWebImageRefreshCached];
        if (![info.title isKindOfClass:[NSNull class]]) {
            cell.houseTitleLabel.text=info.title;
        }
        if (![info.dec_shoujia isKindOfClass:[NSNull class]]) {
            cell.housePriceLabel.text=info.dec_shoujia;
        }
        if (![info.quyu isKindOfClass:[NSNull class]]) {
            cell.houseAddressLabel.text=info.quyu;
        }
        if (![info.huxing isKindOfClass:[NSNull class]]&&![info.dec_jianzhumianji isKindOfClass:[NSNull class]]) {
            cell.houseRectLabel.text=[NSString stringWithFormat:@"%@ %@㎡",info.huxing,info.dec_jianzhumianji];
        }
        if (![info.dt_datetime isKindOfClass:[NSNull class]]) {
            cell.houseResumTimeLabel.text=info.dt_datetime;
        }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    }else{
        RentlistTableViewCell *cell = (RentlistTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell)
        {
            cell= (RentlistTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"RentlistTableViewCell" owner:self options:nil]  lastObject];
        }
        ErShouFangInfo *info =_houseArr[indexPath.row];
        [cell.houseImageView sd_setImageWithURL:[NSURL URLWithString:info.img1] placeholderImage:[UIImage imageNamed:@"tu.png"] options:SDWebImageRefreshCached];
        if (![info.title isKindOfClass:[NSNull class]]) {
            cell.houseTitleLabel.text=info.title;
        }
        if (![info.dec_price isKindOfClass:[NSNull class]]) {
            cell.housePriceLabel.text=info.dec_price;
        }
        if (![info.quyu isKindOfClass:[NSNull class]]) {
            cell.houseAddressLabel.text=info.quyu;
        }
        if (![info.huxing isKindOfClass:[NSNull class]]&&![info.dec_mianji isKindOfClass:[NSNull class]]) {
            cell.houseRectLabel.text=[NSString stringWithFormat:@"%@ %@㎡",info.huxing,info.dec_mianji];
        }
        if (![info.dt_datetime isKindOfClass:[NSNull class]]) {
            cell.houseResumTimeLabel.text=info.dt_datetime;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_tag isEqualToString:@"101"]) {
        ErShouFangQGDetailViewController *VC=[[ErShouFangQGDetailViewController alloc]init];
        VC.biaozhi=@"二手房求购";
        VC.qiuGouInfo=_houseArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
    }else if ([_biaozhi isEqualToString:@"商铺出售"]||[_tag isEqualToString:@"200"]||[_biaozhi isEqualToString:@"写字楼出售"]||[_tag isEqualToString:@"201"]||[_tag isEqualToString:@"202"]){
        ShangPuDetailViewController *VC=[[ShangPuDetailViewController alloc]init];
        VC.biaozhi=_biaozhi;
        VC.info=_houseArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
    }else if ([_tag isEqualToString:@"105"]){
        RentHouseDetailViewController *VC=[[RentHouseDetailViewController alloc]init];
        VC.xinFangInfo=_houseArr[indexPath.row];
        VC.biaozhi=@"新房";
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        RentHouseDetailViewController *VC=[[RentHouseDetailViewController alloc]init];
        VC.erShouFangInfo=_houseArr[indexPath.row];
        VC.biaozhi=@"二手房";
        [self.navigationController pushViewController:VC animated:YES];
    }
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

@end
