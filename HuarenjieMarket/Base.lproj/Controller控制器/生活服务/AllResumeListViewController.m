//
//  AllResumeListViewController.m
//  temp
//
//  Created by l x on 16/5/26.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "AllResumeListViewController.h"
#import "ResumeListTableViewCell.h"
#import "ResumeDetailViewController.h"
#import "ResumeInfo.h"

@interface AllResumeListViewController ()<UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *resultArr;
@property (nonatomic,strong) UISearchController *search;
@property (nonatomic,strong) NSMutableArray *arr;

@end

@implementation AllResumeListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    MBProgressHUD *mb=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mb.mode=MBProgressHUDAnimationFade;
    mb.labelText=@"华人街努力加载中...";
    [AFHttpManager parserResumeInfoWithTitle:_placeholder withArr:^(NSMutableArray *resumeArr) {
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
    // Do any additional setup after loading the view from its nib.
    [self creatNavigationItem];
    [self creatTable];
    
    _resultArr=[NSMutableArray arrayWithCapacity:0];
}
//创建导航栏按钮
-(void)creatNavigationItem{
    self.search =[[UISearchController alloc]initWithSearchResultsController:nil];
    self.search.searchBar.backgroundColor=[UIColor clearColor];
    self.search.searchBar.barTintColor=BJCOLOR;
    [self.search.searchBar sizeToFit];
    self.search.dimsBackgroundDuringPresentation=NO;
    self.search.searchResultsUpdater=self;
    self.search.searchBar.delegate=self;
    self.search.hidesNavigationBarDuringPresentation = NO;
    self.search.searchBar.layer.masksToBounds=YES;
    self.search.searchBar.layer.cornerRadius=14;
    self.search.searchBar.placeholder=_placeholder;
    self.navigationItem.titleView=self.search.searchBar;
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
#pragma mark searchResultsUpdater
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [_resultArr removeAllObjects];

    NSString *filterString = searchController.searchBar.text;
    NSMutableArray *nameArr =[[NSMutableArray alloc]initWithCapacity:0];
    for (ResumeInfo *info in _arr) {
        [nameArr addObject:info.name];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@", filterString];
        
        NSMutableArray *nameResultArr = [NSMutableArray arrayWithArray:[nameArr filteredArrayUsingPredicate:predicate]];
        for (NSString *name in nameResultArr) {
            if ([info.name isEqualToString:name]) {
                [_resultArr addObject:info];
            }
        }
    }
    [self.tableView reloadData];
}
//创建表
-(void)creatTable{
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.rowHeight=80;
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_search.active) {
        return _resultArr.count;
    }else{
        return _arr.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ResumeListTableViewCell *cell = (ResumeListTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell)
    {
        cell= (ResumeListTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"ResumeListTableViewCell" owner:self options:nil]  lastObject];
    }
    ResumeInfo *resumeInfo;
    if (_search.active) {
        resumeInfo =[_resultArr objectAtIndex:indexPath.row];
    }else{
        resumeInfo =[_arr objectAtIndex:indexPath.row];
    }
    NSString *string =[[resumeInfo.birthday componentsSeparatedByString:@" "] firstObject];
    int birthYear =[string intValue];
    
    NSDate *currentDate =[NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSString *fabutime=[formatter stringFromDate:currentDate];
    int currentYear=[fabutime intValue];
    
    cell.titlleLabel.text=[NSString stringWithFormat:@"%@ %@ %d岁 求职%@",resumeInfo.name,resumeInfo.sex,currentYear-birthYear,resumeInfo.zhiwei];
    cell.detailLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@元",resumeInfo.biaozhi,resumeInfo.xueli,resumeInfo.gongzuonianxian,resumeInfo.salary];
    cell.otherLabel.text=[NSString stringWithFormat:@"发布时间：%@ 期望工作地点：%@",resumeInfo.fabutime,resumeInfo.gongzuoquyu];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ResumeDetailViewController *vc=[[ResumeDetailViewController alloc]init];
    ResumeInfo *resumeInfo =[_arr objectAtIndex:indexPath.row];
    vc.resumeInfo=resumeInfo;
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
