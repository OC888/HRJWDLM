//
//  ViewController.m
//  temp
//
//  Created by aaa on 16/5/9.
//  Copyright © 2016年 wangli. All rights reserved.
//

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "GoodsButton1.h"
#import "GoodsButton2.h"
#import "FullTimeViewController.h"
#import "PartTimeViewController.h"
#import "UsedCarViewController.h"
#import "UsedGoodsViewController.h"
#import "RentHouseViewController.h"
#import "BuyHouseViewController.h"
#import "LocaServiceViewController.h"
#import "ResumeAllViewController.h"
#import "RentlistTableViewCell.h"
#import "AllResumeViewViewController.h"
#import "ceshiViewController.h"
#import "TableViewController.h"

@interface ViewController ()
{
    int count;
}
@property (nonatomic,strong) NSMutableArray *resultArr;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=BJCOLOR;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self creatNavItem];
    [self creatTableView];

}
//创建表
-(void)creatTableView{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableHeaderView=[self creatTableHeaderView];
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:_tableView];
    count=1;
}

#pragma mark tableViewdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0)
    {
        return 2;
    }else if (section==1)
    {
        return 3;
    }else{
        return 3;
    }

}

#pragma mark tableViewDatasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==2) {
        RentlistTableViewCell *cell = (RentlistTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell)
        {
            cell= (RentlistTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"RentlistTableViewCell" owner:self options:nil]  lastObject];
        }
        [cell.houseImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"tu"]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;

    }
    static NSString *cellID=@"cell";
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.section==0)
        {
            if (indexPath.row==0) {
                for (int i=0; i<2; i++) {
                    GoodsButton1 *button =[[GoodsButton1 alloc]initWithFrame:CGRectMake(i*WIDTH/2, 0, WIDTH/2, 60)];
                    [button addTarget:self action:@selector(goodsButton1Click:) forControlEvents:UIControlEventTouchUpInside];
                    button.tag=i+9;
                    [cell addSubview:button];
                    if (button.tag==10) {
                        button.textLael.text=@"积分商城";
                        button.detailTextLael.text=@"小积分兑豪礼";
                        button.imageVieww.image=[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lipin" ofType:@"png"]];
                    }
                }
            }else{
                for (int i=0; i<3; i++) {
                    GoodsButton2 *button =[[GoodsButton2 alloc]initWithFrame:CGRectMake(i*WIDTH/3, 0, WIDTH/3, 100)];
                    [button addTarget:self action:@selector(goodsButton2Click:) forControlEvents:UIControlEventTouchUpInside];
                    button.tag=i+11;
                    [cell addSubview:button];
                }

            }
        }else if (indexPath.section==1)
        {
            NSArray *buttonTitleArr=@[@"换一批",@"查看更多"];
            if (indexPath.row==4) {
                for (int i=0; i<2; i++) {
                    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
                    [button.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
                    button.frame =CGRectMake(WIDTH/2*i, 0, WIDTH/2, 60);
                    [button setTitle:[NSString stringWithFormat:@"%@",buttonTitleArr[i]] forState:UIControlStateNormal];
                    [button setTitleColor:BJCOLOR forState:UIControlStateNormal];
                    [cell addSubview:button];
                }
            }else if(indexPath.row==0){
                cell.textLabel.text=@"【热点】 李克强与默克尔在颐和园散步";
            }else if(indexPath.row==1){
                cell.textLabel.text=@"【汽车】 18万买了辆保时捷 如今想死的心都有";
            }else{
                cell.textLabel.text=@"【财经】 楼市有无泡沫？吴晓灵反问买得起房么";
            }
        }else{
            
        }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            ceshiViewController *vc =[[ceshiViewController alloc]init];
            vc.urlString=@"http://info.3g.qq.com/g/channel_home.htm?chId=news_h_nch&i_f=816&sid=&&icfa=home_touch&f_pid=135";
            vc.title=@"今日要闻";
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1) {
            ceshiViewController *vc =[[ceshiViewController alloc]init];
            vc.urlString=@"http://info.3g.qq.com/g/channel_home.htm?chId=auto_h_nch&i_f=861&sid=&&icfa=home_touch&f_pid=135&iarea=239";
            vc.title=@"汽车资讯";
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            ceshiViewController *vc =[[ceshiViewController alloc]init];
            vc.urlString=@"http://info.3g.qq.com/g/channel_home.htm?chId=finance_h_nch&i_f=823&sid=&&icfa=home_touch&f_pid=135";
            vc.title=@"财经资讯";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section==2) {
        SHOW_MESSAGE(@"数据加载中...");
    }
}
//热门服务按钮绑定方法
-(void)hotServiceButtonClick:(UIButton *)button{
    
}
//section 0 row 0 按钮绑定方法
-(void)goodsButton1Click:(GoodsButton1 *)button{
    if (button.tag==10) {
        SHOW_MESSAGE(@"亲，活动即将开启 敬请期待");
    }else{
        UsedGoodsViewController *goodsVC=[[UsedGoodsViewController alloc]init];
        goodsVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:goodsVC animated:YES];
    }
}

