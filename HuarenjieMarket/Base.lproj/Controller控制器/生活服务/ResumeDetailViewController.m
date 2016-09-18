//
//  ResumeDetailViewController.m
//  temp
//
//  Created by l x on 16/5/26.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ResumeDetailViewController.h"
#import "ResumeS0TableViewCell.h"
#import "ResumeS1TableViewCell.h"
#import "ResumeS2TableViewCell.h"
#import "ResumeListTableViewCell.h"

@interface ResumeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGRect rect;
}
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ResumeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatTableView];
    [self creatBottomView];
}
-(void)creatBottomView{
    BottomView *view =[[BottomView alloc]initWithFrame:CGRectMake(0, HEIGHT-45,WIDTH , 45)];
    view.nameLabel.text=_resumeInfo.name;
    view.resumeButton.hidden=YES;
    view.phoneButton.textLabel.text=@"打电话";
    view.phoneButton.jobImageView.image=[UIImage imageNamed:@"gchezixun-01"];
    [view.phoneButton addTarget:self action:@selector(phoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
}
-(void)phoneButtonClick{
    
}
-(void)creatTableView{
    self.title=@"信息详情";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-45) style:UITableViewStyleGrouped];
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, CGFLOAT_MIN)];
    self.tableView.tableHeaderView=view;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.sectionHeaderHeight=1;
    self.tableView.sectionFooterHeight=9;
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"ResumeS0TableViewCell" bundle:nil] forCellReuseIdentifier:@"ResumeS0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ResumeS1TableViewCell" bundle:nil] forCellReuseIdentifier:@"ResumeS1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ResumeS2TableViewCell" bundle:nil] forCellReuseIdentifier:@"ResumeS2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ResumeListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ResumeListTableViewCell"];
    [self.view addSubview:self.tableView];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==3) {
        return 4;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 40;
    }else if (indexPath.section==1) {
        return 155;
    }else if (indexPath.section==2) {
        return 30+rect.size.height+20;
    }else{
        if (indexPath.row==0) {
            return 40;
        }
        return 80;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        ResumeS0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ResumeS0"];
        NSString *string =[[_resumeInfo.birthday componentsSeparatedByString:@" "] firstObject];
        int birthYear =[string intValue];
        
        NSDate *currentDate =[NSDate date];
        NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy"];
        NSString *fabutime=[formatter stringFromDate:currentDate];
        int currentYear=[fabutime intValue];

        cell.titleLabel.text=[NSString stringWithFormat:@"%@ %@ %d岁",_resumeInfo.name,_resumeInfo.sex,currentYear-birthYear];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==1) {
        ResumeS1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ResumeS1"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.downLoadphoneNumberButton.layer.cornerRadius=5;
        cell.downLoadphoneNumberButton.layer.masksToBounds=YES;
        [cell.downLoadphoneNumberButton addTarget:self action:@selector(downLoadphoneNumberButtonClick) forControlEvents:UIControlEventTouchUpInside];
        cell.workTimeLabel.text=_resumeInfo.gongzuonianxian;
        cell.schollLabel.text=_resumeInfo.xueli;
        cell.objectiveLabel.text=_resumeInfo.zhiwei;
        cell.moneyLabel.text=_resumeInfo.salary;
        cell.workPlaceLabel.text=_resumeInfo.gongzuoquyu;
        return cell;
            
    }else if (indexPath.section==2){
        ResumeS2TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ResumeS2"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.describeLabel.text=_resumeInfo.qiuzhixuanyan;

        rect =[cell.describeLabel.text boundingRectWithSize:CGSizeMake(cell.describeLabel.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil];
        cell.describeLabel.frame=rect;
        return cell;
    }else{
        if (indexPath.row==0) {
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            cell.textLabel.text=@"优秀简历推荐";
            cell.textLabel.font=[UIFont systemFontOfSize:15.0];
            return cell;
        }else{
            ResumeListTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ResumeListTableViewCell"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
        ResumeDetailViewController *VC=[[ResumeDetailViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}
-(void)downLoadphoneNumberButtonClick{
    
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
