//
//  AllResumeViewViewController.m
//  temp
//
//  Created by l x on 16/5/26.
//  Copyright © 2016年 wangli. All rights reserved.
//
#define SECTION0_HEIGHT 30+50*5
#define SECTION1_HEIGHT 30+50*3
#define SECTION2_HEIGHT 30+50*4
#define SECTION3_HEIGHT 30+50*2

#import "AllResumeViewViewController.h"
#import "AllResumeListViewController.h"
#import "ResumeInfo.h"
#import "ZhaoPinViewController.h"

@interface AllResumeViewViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating>
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

@implementation AllResumeViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"选择职位";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    [self creatTable];
    [self creatTable];
    [self creatSendButton];
    [self creatNavItem];
}
//导航栏配置
-(void)creatNavItem{
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds=CGRectMake(0, 0, 50, 40);
    [button setTitle:@"我的招聘" forState:UIControlStateNormal];
    button.titleLabel.numberOfLines=2;
    [button addTarget:self action:@selector(wodezhaopin) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=rightItem;
    
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
-(void)wodezhaopin{
    
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

//创建跳出发布招聘按钮
-(void)creatSendButton{
    self.sendButton =[UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame=CGRectMake(WIDTH/2-WIDTH/5/2, HEIGHT/6*5, WIDTH/5, WIDTH/5);
    [self.sendButton setBackgroundImage:[UIImage imageNamed:@"fabuzhaopin"] forState:UIControlStateNormal];
    [self.sendButton addTarget:self action:@selector(sendResum:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendButton];
}
//发布招聘
-(void)sendResum:(UIButton *)button{
    ZhaoPinViewController *vc =[[ZhaoPinViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)creatTable{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0 , WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.sectionFooterHeight=5;
    _tableView.sectionHeaderHeight=5;
    _tableView.tableFooterView=[[UIView alloc]init];
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, CGFLOAT_MIN)];
    _tableView.tableHeaderView=view;
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
    
    if ([_delegate respondsToSelector:@selector(chooseZhiWeiWithButtonTitle:)]) {
        [_delegate chooseZhiWeiWithButtonTitle:button.titleLabel.text];
    }
    AllResumeListViewController *vc =[[AllResumeListViewController alloc]init];
    vc.placeholder=button.titleLabel.text;
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
