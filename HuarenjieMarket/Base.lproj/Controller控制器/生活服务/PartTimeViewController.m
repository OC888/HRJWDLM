//
//  PartTimeViewController.m
//  temp
//
//  Created by l x on 16/5/16.
//  Copyright (c) 2016年 wangli. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "PartTimeViewController.h"
#import "JobButton.h"
#import "ResumeViewController.h"
#import "DayPayViewController.h"
#import "LongTimeViewController.h"
#import "PartListViewController.h"
#import "JianZhiResumeViewController.h"

@interface PartTimeViewController ()
{
    NSArray *_imageNameArr;
    NSArray *_buttonTitleArr;

}
@end

@implementation PartTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _buttonTitleArr=@[@"传单派发",@"促销员",@"服务员",@"家教",@"翻译",@"会计",@"模特",@"酒吧KTV",@"礼仪小姐",@"设计制作",@"摄影师",@"实习生",@"手工制作",@"网站建设",@"问卷调查",@"钟点工",@"销售",@"学生兼职",@"其他兼职"];
    
    self.view.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:242/255.0 alpha:1];
    [self creatNavigationItem];
    [self creatTopLabel];
    [self creatbutton];
}
//创建导航栏按钮
-(void)creatNavigationItem{
    
    UISearchController *search =[[UISearchController alloc]initWithSearchResultsController:nil];
    search.searchResultsUpdater=self;
    search.searchBar.frame=CGRectMake(20, 5, [UIScreen mainScreen].bounds.size.width/2, 30);
    search.dimsBackgroundDuringPresentation=NO;
    search.hidesBottomBarWhenPushed=NO;
    search.searchBar.placeholder=@"搜索兼职工作";
    self.navigationItem.titleView=search.searchBar;
    
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
    JianZhiResumeViewController *resumeVC=[[JianZhiResumeViewController alloc]init];
    [self.navigationController pushViewController:resumeVC animated:YES];

}
//搜索
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}

//创建顶部两个按钮
-(void)creatTopLabel{
    
    UIView *topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/6)];
    topView.backgroundColor=[UIColor whiteColor];
    topView.userInteractionEnabled=YES;
    [self.view addSubview:topView];
    
    NSArray *titleArr=@[@"日结专区",@"长期兼职"];
    for (int i=0; i<2; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        int col =i%2;
        int row =i/2;
        button.frame =CGRectMake(10+col*(10+(WIDTH-30)/2), 20+(HEIGHT/6-30)*row, (WIDTH-30)/2, HEIGHT/6-40);
        [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setBackgroundColor:BJCOLOR];
        [button addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString stringWithFormat:@"%@",titleArr[i]] forState:UIControlStateNormal];
        button.tag=i+1;
        [topView addSubview:button];
     }
}
//顶部按钮绑定方法
-(void)topButtonClick:(UIButton *)button{
    if (button.tag==1) {
        DayPayViewController *vc=[[DayPayViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LongTimeViewController *vc=[[LongTimeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
//下面分类按钮
-(void)creatbutton{
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT/6+10, WIDTH, HEIGHT/5*2/5*7)];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    for (int i=0 ; i<19; i++) {
        int col =i%3;
        int row =i/3;
        JobButton *button =[[JobButton alloc]initWithFrame:CGRectMake(col*WIDTH/3,HEIGHT/5*2/5*row, WIDTH/3, HEIGHT/5*2/5)];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(jobButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i+3;
        button.textLabel.text=[NSString stringWithFormat:@"%@",_buttonTitleArr[i]];
        button.jobImageView.image=[UIImage imageNamed:@"gremen-01"];
        [view addSubview:button];
    }
}
-(void)jobButtonClick:(JobButton *)button{
    
    PartListViewController *vc=[[PartListViewController alloc]init];
    vc.placeholder=button.textLabel.text;
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
