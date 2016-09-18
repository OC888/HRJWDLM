//
//  ErShouGoodsListViewController.m
//  temp
//
//  Created by l x on 16/5/22.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ErShouGoodsListViewController.h"
#import "ResumeGoodsViewController.h"
#import "GoodsListTableViewCell.h"
#import "GoodsDetailViewController.h"

@interface ErShouGoodsListViewController ()<UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *resultArr;
@property (nonatomic,strong) UISearchController *search;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) NSMutableArray *goodsArr;

@end

@implementation ErShouGoodsListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    MBProgressHUD *mb=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mb.mode=MBProgressHUDAnimationFade;
    mb.labelText=@"华人街努力加载中...";
    [AFHttpManager parserErShouGoodsWithTitle:_placeholder withArr:^(NSMutableArray *resumeArr) {
        [mb hide:YES];
        if (resumeArr.count<=0||resumeArr[0]==nil) {
            SHOW_NOALERT(@"亲，暂时没有相关信息，快去发布吧");
        }

        _goodsArr=resumeArr;
        [_tableView reloadData];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatNavigationItem];
    [self creatTable];
    _goodsArr=[NSMutableArray array];
}
//创建导航栏按钮
-(void)creatNavigationItem{
    
    self.search =[[UISearchController alloc]initWithSearchResultsController:nil];
    self.search.searchBar.backgroundColor=[UIColor clearColor];
    self.search.searchBar.placeholder=_placeholder;
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
    
     ResumeGoodsViewController * resumeVC=[[ResumeGoodsViewController alloc]init];
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
//创建表
-(void)creatTable{
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.rowHeight=90;
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _goodsArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsListTableViewCell *cell = (GoodsListTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell)
    {
        cell= (GoodsListTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"GoodsListTableViewCell" owner:self options:nil]  lastObject];
    }
    ErShouGoods *erShouGood =_goodsArr[indexPath.row];
    [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:erShouGood.img1] placeholderImage:[UIImage imageNamed:@"tu.png"] options:SDWebImageRefreshCached];
    cell.goodsTitleLabel.text=erShouGood.title;
    cell.goodsPriceLabel.text=[NSString stringWithFormat:@"%@元",erShouGood.dec_jiage];
    cell.goodsDetailLabel.text=[NSString stringWithFormat:@"%@ %@",erShouGood.quyu,erShouGood.laiyuan];
    cell.goodsTimeLabel.text=erShouGood.dt_datetime;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsDetailViewController *VC=[[GoodsDetailViewController alloc]init];
    VC.erShouGood=_goodsArr[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
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
