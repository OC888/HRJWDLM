//
//  SailHouseViewController.m
//  temp
//
//  Created by l x on 16/5/25.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "SailHouseViewController.h"
#import "SailErShouHouseViewController.h"
#import "BuyErShouHouseViewController.h"
#import "SailShangPuViewController.h"
#import "SailXiezilouViewController.h"
#import "SailChangfangViewController.h"
#import "SailNewHouseViewController.h"

@interface SailHouseViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SailHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"房产出售";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    [self creatTable];
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

-(void)creatTable{
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray*textArr=@[@"二手房出售",@"二手房求购",@"商铺出售",@"写字楼出售",@"厂房仓库土地",@"新房出售"];
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
        SailErShouHouseViewController *vc =[[SailErShouHouseViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1) {
        BuyErShouHouseViewController *vc =[[BuyErShouHouseViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==2) {
        SailShangPuViewController *vc =[[SailShangPuViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==3) {
        SailXiezilouViewController *vc =[[SailXiezilouViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==4) {
        SailChangfangViewController *vc =[[SailChangfangViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        SailNewHouseViewController *vc =[[SailNewHouseViewController alloc]init];
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
