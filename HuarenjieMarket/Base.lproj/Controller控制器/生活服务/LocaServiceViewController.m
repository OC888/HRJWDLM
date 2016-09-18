//
//  LocaServiceViewController.m
//  temp
//
//  Created by l x on 16/5/16.
//  Copyright (c) 2016年 wangli. All rights reserved.
//

#import "LocaServiceViewController.h"
#import "changeButtonView.h"
#import "JobListViewController.h"

#define SECTION_HEIGHT 30+50*4
#define SECTION1_HEIGHT 30+50
#define SECTION2_HEIGHT 30+50
#define SECTION3_HEIGHT 30+50*2
#define SECTION4_HEIGHT 30+50
#define SECTION5_HEIGHT 30+50
#define SECTION6_HEIGHT 30+50*3

@interface LocaServiceViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating>
{
    UITableView *_leftTableView;
    UITableView *_rightTableView;
    CGSize rect;
}
@property (nonatomic,strong) UISearchController *search;
@property (nonatomic,strong) NSMutableArray *resultArr;

@property (nonatomic,strong) changeButtonView *buttonView;


@end

@implementation LocaServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatTopView];
    [self creatLeftTable];
    [self creatRightTable];
    [self creatNavigationItem];
    _rightTableView.hidden=YES;

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
    self.search.searchBar.placeholder=@"搜索本地服务";
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

