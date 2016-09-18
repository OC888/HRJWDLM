//
//  FullTimeViewController.m
//  temp
//
//  Created by l x on 16/5/16.
//  Copyright (c) 2016年 wangli. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "FullTimeViewController.h"
#import "ResumeViewController.h"
#import "CarButton.h"
#import "JobListViewController.h"
#import "EatViewController.h"
#import "MetroViewController.h"
#import "AllJobsViewController.h"
#import "MoneyViewController.h"
#import "NearbyViewController.h"
#import "CompanyViewController.h"

@interface FullTimeViewController ()
{
    NSArray *_hotSectonButtonTitleArr;
    NSArray *_hotJobButtonTitleArr;
    NSArray *_moreJobButtonTextArr;
    NSArray *_moreJobButtonDetailTextArr;

}
@property (nonatomic,strong) UISearchController *search;
@property (nonatomic,strong) NSMutableArray *resultArr;

@end

@implementation FullTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor whiteColor];
    
    _hotSectonButtonTitleArr=@[@"双休",@"包吃住",@"地铁沿线",@"今日高薪",@"附近工作",@"放心企业"];
    _hotJobButtonTitleArr=@[@"技工／工人",@"销售",@"司机",@"导购",@"服务员",@"客服",@"房地产",@"保安",@"仓库管理",@"餐饮／酒店",@"营业员",@"快递员",@"跟单员",@"保险",@"淘宝职位",@"财务审计",@"行政／后勤",@"人力资源"];
    _moreJobButtonTextArr=@[@"变高富帅",@"稳拿高薪",@"快速入职",@"能逛商场"];
    _moreJobButtonDetailTextArr=@[@"高薪销售类",@"技工类",@"餐饮酒店类",@"超市百货类"];

    [self creatNavigationItem];
    [self creatTable];
    
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
    self.search.searchBar.placeholder=@"搜索全职工作";
    self.navigationItem.titleView=self.search.searchBar;
    
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithTitle:@"写简历" style:UIBarButtonItemStylePlain target:self action:@selector(writeRsume)];
    [rightItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
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
    UITableView *tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.sectionFooterHeight=9;
    tableView.sectionHeaderHeight=1;
    tableView.separatorInset = UIEdgeInsetsMake(0,10, 0, 10);

    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, CGFLOAT_MIN)];
    tableView.tableHeaderView=view;
    tableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:tableView];

}
#pragma mark tableViewdelegate
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0)
    {
        return 40;
    }else if (indexPath.section==1)
    {
        return 180;
    }else if (indexPath.section==2)
    {
        return 350;
    }else
    {
        return 210;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

#pragma mark tableViewDatasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID=@"cell";
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
        {
            cell.textLabel.text=@"查看全部职位";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 1:
        {
            UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
            imageView.image=[UIImage imageNamed:@"gremen-01"];
            [cell addSubview:imageView];
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
            label.text=@"热门专区";
            label.font=[UIFont systemFontOfSize:14.0];
            label.textColor=BJCOLOR;
            [cell addSubview:label];
            NSArray *picArr=@[@"weekends-01.png",@"eatandstay-01.png",@"subway-01.png",@"highsalary-01.png",@"local-01.png",@"safety-01.png"];
            for (int i=0; i<6; i++) {
                UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
                int col =i%3;
                int row =i/3;
                button.frame =CGRectMake(10+col*(10+(WIDTH-40)/3), 40+(60+10)*row, (WIDTH-40)/3, 60);
                [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",picArr[i]]] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(hotSectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:[NSString stringWithFormat:@"%@",_hotSectonButtonTitleArr[i]] forState:UIControlStateNormal];
                button.tag=i+1;
                button.titleLabel.font=[UIFont systemFontOfSize:20.0 weight:5.0];
                [cell addSubview:button];
            }
        }
            break;
        case 2:
        {
            UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
            imageView.image=[UIImage imageNamed:@"gremenzw-01"];
            [cell addSubview:imageView];
            UILabel *lineLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 40, WIDTH-20, 1)];
            lineLabel.backgroundColor=LINECOLOR;
            [cell addSubview:lineLabel];
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
            label.font=[UIFont systemFontOfSize:14.0];
            label.textColor=BJCOLOR;
            label.text=@"热门职位";
            [cell addSubview:label];
            
            for (int i=0; i<18; i++) {
                int col =i%3;
                int row =i/3;
                CarButton *button =[[CarButton alloc]initWithFrame:CGRectMake(col*WIDTH/3, 40+(40+10)*row, WIDTH/3, 40)];
                [button setTitle:[NSString stringWithFormat:@"%@",_hotJobButtonTitleArr[i]] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(hotJobButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.tag=i+6;
                [cell addSubview:button];
            }

        }
            break;
        case 3:
        {
            UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
            imageView.image=[UIImage imageNamed:@"gcheqita-01"];
            [cell addSubview:imageView];
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
            label.font=[UIFont systemFontOfSize:14.0];
            label.textColor=BJCOLOR;
            label.text=@"驰骋无疆，丰富你的选择";
            [cell addSubview:label];
            NSArray *picArr=@[@"ai.png",@"g.png",@"i.png",@"n.png"];
            NSArray *titleArr=@[@"销售",@"技工/工人",@"餐饮/酒店",@"营业员"];
            for (int i=0; i<4; i++) {
                UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
                int col =i%2;
                int row =i/2;
                button.frame =CGRectMake(10+col*(10+(WIDTH-30)/2), 50+(70+10)*row, (WIDTH-30)/2, 70);
                [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",picArr[i]]] forState:UIControlStateNormal];
                [button setBackgroundColor:[UIColor greenColor]];
                [button setTitle:[NSString stringWithFormat:@"%@",titleArr[i]] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                button.tag=i+25;
                [cell addSubview:button];
                
                UILabel *titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDTH/4, 20)];

                titleLabel.text=[NSString stringWithFormat:@"%@",_moreJobButtonTextArr[i]];
                [button addSubview:titleLabel];
                UILabel *detailLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 40, WIDTH/4, 20)];

                detailLabel.text=[NSString stringWithFormat:@"%@",_moreJobButtonDetailTextArr[i]];
                detailLabel.font=[UIFont systemFontOfSize:12.0];
                detailLabel.textColor=[UIColor redColor];
                [button addSubview:detailLabel];
                
                UIImageView *headerImageView =[[UIImageView alloc]initWithFrame:CGRectMake(10+WIDTH/4, 10, (WIDTH-30)/2-WIDTH/4, (WIDTH-30)/2-WIDTH/4)];
                headerImageView.image=[UIImage imageNamed:@""];
                [button addSubview:headerImageView];

            }
        }
            break;

        default:
            break;
    }
    
    return cell;
}
//点击cell触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        AllJobsViewController *vc =[[AllJobsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
    }
}
//热门专区按钮绑定方法
-(void)hotSectionButtonClick:(UIButton *)button{
    
    JobListViewController *VC =[[JobListViewController alloc]init];
    VC.placeholder=button.titleLabel.text;
    [self.navigationController pushViewController:VC animated:YES];
}
//热门专区职位绑定方法
-(void)hotJobButtonClick:(CarButton *)button{
    
    JobListViewController *VC =[[JobListViewController alloc]init];
    VC.placeholder=button.titleLabel.text;
    [self.navigationController pushViewController:VC animated:YES];
}
//更多职位绑定方法
-(void)moreButtonClick:(UIButton *)button{
    JobListViewController *VC =[[JobListViewController alloc]init];
    VC.placeholder=button.titleLabel.text;
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