//section 0 row 1 按钮绑定方法
-(void)goodsButton2Click:(GoodsButton2 *)button{
    LocaServiceViewController *localServiceVC=[[LocaServiceViewController alloc]init];
    [self.navigationController pushViewController:localServiceVC animated:YES];
}

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0)
    {
        if (indexPath.row==0) {
            return 70;
        }
        return 100;
    }else if (indexPath.section==1)
    {
        return 60;
    }else{
        return 80;
    }
}

//创建表头
-(UIView *)creatTableHeaderView{
    
    NSArray *picArr=@[@"quanzhi-01",@"jianzhi-01",@"che-01",@"ershouwupin-01",@"zufang-01",@"maifang-01",@"life_jianliku",@"fabu-01"];
    NSArray *picTitleArr=@[@"全职工作",@"兼职工作",@"二手车",@"二手物品",@"租房",@"买房",@"简历库",@"发布"];
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/5+(WIDTH-20*5)/4*2+20*2)];
    
    _topScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/5)];
    _topScrollView.contentSize=CGSizeMake(WIDTH*3, HEIGHT/5);
    _topScrollView.delegate=self;
    _topScrollView.pagingEnabled=YES;
    _topScrollView.showsHorizontalScrollIndicator=NO;
    [view addSubview:_topScrollView];
    NSArray *imageArr=@[@"simplejianli_icon",@"job_postlist_publish_simple",@"image1"];
    for (int i=0; i<3; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, HEIGHT/5)];
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[i]]];
        [_topScrollView addSubview:imageView];
    }
    [NSThread detachNewThreadSelector:@selector(topScrollViewScroll) toTarget:self withObject:nil];
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(100, HEIGHT/5-10, WIDTH-200, 10)];
    _pageControl.numberOfPages=3;
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:_pageControl];

    for (int i=0; i<8; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        int col =i%4;
        int row =i/4;
        button.frame =CGRectMake(20+((WIDTH-20*5)/4+20)*col, 20+HEIGHT/5+((WIDTH-20*5)/4+20)*row, (WIDTH-20*5)/4, (WIDTH-20*5)/4);
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",picArr[i]]] forState:UIControlStateNormal];
        button.imageEdgeInsets=UIEdgeInsetsMake(0, 10, 20, 10);
        [button addTarget:self action:@selector(tableHeaderViewbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i+1;
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, (WIDTH-20*5)/4-15, button.bounds.size.width, 20)];
        label.text=picTitleArr[i];
        label.font=[UIFont systemFontOfSize:13.0];
        label.textAlignment=NSTextAlignmentCenter;
        [button addSubview:label];
        
        [view addSubview:button];
    }
    return view;
}
-(void)topScrollViewScroll{
    NSTimer *timer =[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
}
-(void)scroll{
    _pageControl.currentPage +=count;
    [_topScrollView setContentOffset:CGPointMake(_pageControl.currentPage*WIDTH, 0) animated:YES];
    if (_pageControl.currentPage>=2||_pageControl.currentPage<=0) {
        count =-count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
//表头按钮绑定方法
-(void)tableHeaderViewbuttonClick:(UIButton *)button{
    NSLog(@"%ld",(long)button.tag);
    switch (button.tag) {
        case 1:{

            FullTimeViewController *fullVC=[[FullTimeViewController alloc]init];
            fullVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:fullVC animated:YES];
        }
            break;
        case 2:{
            PartTimeViewController *partVC=[[PartTimeViewController alloc]init];
            partVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:partVC animated:YES];
        }
            break;
        case 3:{
            UsedCarViewController *carVC=[[UsedCarViewController alloc]init];
            carVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:carVC animated:YES];
        }
            break;
        case 4:{
            UsedGoodsViewController *goodsVC=[[UsedGoodsViewController alloc]init];
            goodsVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:goodsVC animated:YES];
        }
            break;
        case 5:{
            RentHouseViewController *rentVC=[[RentHouseViewController alloc]init];
            [self.navigationController pushViewController:rentVC animated:YES];
        }
            break;
        case 6:{
            BuyHouseViewController *buyVC=[[BuyHouseViewController alloc]init];
            [self.navigationController pushViewController:buyVC animated:YES];
        }
            break;
        case 7:{
            AllResumeViewViewController *vc=[[AllResumeViewViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 8:{
            ResumeAllViewController *domesticVC=[[ResumeAllViewController alloc]init];
            [self.navigationController pushViewController:domesticVC animated:YES];
        }
            break;


        default:
            break;
    }
}

//区头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }else{
    NSArray *titleArr=@[@"",@"热门资讯",@"猜你喜欢"];
    static NSString *headerID = @"header";
    UITableViewHeaderFooterView *view =[tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    if (!view) {
        view=[[UITableViewHeaderFooterView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];;
        view.contentView.backgroundColor=[UIColor whiteColor];
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDTH, 10)];
        label.font=[UIFont systemFontOfSize:16.0];
        label.text=[NSString stringWithFormat:@"%@",titleArr[section]];
        [view addSubview:label];
    }
    
    return view;
    }
}

