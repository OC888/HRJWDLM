//
//  UsedGoodsViewController.m
//  temp
//
//  Created by l x on 16/5/16.
//  Copyright (c) 2016年 wangli. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "UsedGoodsViewController.h"
#import "GoodsButton.h"
#import "ResumeGoodsViewController.h"
#import "GoodsListViewController.h"
#import "ErShouGoodsListViewController.h"

@interface UsedGoodsViewController ()
@property (nonatomic,strong) UISearchController *search;
@property (nonatomic,strong) NSMutableArray *resultArr;

@end

@implementation UsedGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatNavigationItem];
    [self creatScrollView];
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
    self.search.searchBar.placeholder=@"搜索二手物品";
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
    ResumeGoodsViewController *vc=[[ResumeGoodsViewController alloc]init];
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
-(void)creatScrollView{
    UIScrollView *scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    scrollView.contentSize=CGSizeMake(WIDTH, HEIGHT*1.5);
    scrollView.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:242/255.0 alpha:1];
    scrollView.tag=200;
    scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
    topView.backgroundColor=[UIColor whiteColor];
    topView.layer.borderWidth=0.2;
    topView.layer.borderColor=[UIColor colorWithRed:200/255.0 green:190/255.0 blue:204/255.0 alpha:1].CGColor;
    [scrollView addSubview:topView];
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    imageView.image=[UIImage imageNamed:@"gbianmin-01"];
    [topView addSubview:imageView];
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
    label.text=@"精品";
    label.font=[UIFont systemFontOfSize:14.0];
    label.textColor=BJCOLOR;
    [topView addSubview:label];

    NSArray *titleArr=@[@"全新闲置",@"神机盘点"];
    for (int i=0; i<2; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        int col =i%2;
        int row =i/2;
        button.frame =CGRectMake(10+col*(10+(WIDTH-30)/2), 40+(60+10)*row, (WIDTH-30)/2, 60);
        [button setImage:[UIImage imageNamed:@"bendi"] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor orangeColor]];
        //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
        button.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, WIDTH/2-20-40);
        [button setTitle:[NSString stringWithFormat:@"%@",titleArr[i]] forState:UIControlStateNormal];
        //button标题的偏移量，这个偏移量是相对于图片的
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleLabel.numberOfLines=0;
        [button addTarget:self action:@selector(recommendedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i+1;
        [topView addSubview:button];
    }
    UIImageView *hotImageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 120, 20, 20)];
    hotImageView.image=[UIImage imageNamed:@"gremen-01"];
    [topView addSubview:hotImageView];
    UILabel *hotLabel =[[UILabel alloc]initWithFrame:CGRectMake(40, 120, 50, 20)];
    hotLabel.text=@"热门";
    hotLabel.font=[UIFont systemFontOfSize:14.0];
    hotLabel.textColor=BJCOLOR;
    [topView addSubview:hotLabel];
    
    for (int i=0; i<4; i++) {
        int col=i%4;
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(90+((WIDTH-120-10*5)/4+20)*col, 120, (WIDTH-120-10*5)/4, 20);
        [button setTitle:@"加载中.." forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(hotGoodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i+100;
        [topView addSubview:button];
    }

    
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 165, WIDTH, HEIGHT/6*8)];
    bottomView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:bottomView];

    NSArray *picArr=@[@"secondhand_mobile",@"secondhand_laptop",@"secondhand_pad",@"secondhand_pc",@"secondhand_moto",@"secondhand_bike",@"secondhand_mother_to_child",@"secondhand_furniture",@"secondhand_mixed",@"secondhand_daily_necessities"];
    NSArray *nameArr=@[@"手机/配件",@"笔记本",@"平板电脑",@"电脑/配件",@"摩托车",@"自行车",@"母婴儿童",@"家具",@"闲置礼品",@"家居百货"];
    
    for (int i=0; i<10; i++) {
        int col=i%4;
        int row=i/4;
        GoodsButton *button =[[GoodsButton alloc]initWithFrame:CGRectMake(WIDTH/4*col, HEIGHT/6*row, WIDTH/4, HEIGHT/6)];
        button.goodImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",picArr[i]]];
        button.goodNameLable.text=nameArr[i];
        button.layer.borderWidth=0.5;
        button.layer.borderColor=[UIColor colorWithRed:200/255.0 green:190/255.0 blue:204/255.0 alpha:1].CGColor;
        [button addTarget:self action:@selector(selectGoodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i+100;
        [bottomView addSubview:button];
    }

}
//精品按钮
-(void)recommendedButtonClick:(UIButton *)button{
    GoodsListViewController *vc =[[GoodsListViewController alloc]init];
    vc.search.searchBar.placeholder=[NSString stringWithFormat:@"搜索%@",button.titleLabel.text];
    [self.navigationController pushViewController:vc animated:YES];
}

//热门商品
-(void)hotGoodButtonClick:(UIButton *)button{
    GoodsListViewController *vc =[[GoodsListViewController alloc]init];
    vc.search.searchBar.placeholder=[NSString stringWithFormat:@"搜索%@",button.titleLabel.text];
    
    [self.navigationController pushViewController:vc animated:YES];
}
//商品按钮
-(void)selectGoodButtonClick:(GoodsButton *)button{
    ErShouGoodsListViewController *vc =[[ErShouGoodsListViewController alloc]init];
    vc.placeholder=button.goodNameLable.text;
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