//创建顶部切换页面View
-(void)creatTopView{
    changeButtonView *buttonView =[[changeButtonView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 40)];
    NSArray *titleArr=@[@"生活家政",@"本地服务"];
    [buttonView createWithTitleArr:titleArr];
    for (UIButton *button in buttonView.buttonArr) {
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:buttonView];
    self.buttonView=buttonView;
}
//顶部View上button绑定的方法
-(void)buttonClick:(UIButton *)button{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    self.buttonView.littleView.center=CGPointMake(button.center.x, button.center.y+button.bounds.size.height/2);
    [UIView commitAnimations];
    if (button.tag==1) {
        _leftTableView.hidden=NO;
        _rightTableView.hidden=YES;
    }else{
        _leftTableView.hidden=YES;
        _rightTableView.hidden=NO;
    }
}
-(void)creatLeftTable{
    _leftTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40 , WIDTH, HEIGHT-40) style:UITableViewStyleGrouped];
    _leftTableView.delegate=self;
    _leftTableView.dataSource=self;
    _leftTableView.sectionFooterHeight=5;
    _leftTableView.sectionHeaderHeight=5;
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, CGFLOAT_MIN)];
    _leftTableView.tableHeaderView=view;
    _leftTableView.tag=1;
    _leftTableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:_leftTableView];
}
-(void)creatRightTable{
    _rightTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40 , WIDTH, HEIGHT-40) style:UITableViewStyleGrouped];
    _rightTableView.delegate=self;
    _rightTableView.dataSource=self;
    _rightTableView.sectionFooterHeight=5;
    _rightTableView.sectionHeaderHeight=5;
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, CGFLOAT_MIN)];
    _rightTableView.tableHeaderView=view;
    _rightTableView.tag=2;
    _rightTableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:_rightTableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag==1) {
        return 7;
    }else{
        return 8;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag==1) {
        if (indexPath.section==0) {
            return 200;
        }else if (indexPath.section==1) {
            return SECTION1_HEIGHT;
        }else if (indexPath.section==2) {
            return SECTION2_HEIGHT;
        }else if (indexPath.section==3) {
            return SECTION3_HEIGHT;
        }else if (indexPath.section==4) {
            return SECTION4_HEIGHT;
        }else if (indexPath.section==5) {
            return SECTION5_HEIGHT;
        }else  {
            return SECTION6_HEIGHT;
        }
    }else{
        if (indexPath.section==0) {
            return 200;
        }else if (indexPath.section==1) {
            return SECTION1_HEIGHT;
        }else if (indexPath.section==2) {
            return SECTION2_HEIGHT;
        }else if (indexPath.section==3) {
            return SECTION6_HEIGHT;
        }else if (indexPath.section==4) {
            return SECTION4_HEIGHT;
        }else if (indexPath.section==5) {
            return SECTION5_HEIGHT;
        }else if (indexPath.section==6) {
            return SECTION5_HEIGHT;
        }else{
            return SECTION3_HEIGHT;
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cell";
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (tableView.tag==1) {
        switch (indexPath.section) {
            case 0:
            {
                UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
                imageView.image=[UIImage imageNamed:@"gremen-01"];
                [cell addSubview:imageView];
                UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
                label.text=@"热门专区";
                label.font=[UIFont systemFontOfSize:14.0];
                label.textColor=BJCOLOR;
                [cell addSubview:label];
                NSArray *picArr=@[@"banjia-01.png",@"weixiu-01.png",@"baojie-01.png",@"wuliu-01.png"];
                NSArray *hotSectonButtonTitleArr=@[@"搬家",@"家电维修",@"保洁",@"快递物流"];
                for (int i=0; i<4; i++) {
                    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
                    int col =i%2;
                    int row =i/2;
                    button.frame =CGRectMake(10+col*(10+(WIDTH-30)/2), 40+(70+10)*row, (WIDTH-30)/2, 70);
                    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",picArr[i]]] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(Table1HotSectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                    [button setTitle:[NSString stringWithFormat:@"%@",hotSectonButtonTitleArr[i]] forState:UIControlStateNormal];
                    button.tag=i+1;
                    button.titleLabel.font=[UIFont systemFontOfSize:20.0 weight:5.0];
                    [cell addSubview:button];
                }
            }
                break;
            case 1:
            {
                NSArray *arr=@[@"金杯搬家",@"居民搬家",@"长途搬家"];
                UIView *view =[self creatViewWithHeight:SECTION1_HEIGHT withNumber:3 withRowNumber:3  withNsstring:@"搬家" withImage:@"gbanjia-01" withArr:arr withTag:100];
                [cell addSubview:view];
            }
                break;
            case 2:
            {
                NSArray *arr=@[@"月嫂",@"保姆",@"保洁"];
                UIView *view =[self creatViewWithHeight:SECTION2_HEIGHT withNumber:3 withRowNumber:3 withNsstring:@"家政" withImage:@"gjiazheng-01" withArr:arr withTag:200];
                [cell addSubview:view];
            }
                break;
            case 3:
            {
                NSArray *arr=@[@"家电维修",@"电脑维修",@"手机维修",@"家具维修",@"房屋维修"];
                UIView *view =[self creatViewWithHeight:SECTION3_HEIGHT withNumber:5 withRowNumber:3 withNsstring:@"维修" withImage:@"gweixiu-01" withArr:arr withTag:300];
                [cell addSubview:view];
            }
                break;
            case 4:
            {
                NSArray *arr=@[@"快递",@"货运",@"国内"];
                UIView *view =[self creatViewWithHeight:SECTION4_HEIGHT withNumber:3 withRowNumber:3  withNsstring:@"物流" withImage:@"gwuliu-01" withArr:arr withTag:400];
                [cell addSubview:view];
            }
                break;
            case 5:
            {
                NSArray *arr=@[@"生活配送",@"开锁",@"疏通打孔"];
                UIView *view =[self creatViewWithHeight:SECTION5_HEIGHT withNumber:3 withRowNumber:3 withNsstring:@"便民" withImage:@"gbianmin-01" withArr:arr withTag:500];
                [cell addSubview:view];
            }
                break;
            case 6:
            {
                NSArray *arr=@[@"装修",@"建材",@"装修效果图",@"租车",@"免费量房",@"二手回收",@"婚庆",@"旅游",@"招商加盟"];
                UIView *view =[self creatViewWithHeight:SECTION6_HEIGHT withNumber:9 withRowNumber:3  withNsstring:@"其他服务" withImage:@"gremenzw-01" withArr:arr withTag:600];
                [cell addSubview:view];
            }
                break;
 
            default:
                break;
        }
    }else{
        switch (indexPath.section) {
            case 0:
            {
                UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
                imageView.image=[UIImage imageNamed:@"gremen-01"];
                [cell addSubview:imageView];
                UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
                label.text=@"热门";
                label.font=[UIFont systemFontOfSize:14.0];
                label.textColor=BJCOLOR;
                [cell addSubview:label];
                NSArray *picArr=@[@"zhuangxiu-02.png",@"zuche-01.png",@"jiameng-01.png",@"zhiye-01.png"];
                NSArray *hotSectonButtonTitleArr=@[@"装修",@"租车",@"招商加盟",@"职业培训"];
                for (int i=0; i<4; i++) {
                    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
                    int col =i%2;
                    int row =i/2;
                    button.frame =CGRectMake(10+col*(10+(WIDTH-30)/2), 40+(70+10)*row, (WIDTH-30)/2, 70);
                    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",picArr[i]]] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(Table2HotSectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                    [button setTitle:[NSString stringWithFormat:@"%@",hotSectonButtonTitleArr[i]] forState:UIControlStateNormal];
                    button.tag=i+1;
                    button.titleLabel.font=[UIFont systemFontOfSize:20.0 weight:5.0];
                    [cell addSubview:button];
                }
            }
                break;
            case 1:
            {
                NSArray *arr=@[@"家庭装修",@"公司装修",@"效果图"];
                UIView *view =[self creatViewWithHeight:SECTION1_HEIGHT withNumber:3 withRowNumber:3  withNsstring:@"装修" withImage:@"zhuangxiu-01" withArr:arr withTag:1000];
                [cell addSubview:view];
            }
                break;
            case 2:
            {
                NSArray *arr=@[@"门窗",@"家具",@"窗帘"];
                UIView *view =[self creatViewWithHeight:SECTION2_HEIGHT withNumber:3 withRowNumber:3 withNsstring:@"建材" withImage:@"gjiancai-01" withArr:arr withTag:2000];
                [cell addSubview:view];
            }
                break;
            case 3:
            {
                NSArray *arr=@[@"租车",@"驾校",@"陪练",@"汽车保养",@"过户上牌",@"年检验车",@"代驾"];
                UIView *view =[self creatViewWithHeight:SECTION6_HEIGHT withNumber:7 withRowNumber:3 withNsstring:@"汽车服务" withImage:@"gche-01" withArr:arr withTag:3000];
                [cell addSubview:view];
            }
                break;
            case 4:
            {
                NSArray *arr=@[@"策划",@"婚车",@"主持"];
                UIView *view =[self creatViewWithHeight:SECTION4_HEIGHT withNumber:3 withRowNumber:3  withNsstring:@"婚庆" withImage:@"ghunqing-01" withArr:arr withTag:4000];
                [cell addSubview:view];
            }
                break;
            case 5:
            {
                NSArray *arr=@[@"婚纱",@"儿童",@"商业"];
                UIView *view =[self creatViewWithHeight:SECTION5_HEIGHT withNumber:3 withRowNumber:3 withNsstring:@"摄影" withImage:@"gsheying-01" withArr:arr withTag:5000];
                [cell addSubview:view];
            }
                break;
            case 6:
            {
                NSArray *arr=@[@"旅行社",@"酒店机票",@"民宿预订"];
                UIView *view =[self creatViewWithHeight:SECTION1_HEIGHT withNumber:3 withRowNumber:3  withNsstring:@"旅游" withImage:@"lvyou-01" withArr:arr withTag:6000];
                [cell addSubview:view];
            }
                break;
            case 7:
            {
                NSArray *arr=@[@"餐饮美食",@"运动健身",@"美容美体",@"休闲娱乐",@"养生保健"];
                UIView *view =[self creatViewWithHeight:SECTION3_HEIGHT withNumber:5 withRowNumber:3  withNsstring:@"餐饮娱乐" withImage:@"gremenzw-01" withArr:arr withTag:6000];
                [cell addSubview:view];
            }
                break;
                
            default:
                break;
        }
    }
    return cell;
}
//点击cell触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        JobListViewController *vc =[[JobListViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSLog(@"111");
    }
}
//table1热门专区按钮绑定方法
-(void)Table1HotSectionButtonClick:(UIButton *)button{
    
}

//table2热门专区按钮绑定方法
-(void)Table2HotSectionButtonClick:(UIButton *)button{

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
        CarButton *button =[[CarButton alloc]initWithFrame:CGRectMake(col*WIDTH/3,40+(SECTION_HEIGHT-20-30)/4*row, WIDTH/3, (SECTION_HEIGHT-20-30)/4)];
        
        [button addTarget:self action:@selector(carButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag=i+tag;
        [view addSubview:button];
    }
    return view;
}

-(void)carButtonClick:(CarButton *)button{
    
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
