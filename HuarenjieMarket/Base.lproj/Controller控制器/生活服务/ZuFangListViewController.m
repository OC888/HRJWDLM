//
//  ZuFangListViewController.m
//  temp
//
//  Created by l x on 16/6/5.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ZuFangListViewController.h"
#import "RentHouseListViewController.h"
#import "ResumeCarViewController.h"
#import "RentlistTableViewCell.h"
#import "RentHouseDetailViewController.h"
#import "ErShouFangQiuGouCell.h"
#import "ErShouFangQGDetailViewController.h"
#import "ShangPuDetailViewController.h"
#import "ZhengZuViewController.h"
#import "HeZuViewController.h"
#import "ShangPuViewController.h"
#import "DuanZuViewController.h"
#import "QiuZuViewController.h"
#import "XieZiLouViewController.h"
#import "ChangFangViewController.h"
#import "ZuFangDetailViewController.h"
#import "ErShouFangQGDetailViewController.h"
#import "ShangPuDetailViewController.h"

@interface ZuFangListViewController ()<UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *resultArr;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UISearchController *search;
@property (nonatomic,copy) NSMutableArray *houseArr;

@end

@implementation ZuFangListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    MBProgressHUD *mb=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mb.mode=MBProgressHUDAnimationFade;
    mb.labelText=@"华人街努力加载中...";