#pragma mark scrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_pageControl setCurrentPage:_topScrollView.contentOffset.x/WIDTH];
}
//pageControl绑定方法
-(void)changePage:(UIPageControl*)pageControl{
    [_topScrollView setContentOffset:CGPointMake(pageControl.currentPage*WIDTH, 0) animated:YES];
}
//导航栏配置
-(void)creatNavItem{
    UIButton *leftbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.bounds=CGRectMake(0, 0, 50, 40);
    [leftbutton setTitle:@"返回" forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [leftbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem=leftItem;
    
//    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
//    button.bounds=CGRectMake(0, 0, 50, 40);
//    [button setTitle:@"签到" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(qianDao:) forControlEvents:UIControlEventTouchUpInside];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithCustomView:button];
//    self.navigationItem.rightBarButtonItem=rightItem;
    
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
    self.search.searchBar.placeholder=@"输入类别或关键字";
    self.navigationItem.titleView=self.search.searchBar;
}
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
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

//签到按钮绑定方法
-(void)qianDao:(UIButton *)btn{
    
    [btn setTitle:@"已签到" forState:UIControlStateNormal];
    
    ceshiViewController *vc=[[ceshiViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//加载webView
-(void)loadWebViewWithUrlString:(NSString *)string{
    UIWebView *webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, -50, WIDTH, HEIGHT+50)];
    [self.view addSubview:webView];
    webView.scrollView.bounces=NO;
    //webView.delegate=self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
