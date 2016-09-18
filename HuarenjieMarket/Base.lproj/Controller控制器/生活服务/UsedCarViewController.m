//
//  UsedCarViewController.m
//  temp
//
//  Created by l x on 16/5/16.
//  Copyright (c) 2016年 wangli. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define SECTION0_HEIGHT 30+50*2
#define SECTION1_HEIGHT 30+50*4
#define SECTION2_HEIGHT 30+50*2
#define SECTION3_HEIGHT 30+50*2
#define SECTION4_HEIGHT 30+50*2

#import "UsedCarViewController.h"
#import "CarButton.h"
#import "SelectCarButton.h"
#import "ResumeCarViewController.h"
#import "CarListViewController.h"
#import "CarDetailViewController.h"

@interface UsedCarViewController ()
{
    NSArray *arr1;
    NSArray *arr2;
    NSArray *arr3;

}
@property (nonatomic,strong) UISearchController *search;
@property (nonatomic,strong) NSMutableArray *resultArr;

@end

@implementation UsedCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    arr1=@[@"全部品牌",@"大众",@"丰田",@"5-10万",@"10-15万",@"20-25万",@"2年以内",@"5年以内",@"8年以内",@"小轿车",@"越野车SUV",@"商务车SUV"];
    arr2=@[@"自行车",@"摩托车",@"电动车",@"货车工程车",@"拖拉机",@"新车买卖"];
    arr3=@[@"拼车",@"车辆配件",@"驾校",@"汽车培练",@"租车代驾",@"外迁查询"];
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
    self.search.searchBar.placeholder=@"搜索二手车";
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
    
    ResumeCarViewController *vc=[[ResumeCarViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//搜索
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
        return SECTION0_HEIGHT;
    }else if (indexPath.section==1)
    {
        return SECTION1_HEIGHT;
    }else if (indexPath.section==2)
    {
        return SECTION2_HEIGHT;
    }else if (indexPath.section==3)
    {
        return SECTION3_HEIGHT;
    }else
    {
        if (indexPath.row==0) {
            return 40;
        }else{
            return (WIDTH-20*4)/3+10;
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==4) {
        return 2;
    }else{
    return 1;
    }
}

#pragma mark tableViewDatasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID=@"cell";
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (indexPath.section==0) {
            UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
            imageView.image=[UIImage imageNamed:@"gremen-01"];
            [cell addSubview:imageView];
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
            label.text=@"推荐";
            label.font=[UIFont systemFontOfSize:14.0];
            label.textColor=BJCOLOR;
            [cell addSubview:label];
            
            NSArray *titleArr=@[@"gerenche-01",@"pinggu-01"];
            for (int i=0; i<2; i++) {
                UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
                int col =i%2;
                int row =i/2;
                button.frame =CGRectMake(10+col*(10+(WIDTH-30)/2), 40+(60+10)*row, (WIDTH-30)/2, 80);
                button.layer.borderWidth=1;
                button.layer.borderColor=[UIColor orangeColor].CGColor;
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",titleArr[i]]] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(recommendedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                button.tag=i+1;
                [cell addSubview:button];
            }

        }else if (indexPath.section==1)
        {
            [cell addSubview:[self creatViewWithHeight:SECTION1_HEIGHT withNumber:12 withRowNumber:3  withNsstring:@"二手车" withImage:@"gche-01" withArr:arr1 withTag:100]];
        }else if (indexPath.section==2)
        {
            [cell addSubview:[self creatViewWithHeight:SECTION2_HEIGHT withNumber:6 withRowNumber:3 withNsstring:@"其他车辆" withImage:@"gremenzw-01" withArr:arr2 withTag:200]];
        }else if (indexPath.section==3)
        {
            [cell addSubview:[self creatViewWithHeight:SECTION2_HEIGHT withNumber:6 withRowNumber:3 withNsstring:@"车辆服务" withImage:@"gchefuwu-01" withArr:arr3 withTag:300]];

        }else
        {
            if (indexPath.row==0) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text=@"精选车源";
                cell.textLabel.font=[UIFont systemFontOfSize:14.0];
                cell.textLabel.textColor=[UIColor orangeColor];
            }else{
                NSArray *carNameArr=@[@"奥迪",@"丰田",@"福特"];
                NSArray *carPriceArr=@[@"26万",@"7.88万",@"4.81万"];
                for (int i=0; i<3; i++) {
                    int col=i%3;
                    SelectCarButton *button =[[SelectCarButton alloc]initWithFrame:CGRectMake(20+((WIDTH-20*4)/3+20)*col, 10, (WIDTH-20*4)/3, (WIDTH-20*4)/3)];
                    button.carImageView.image=[UIImage imageNamed:@"tu"];
                    button.carNameLable.text=[NSString stringWithFormat:@"%@",carNameArr[i]];
                    button.carPriceLable.text=[NSString stringWithFormat:@"%@",carPriceArr[i]];

                    [button addTarget:self action:@selector(selectCarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                    button.tag=i+1;
                    [cell.contentView addSubview:button];
                }
            }
        }
//        else{
//            if (indexPath.row==0) {
//                UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
//                imageView.image=[UIImage imageNamed:@"gchezixun-01"];
//                [cell addSubview:imageView];
//                UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
//                label.font=[UIFont systemFontOfSize:14.0];
//                label.textColor=BJCOLOR;
//                label.text=@"车辆资讯";
//                [cell addSubview:label];
//                
//            }else if (indexPath.row==1) {
//                cell.imageView.image=[UIImage imageNamed:@"bendi"];
//                cell.textLabel.text=@"待补充";
//                cell.detailTextLabel.text=@"待补充";
//            }else if (indexPath.row==4) {
//                cell.textLabel.text=@"查看更多";
//            }else{
//                cell.textLabel.text=@"待补充";
//            }
//
//        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==4&&indexPath.row==0) {
        CarListViewController *vc=[[CarListViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
//精选车源按钮
-(void)selectCarButtonClick:(UIButton *)button{
//     CarDetailViewController*vc=[[CarDetailViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    SHOW_MESSAGE(@"数据加载中...");
}
-(void)recommendedButtonClick:(UIButton *)button{
    CarListViewController *vc=[[CarListViewController alloc]init];
    vc.placeholder=[NSString stringWithFormat:@"搜索%@",button.titleLabel.text];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        CarButton *button =[[CarButton alloc]initWithFrame:CGRectMake(col*WIDTH/3,40+(SECTION1_HEIGHT-20-30)/4*row, WIDTH/3, (SECTION1_HEIGHT-20-30)/4)];

        [button addTarget:self action:@selector(carButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag=i+tag;
        [view addSubview:button];
    }
    return view;
}
-(void)carButtonClick:(UIButton *)button{
    
    CarListViewController *vc=[[CarListViewController alloc]init];
    vc.placeholder=[NSString stringWithFormat:@"搜索%@",button.titleLabel.text];
    [self.navigationController pushViewController:vc animated:YES];
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
