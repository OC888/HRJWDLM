//
//  ResumeCarViewController.m
//  temp
//
//  Created by l x on 16/5/19.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ResumeCarViewController.h"
#import "CarInfoViewController.h"
#import "ErShouViewController.h"

@interface ResumeCarViewController ()

@end

@implementation ResumeCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"二手车";
    [self creatTable];
    [self createNav];
}
-(void)createNav{
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
    
    NSArray*textArr=@[@"二手汽车",@"摩托车",@"自行车",@"电动车",@"汽车用品",@"新车买卖"];
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
        CarInfoViewController *vc =[[CarInfoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==4) {
        
    }else{
        UITableViewCell *cell=(UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        ErShouViewController *vc =[[ErShouViewController alloc]init];
        vc.indentifyID=[NSString stringWithFormat:@"%@",cell.textLabel.text];
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
