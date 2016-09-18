//
//  ResumHouseViewController.m
//  temp
//
//  Created by l x on 16/5/23.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ResumHouseViewController.h"
#import "ZhengZuViewController.h"
#import "HeZuViewController.h"
#import "DuanZuViewController.h"
#import "QiuZuViewController.h"
#import "ShangPuViewController.h"
#import "XieZiLouViewController.h"
#import "ChangFangViewController.h"


@interface ResumHouseViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ResumHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"房屋出租";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    [self creatNav];
    [self creatTable];
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

-(void)creatTable{
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray*textArr=@[@"整租",@"合租",@"日租短租",@"求租",@"商铺出租",@"写字楼出租",@"厂房仓库出租"];
    static NSString*cellID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:14.0];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text=textArr[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        ZhengZuViewController *vc =[[ZhengZuViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1) {
         HeZuViewController *vc =[[HeZuViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==2) {
        DuanZuViewController *vc =[[DuanZuViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==3) {
        QiuZuViewController *vc =[[QiuZuViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==4) {
        ShangPuViewController *vc =[[ShangPuViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==5) {
        XieZiLouViewController *vc =[[XieZiLouViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ChangFangViewController *vc =[[ChangFangViewController alloc]init];
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
