//
//  PartListViewController.m
//  temp
//
//  Created by l x on 16/6/3.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "PartListViewController.h"
#import "ResumeViewController.h"
#import "JobListTableViewCell.h"
#import "BoolButton.h"
#import "JobDetailViewController.h"

@interface PartListViewController ()

@property (nonatomic,strong) NSMutableArray *resultArr;
@property (nonatomic,strong) UISearchController *search;
@property (nonatomic,copy) NSMutableArray *arr;

@end

@implementation PartListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    MBProgressHUD *mb=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mb.mode=MBProgressHUDAnimationFade;
    mb.labelText=@"华人街努力加载中...";
    [AFHttpManager parserPartTimeWithTitle:self.placeholder withArr:^(NSMutableArray *resumeArr) {
        [mb hide:YES];
        if (resumeArr.count<=0||resumeArr[0]==nil) {
            SHOW_NOALERT(@"亲，暂时没有相关信息，快去发布吧");
        }
        _arr=resumeArr;
        [_tableView reloadData];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _arr=[NSMutableArray array];
    [self creatTable];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self creatNavigationItem];
}
//发送简历
-(void)sendResum:(UIButton *)button{
    
}
//创建导航栏按钮
-(void)creatNavigationItem{
    
    self.search =[[UISearchController alloc]initWithSearchResultsController:nil];
    self.search.searchBar.backgroundColor=[UIColor clearColor];
    self.search.searchBar.placeholder=[NSString stringWithFormat:@"搜索%@",_placeholder];
    self.search.searchBar.barTintColor=BJCOLOR;
    [self.search.searchBar sizeToFit];
    self.search.dimsBackgroundDuringPresentation=NO;
    self.search.searchResultsUpdater=self;
    self.search.hidesNavigationBarDuringPresentation = NO;
    self.search.searchBar.layer.masksToBounds=YES;
    self.search.searchBar.layer.cornerRadius=14;
    self.navigationItem.titleView=self.search.searchBar;
    
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithTitle:@"写简历" style:UIBarButtonItemStylePlain target:self action:@selector(writeRsume)];
    [rightItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem=rightItem;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
//返回按钮
-(void)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
//导航右栏按钮绑定方法
-(void)writeRsume{
    
    ResumeViewController *resumeVC=[[ResumeViewController alloc]init];
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
    self.tableView.rowHeight=100;
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.tableView.tag=2;
    [self.view addSubview:self.tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JobListTableViewCell *cell = (JobListTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell)
    {
        cell= (JobListTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"JobListTableViewCell" owner:self options:nil]  lastObject];
    }
    [cell.checkButton setBackgroundImage:[UIImage imageNamed:@"gremen-01"] forState:UIControlStateNormal];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    PartTimeInfo *info =_arr[indexPath.row];
    cell.titleLabel.text=info.title;
    cell.moneyLabel.text=info.dec_xinzi;
    cell.detailLabel.text=[NSString stringWithFormat:@"招聘%@人 经验%@ %@学历",info.i_zhaopinrenshu,info.gongzuonianxian,info.xueli];
    cell.companyLabel.text=info.gongsiname;
    cell.addressLabel.text=info.gongzuodidian;
    cell.timeLabel.text=info.dt_datetime;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JobDetailViewController *vc=[[JobDetailViewController alloc]init];
    vc.partTimeInfo=_arr[indexPath.row];
    vc.tableViewtagStr=[NSString stringWithFormat:@"%ld",(long)self.tableView.tag];
    [self.navigationController pushViewController:vc animated:YES];
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
