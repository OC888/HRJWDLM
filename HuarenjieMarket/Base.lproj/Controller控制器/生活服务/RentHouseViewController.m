//
//  RentHouseViewController.m
//  temp
//
//  Created by l x on 16/5/16.
//  Copyright (c) 2016年 wangli. All rights reserved.
//
#define SECTION0_HEIGHT (WIDTH-20*4)/4+20
#define SECTION1_HEIGHT 50*3
#define SECTION2_HEIGHT 40+50
#define SECTION3_HEIGHT 40
#define SECTION4_HEIGHT 40+50*7

#import "RentHouseViewController.h"
#import "RentHouseListTableViewCell.h"
#import "ResumHouseViewController.h"
#import "ZuFangListViewController.h"
#import "RentHouseDetailViewController.h"

@interface RentHouseViewController ()
{
    NSArray *_titleArr;
}
@property (nonatomic,strong) UISearchController *search;
@property (nonatomic,strong) NSMutableArray *resultArr;

@end

@implementation RentHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    self.search.searchBar.placeholder=@"搜索个人房源";
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
    ResumHouseViewController *vc =[[ResumHouseViewController alloc]init];
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
    tableView.tableFooterView=[[UIView alloc]init];
    tableView.separatorInset = UIEdgeInsetsMake(0,10, 0, 10);
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, CGFLOAT_MIN)];
    tableView.tableHeaderView=view;
    [tableView registerNib:[UINib nibWithNibName:@"RentHouseListTableViewCell" bundle:nil] forCellReuseIdentifier:@"RentHouse"];
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
        if (indexPath.row==0) {
            return 100;
        }
        return SECTION1_HEIGHT;
    }else if (indexPath.section==2)
    {
        return SECTION2_HEIGHT;
    }else if (indexPath.section==3)
    {
        return SECTION3_HEIGHT;
    }else
    {
        if (indexPath.row==0||indexPath.row==6) {
            return 40;
        }
            return 90;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==1) {
        return 2;
    }else if (section==4) {
        return 7;
    }else{
        return 1;
    }
}

