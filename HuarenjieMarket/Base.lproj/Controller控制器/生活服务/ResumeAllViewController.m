//
//  ResumeAllViewController.m
//  temp
//
//  Created by l x on 16/5/22.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ResumeAllViewController.h"
#import "ResumAllTableViewCell.h"
#import "ResumeViewController.h"
#import "FangChanViewController.h"
#import "ResumeCarViewController.h"
#import "ResumeGoodsViewController.h"
#import "ZhaoPinViewController.h"
#import "PartZhiWeiViewController.h"
#import "JianZhiResumeViewController.h"

@interface ResumeAllViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ResumeAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatTableView];
}
-(void)creatTableView{
    self.title=@"发布信息";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0]};
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=HEIGHT/8;
    tableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:tableView];
    [self creatNav];
}
-(void)creatNav{
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *imageArr=@[@"publish_icon_jianli",@"publish_icon_full_time_job_rss",@"publish_icon_home_sale_rss",@"publish_icon_second_hand_goods_rss",@"publish_icon_car_sale_rss",@"publish_ic_lifestyle"];
    NSArray *titleArr=@[@"简历",@"招聘",@"房产",@"二手物品",@"二手车",@"本地服务"];
    NSArray *detailArr=@[@"技工／工人,销售,司机,导购,服务员,客服,房地产,保安,仓库管理,餐饮／酒店",@"营业员,快递员,跟单员,保险,淘宝职位,财务审计,行政／后勤,人力资源",@"商铺出租,写字楼出租,厂房仓库出租,二手房出售,二手房求购",@"手机/配件,笔记本,平板电脑,电脑/配件,摩托车,自行车,母婴儿童,家具,闲置礼品,家居百货",@"二手汽车,摩托车,自行车,电动车,汽车用品,新车买卖",@"搬家,家政,维修,物流,美食,便民,装修,建材,汽车服务"];
    static NSString *cellID=@"cell";
    ResumAllTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[ResumAllTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.headerImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[indexPath.row]]];
    cell.titleLable.text=titleArr[indexPath.row];
    cell.detailLabel.text=detailArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        __block typeof(self) otherSelf=self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *FullAction = [UIAlertAction actionWithTitle:@"全职简历" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            ResumeViewController *vc=[[ResumeViewController alloc]init];
            [otherSelf.navigationController pushViewController:vc animated:YES];
            
        }];
        UIAlertAction *PartAction = [UIAlertAction actionWithTitle:@"兼职简历" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            JianZhiResumeViewController *vc=[[JianZhiResumeViewController alloc]init];
            [otherSelf.navigationController pushViewController:vc animated:YES];
            
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:FullAction];
        [alertController addAction:PartAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else if (indexPath.row==1) {
        __block typeof(self) otherSelf=self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *FullAction = [UIAlertAction actionWithTitle:@"全职招聘" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            ZhaoPinViewController *vc=[[ZhaoPinViewController alloc]init];
            [otherSelf.navigationController pushViewController:vc animated:YES];

        }];
        UIAlertAction *PartAction = [UIAlertAction actionWithTitle:@"兼职招聘" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            PartZhiWeiViewController *vc=[[PartZhiWeiViewController alloc]init];
            [otherSelf.navigationController pushViewController:vc animated:YES];

        }];

        [alertController addAction:cancelAction];
        [alertController addAction:FullAction];
        [alertController addAction:PartAction];
        [self presentViewController:alertController animated:YES completion:nil];

    }else if (indexPath.row==2) {
        FangChanViewController *vc=[[FangChanViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row==3) {
        ResumeGoodsViewController *vc=[[ResumeGoodsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        ResumeCarViewController *vc=[[ResumeCarViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
