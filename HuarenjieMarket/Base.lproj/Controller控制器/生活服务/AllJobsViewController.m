//
//  AllJobsViewController.m
//  temp
//
//  Created by l x on 16/5/21.
//  Copyright © 2016年 wangli. All rights reserved.
//
#define SECTION0_HEIGHT 30+50*5
#define SECTION1_HEIGHT 30+50*3
#define SECTION2_HEIGHT 30+50*4
#define SECTION3_HEIGHT 30+50*2

#import "AllJobsViewController.h"
#import "JobListViewController.h"
#import "ResumeViewController.h"

@interface AllJobsViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating>
{
    UITableView *_tableView;
    NSArray *arr1;
    NSArray *arr2;
    NSArray *arr3;
    NSArray *arr4;
}
@property (nonatomic,strong) UISearchController *search;
@property (nonatomic,strong) NSMutableArray *resultArr;

@end

@implementation AllJobsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatTable];
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
    self.search.searchBar.placeholder=@"搜索全职工作";
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

-(void)creatTable{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0 , WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.sectionFooterHeight=5;
    _tableView.sectionHeaderHeight=5;
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, CGFLOAT_MIN)];
    _tableView.tableHeaderView=view;
    _tableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return SECTION0_HEIGHT;
    }else if (indexPath.section==1) {
        return SECTION1_HEIGHT;
    }else if (indexPath.section==2) {
        return SECTION2_HEIGHT;
    }else{
        return SECTION3_HEIGHT;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    arr1=@[@"销售",@"司机",@"人事/行政",@"客服",@"财务/审计",@"房地产",@"淘宝职位",@"保险",@"翻译",@"物业",@"金融/证券",@"市场/公关",@"编辑",@"广告/会展",@"法律"];
    arr2=@[@"零售/百货",@"餐饮/酒店",@"家政/安保",@"美容/美发",@"医疗/医药",@"保健按摩",@"旅游",@"运动健身"];
    arr3=@[@"技工/工人",@"贸易/物流",@"汽车行业",@"机械",@"生产/制造",@"网络/通信",@"建筑/装修",@"电气/能源",@"农/林/牧/渔",@"生物工程",@"环保"];
    arr4=@[@"咨询/顾问",@"设计/创意",@"教育/培训",@"媒体/影视"];

    static NSString *cellID=@"cell";
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (indexPath.section==0)
        {
            [cell addSubview:[self creatViewWithHeight:SECTION0_HEIGHT withNumber:15 withRowNumber:3  withNsstring:@"商务/营销" withImage:@"gbianmin-01" withArr:arr1 withTag:100]];
        }else if (indexPath.section==1)
        {
            [cell addSubview:[self creatViewWithHeight:SECTION1_HEIGHT withNumber:8 withRowNumber:3 withNsstring:@"生活/服务" withImage:@"gremenzw-01" withArr:arr2 withTag:200]];
        }else if (indexPath.section==2)
        {
            [cell addSubview:[self creatViewWithHeight:SECTION2_HEIGHT withNumber:11 withRowNumber:3 withNsstring:@"技术/制造" withImage:@"gweixiu-01" withArr:arr3 withTag:300]];
            
        }else{
            [cell addSubview:[self creatViewWithHeight:SECTION3_HEIGHT withNumber:4 withRowNumber:3 withNsstring:@"艺术/教育" withImage:@"gchezixun-01" withArr:arr4 withTag:300]];
        }
    }
    return cell;
}
//封装按钮方法
-(UIView *)creatViewWithHeight:(CGFloat)height withNumber:(int)num withRowNumber:(int)rowNumber withNsstring:(NSString*)title withImage:(NSString*)image withArr:(NSArray *)arr withTag:(int)tag{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, height)];
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",image]];
    [view addSubview:imageView];
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
    label.font=[UIFont systemFontOfSize:14.0];
    label.textColor=BJCOLOR;
    label.text=[NSString stringWithFormat:@"%@",title];
    [view addSubview:label];
    
    UILabel *drawLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 40, WIDTH-20, 1)];
    drawLabel.backgroundColor=[UIColor colorWithRed:200/255.0 green:190/255.0 blue:204/255.0 alpha:1];
    [view addSubview:drawLabel];
    
    for (int i=0; i<num; i++) {
        int col =i%rowNumber;
        int row =i/rowNumber;
        CarButton *button =[[CarButton alloc]initWithFrame:CGRectMake(col*WIDTH/3,40+(230-20-30)/4*row, WIDTH/3, (230-20-30)/4)];
        
        [button addTarget:self action:@selector(carButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag=i+tag;
        [view addSubview:button];
    }
    return view;
}
-(void)carButtonClick:(CarButton *)button{
    
    JobListViewController *vc=[[JobListViewController alloc]init];
    vc.placeholder=[NSString stringWithFormat:@"%@",button.titleLabel.text];
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