//租房
    if ([_tag isEqualToString:@"1002"]) {//短租、日租
        [AFHttpManager parserRiZuDuanZuWithArr:^(NSMutableArray *resumeArr) {
            [mb hide:YES];
            if (resumeArr.count<=0||resumeArr[0]==nil) {
                SHOW_NOALERT(@"亲，暂时没有相关信息，快去发布吧");
            }
            _houseArr=resumeArr;
            [_tableView reloadData];
        }];
    }else if ([_tag isEqualToString:@"1003"]) {//求租
        [AFHttpManager parserQiuZuWithArr:^(NSMutableArray *resumeArr) {
            [mb hide:YES];
            if (resumeArr.count<=0||resumeArr[0]==nil) {
                SHOW_NOALERT(@"亲，暂时没有相关信息，快去发布吧");
            }

            _houseArr=resumeArr;
            [_tableView reloadData];
        }];
    }else if ([_tag isEqualToString:@"2000"]||[_biaozhi isEqualToString:@"商铺出租"]) {//商铺出租
        [AFHttpManager parserShangPuChuZuWithArr:^(NSMutableArray *resumeArr) {
            [mb hide:YES];
            if (resumeArr.count<=0||resumeArr[0]==nil) {
                SHOW_NOALERT(@"亲，暂时没有相关信息，快去发布吧");
            }

            _houseArr=resumeArr;
            [_tableView reloadData];
        }];
        
    }else if ([_tag isEqualToString:@"2001"]) {//写字楼出租
        [AFHttpManager parserXieZiLouChuZuWtihTitle:@"写字楼出租" ithArr:^(NSMutableArray *resumeArr) {
            [mb hide:YES];
            if (resumeArr.count<=0||resumeArr[0]==nil) {
                SHOW_NOALERT(@"亲，暂时没有相关信息，快去发布吧");
            }

            _houseArr=resumeArr;
            [_tableView reloadData];
        }];
    }else if ([_tag isEqualToString:@"2002"]) {//厂房仓库土地
        [AFHttpManager parserXieZiLouChuZuWtihTitle:@"厂房仓库土地" ithArr:^(NSMutableArray *resumeArr) {
            [mb hide:YES];
            if (resumeArr.count<=0||resumeArr[0]==nil) {
                SHOW_NOALERT(@"亲，暂时没有相关信息，快去发布吧");
            }

            _houseArr=resumeArr;
            [_tableView reloadData];
        }];

    }else if ([_tag isEqualToString:@"1001"]||[_biaozhi isEqualToString:@"合租"]) {//合租
        [AFHttpManager parserHeZuInfoWithTitle:nil withArr:^(NSMutableArray *resumeArr) {
            [mb hide:YES];
            if (resumeArr.count<=0||resumeArr[0]==nil) {
                SHOW_NOALERT(@"亲，暂时没有相关信息，快去发布吧");
            }

            _houseArr=resumeArr;
            [_tableView reloadData];
        }];
    }else {//整租
    [AFHttpManager parserZhengZuInfoWithTitle:nil withArr:^(NSMutableArray *resumeArr) {
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
    if ([_tag isEqualToString:@"1000"]||[_biaozhi isEqualToString:@"整租"]) {
        ZhengZuViewController *vc =[[ZhengZuViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_tag isEqualToString:@"1001"]||[_biaozhi isEqualToString:@"合租"]) {
        HeZuViewController *vc =[[HeZuViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_tag isEqualToString:@"2000"]||[_biaozhi isEqualToString:@"商铺出租"]) {
        ShangPuViewController *vc =[[ShangPuViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_tag isEqualToString:@"1002"]) {
        DuanZuViewController *vc =[[DuanZuViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_tag isEqualToString:@"1003"]) {
        QiuZuViewController *vc =[[QiuZuViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_tag isEqualToString:@"2001"]) {
        XieZiLouViewController *vc =[[XieZiLouViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_tag isEqualToString:@"2002"]) {
        ChangFangViewController *vc =[[ChangFangViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ZhengZuViewController *vc =[[ZhengZuViewController alloc]init];
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
    if ([_tag isEqualToString:@"1002"]) {//短租、日租
        RentlistTableViewCell *cell = (RentlistTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell)
        {
            cell= (RentlistTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"RentlistTableViewCell" owner:self options:nil]  lastObject];
        }
        RiZuDuanZu *info =_houseArr[indexPath.row];
        [cell.houseImageView sd_setImageWithURL:[NSURL URLWithString:info.img1] placeholderImage:[UIImage imageNamed:@"tu.png"] options:SDWebImageRefreshCached];
        if (![info.biaoti isKindOfClass:[NSNull class]]) {
            cell.houseTitleLabel.text=info.biaoti;
        }
        if (![info.dec_zujin isKindOfClass:[NSNull class]]) {
            cell.housePriceLabel.text=[NSString stringWithFormat:@"%d元/天",[info.dec_zujin intValue]];
        }
        if (![info.quyu isKindOfClass:[NSNull class]]) {
            cell.houseAddressLabel.text=info.quyu;
        }
        if (![info.fangwuleixing isKindOfClass:[NSNull class]]) {
            cell.houseRectLabel.text=info.fangwuleixing;
        }
        if (![info.dt_datetime isKindOfClass:[NSNull class]]) {
            cell.houseResumTimeLabel.text=info.dt_datetime;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if ([_tag isEqualToString:@"1003"]) {//求租
        ErShouFangQiuGouCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ErShouFangQiuGouCell"];
        QiuZuInfo *info =_houseArr[indexPath.row];
        cell.houseTitleLabel.text=info.biaoti;
        cell.housePriceLabel.text=info.dec_qiwangzujin;
        cell.houseAddressLabel.text=info.quyu;
        cell.houseRectLabel.text=info.huxing;
        cell.houseResumLabel.text=info.dt_datetime;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if ([_biaozhi isEqualToString:@"商铺出租"]||[_tag isEqualToString:@"2000"]||[_tag isEqualToString:@"2001"]||[_tag isEqualToString:@"2002"]) {//商铺、写字楼、厂房
        RentlistTableViewCell *cell = (RentlistTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell)
        {
            cell= (RentlistTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"RentlistTableViewCell" owner:self options:nil]  lastObject];
        }
        HeZuInfo *info =_houseArr[indexPath.row];
        [cell.houseImageView sd_setImageWithURL:[NSURL URLWithString:info.img1] placeholderImage:[UIImage imageNamed:@"tu.png"] options:SDWebImageRefreshCached];
        if (![info.biaoti isKindOfClass:[NSNull class]]) {
            cell.houseTitleLabel.text=info.biaoti;
        }
        if (![info.dec_zujin isKindOfClass:[NSNull class]]) {
            cell.housePriceLabel.text=[NSString stringWithFormat:@"%d元/天",[info.dec_zujin intValue]];
        }
        if (![info.quyu isKindOfClass:[NSNull class]]) {
            cell.houseAddressLabel.text=info.quyu;
        }
        if (![info.dec_mianji isKindOfClass:[NSNull class]]) {
            cell.houseRectLabel.text=[NSString stringWithFormat:@"%d㎡",[info.dec_mianji intValue]];
        }
        if (![info.dt_datetime isKindOfClass:[NSNull class]]) {
            cell.houseResumTimeLabel.text=info.dt_datetime;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{//整租、合租
        RentlistTableViewCell *cell = (RentlistTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell)
        {
            cell= (RentlistTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"RentlistTableViewCell" owner:self options:nil]  lastObject];
        }
        HeZuInfo *info =_houseArr[indexPath.row];
        [cell.houseImageView sd_setImageWithURL:[NSURL URLWithString:info.img1] placeholderImage:[UIImage imageNamed:@"tu.png"] options:SDWebImageRefreshCached];
        if (![info.biaoti isKindOfClass:[NSNull class]]) {
            cell.houseTitleLabel.text=info.biaoti;
        }
        if (![info.dec_zujin isKindOfClass:[NSNull class]]) {
            cell.housePriceLabel.text=info.dec_zujin;
        }
        if (![info.dec_mianji isKindOfClass:[NSNull class]]) {
            cell.houseRectLabel.text=[NSString stringWithFormat:@"%@ %d",info.huxing,[info.dec_mianji intValue]];
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
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_tag isEqualToString:@"1002"]) {//短租、日租
        ZuFangDetailViewController *vc=[[ZuFangDetailViewController alloc]init];
        RiZuDuanZu *info =_houseArr[indexPath.row];
        vc.riZuInfo=info;
        vc.biaozhi=@"短租日租";
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_tag isEqualToString:@"1003"]) {//求租
        ErShouFangQGDetailViewController *vc=[[ErShouFangQGDetailViewController alloc]init];
        vc.qiuZuInfo =_houseArr[indexPath.row];
        vc.biaozhi=@"求租";
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_tag isEqualToString:@"2000"]||[_biaozhi isEqualToString:@"商铺出租"]) {//商铺出租
        ShangPuDetailViewController *vc=[[ShangPuDetailViewController alloc]init];
        HeZuInfo *info =_houseArr[indexPath.row];
        vc.heZuInfo=info;
        vc.biaozhi=@"商铺出租";
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_tag isEqualToString:@"2001"]) {//写字楼
        ShangPuDetailViewController *vc=[[ShangPuDetailViewController alloc]init];
        HeZuInfo *info =_houseArr[indexPath.row];
        vc.heZuInfo=info;
        vc.biaozhi=@"写字楼出租";
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_tag isEqualToString:@"2002"]) {//厂房仓库土地
        ShangPuDetailViewController *vc=[[ShangPuDetailViewController alloc]init];
        HeZuInfo *info =_houseArr[indexPath.row];
        vc.heZuInfo=info;
        vc.biaozhi=@"厂房仓库土地";
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_tag isEqualToString:@"1001"]||[_biaozhi isEqualToString:@"合租"]) {//合租
        ZuFangDetailViewController *vc=[[ZuFangDetailViewController alloc]init];
        HeZuInfo *info =_houseArr[indexPath.row];
        vc.heZuInfo=info;
        vc.biaozhi=@"合租";
        [self.navigationController pushViewController:vc animated:YES];

    }else {//整租
        ZuFangDetailViewController *vc=[[ZuFangDetailViewController alloc]init];
        HeZuInfo *info =_houseArr[indexPath.row];
        vc.heZuInfo=info;
        vc.biaozhi=@"整租";
        [self.navigationController pushViewController:vc animated:YES];
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