#pragma mark tableViewDatasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==4) {
        if (indexPath.row==1||indexPath.row==2||indexPath.row==5||indexPath.row==3||indexPath.row==4) {
           RentHouseListTableViewCell *cell= (RentHouseListTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"RentHouseListTableViewCell" owner:self options:nil]  lastObject];
            cell.houseImageView.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tu" ofType:@"png"]];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    static NSString *cellID=@"cell";
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (indexPath.section==0) {
            NSArray *imageArr=@[@"house_zhengzu",@"house_hezu",@"house_shangpuchuzu"];
            _titleArr=@[@"整租",@"合租",@"商铺出租"];
            for (int i=0; i<3; i++) {
                UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
                int col =i%3;
                int row =i/3;
                button.frame =CGRectMake(WIDTH/14+WIDTH/6*2*col, WIDTH/7/4+WIDTH/7*row, WIDTH/6,WIDTH/6);
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[i]]] forState:UIControlStateNormal];
                button.imageEdgeInsets=UIEdgeInsetsMake(0, 10, 20, 10);
                [button addTarget:self action:@selector(topThreeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                button.tag=i+1;
                UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(-20, WIDTH/7/2+20, button.bounds.size.width+40, 20)];
                label.text=_titleArr[i];
                label.font=[UIFont systemFontOfSize:14.0];
                label.textAlignment=NSTextAlignmentCenter;
                [button addSubview:label];
                
                [cell addSubview:button];
            }
            
        }else if (indexPath.section==1) {
            if (indexPath.row==0) {
                UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
                imageView.image=[UIImage imageNamed:@"house_secondhouse"];
                [cell addSubview:imageView];
                UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
                label.text=@"租房";
                label.font=[UIFont systemFontOfSize:15.0];
                [cell addSubview:label];
                
                NSArray *imageArr=@[@"fangdong",@"gongyu"];
                for (int i=0; i<2; i++) {
                    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
                    int col =i%2;
                    int row =i/2;
                    button.frame =CGRectMake(5+col*(5+(WIDTH-30)/2), 40+(60+10)*row, (WIDTH-30)/2, 55);
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[i]]] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(rentHouseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                    button.tag=i+1;
                    [cell addSubview:button];
                }
            }else{
                NSArray *arr=@[@"整租",@"合租",@"短租日租",@"求租",@"个人房源",@"阳光主卧",@"精装修",@"独立卫浴",@"押一付一"];
                for (int i=0; i<9; i++) {
                    int col =i%3;
                    int row =i/3;
                    CarButton *button =[[CarButton alloc]initWithFrame:CGRectMake(col*WIDTH/3,10+((SECTION1_HEIGHT-10*4)/3+10)*row, WIDTH/3, (SECTION1_HEIGHT-10*4)/3)];
                    
                    [button addTarget:self action:@selector(carButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                    [button setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    button.tag=i+1000;
                    [cell addSubview:button];
                }
            }
        }else if (indexPath.section==2) {
            NSArray *arr=@[@"商铺出租",@"写字楼出租",@"厂房仓库土地"];
            [cell addSubview:[self creatViewWithHeight:SECTION2_HEIGHT withNumber:3 withRowNumber:3  withNsstring:@"商业地产" withImage:@"house_xiezilou" withArr:arr withTag:2000]];
        }else if (indexPath.section==3) {
            cell.textLabel.text=@"房产资讯";
            cell.textLabel.font=[UIFont systemFontOfSize:15.0];
            cell.detailTextLabel.text=@"二线城市房价上涨应属大概率";
            cell.detailTextLabel.font=[UIFont systemFontOfSize:14.0];
            cell.detailTextLabel.textColor=[UIColor lightGrayColor];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else{
            if (indexPath.row==0) {
                UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
                imageView.image=[UIImage imageNamed:@"house_hezu"];
                [cell addSubview:imageView];
                UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
                label.font=[UIFont systemFontOfSize:15.0];
                label.text=@"附近好房";
                [cell addSubview:label];
            }else if(indexPath.row==6){
                UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/3, 5, WIDTH/3, 40-10)];
                label.text=@"查看更多附近房源";
                label.font=[UIFont systemFontOfSize:12.0];
                label.textColor=BJCOLOR;
                [cell addSubview:label];
            }else{
            }
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==4) {
        if (indexPath.row==6) {
            ZuFangListViewController *vc=[[ZuFangListViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            SHOW_MESSAGE(@"数据加载中");
        }
    }
}
//顶部三个按钮
-(void)topThreeButtonClick:(UIButton *)button{
    NSString *str=_titleArr[button.tag-1];
    ZuFangListViewController *vc =[[ZuFangListViewController alloc]init];
    vc.placeholder=[NSString stringWithFormat:@"搜索%@",str];
    if (button.tag==1){
        vc.biaozhi=@"整租";
    }
    if (button.tag==2){
        vc.biaozhi=@"合租";
    }
    if (button.tag==3){
        vc.biaozhi=@"商铺出租";
    }
    [self.navigationController pushViewController:vc animated:YES];
}
//租房两个图片按钮
-(void)rentHouseButtonClick:(UIButton *)button{
    NSArray *titleArr=@[@"房东直租",@"精品公寓"];
    ZuFangListViewController *vc =[[ZuFangListViewController alloc]init];
    vc.placeholder=[NSString stringWithFormat:@"搜索%@",titleArr[button.tag-1]];
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIView *)creatTitleViewWithTitle:(NSString *)title withImageName:(NSString *)imageName{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]];
    [view addSubview:imageView];
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 50, 20)];
    label.text=[NSString stringWithFormat:@"%@",title];
    label.font=[UIFont systemFontOfSize:12.0];
    label.textColor=[UIColor greenColor];
    [view addSubview:label];

    return view;
}
//封装按钮方法
-(UIView *)creatViewWithHeight:(CGFloat)height withNumber:(int)num withRowNumber:(int)rowNumber withNsstring:(NSString*)title withImage:(NSString*)image withArr:(NSArray *)arr withTag:(int)tag{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, height)];
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",image]];
    [view addSubview:imageView];
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
    label.font=[UIFont systemFontOfSize:15.0];
    label.text=[NSString stringWithFormat:@"%@",title];
    [view addSubview:label];
    
    UILabel *drawLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 40, WIDTH-20, 1)];
    drawLabel.backgroundColor=[UIColor colorWithRed:200/255.0 green:190/255.0 blue:204/255.0 alpha:1];
    [view addSubview:drawLabel];
    
    for (int i=0; i<num; i++) {
        int col =i%rowNumber;
        int row =i/rowNumber;
        CarButton *button =[[CarButton alloc]initWithFrame:CGRectMake(col*WIDTH/3,50+((height-10*2)/3+10)*row, WIDTH/3, height-10*2-40)];
        
        [button addTarget:self action:@selector(carButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag=i+tag;
        [view addSubview:button];
    }
    return view;
}
-(void)carButtonClick:(CarButton *)button{
    ZuFangListViewController *vc =[[ZuFangListViewController alloc]init];
    vc.placeholder=[NSString stringWithFormat:@"搜索%@",button.titleLabel.text];
    vc.tag=[NSString stringWithFormat:@"%ld",(long)button.tag];
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
