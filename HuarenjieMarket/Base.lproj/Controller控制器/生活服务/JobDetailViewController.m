//
//  JobDetailViewController.m
//  temp
//
//  Created by l x on 16/5/21.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "JobDetailViewController.h"
#import "changeButtonView.h"
#import "Section1TableViewCell.h"
#import "Section2TableViewCell.h"
#import "Section2row2TableViewCell.h"
#import "S2R3TableViewCell.h"
#import "S3R1TableViewCell.h"
#import "S4R1TableViewCell.h"
#import "T2S0R0TableViewCell.h"
#import "T2S2TableViewCell.h"

@interface JobDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_leftTableView;
    UITableView *_rightTableView;
    CGSize rect1;
    CGSize rect2;
}
@property (nonatomic,strong) changeButtonView *buttonView;

@end

@implementation JobDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];

    // Do any additional setup after loading the view.
    [self creatNav];
    [self creatTopView];
    [self creatLeftTable];
    [self creatRightTable];
    [self creatBottomView];
    _rightTableView.hidden=YES;
}
-(void)creatNav{
    self.navigationItem.title=@"信息详情";

    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

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

//底部功能View
-(void)creatBottomView{
    BottomView *view =[[BottomView alloc]initWithFrame:CGRectMake(0, HEIGHT-45,WIDTH , 45)];
    if ([self.tableViewtagStr isEqualToString:@"1"]) {
        view.nameLabel.text=_fullTimeInfo.lianxiren;
        view.phoneLabel.text=_fullTimeInfo.phone;
    }else{
        view.nameLabel.text=_partTimeInfo.lianxiren;
        view.phoneLabel.text=_partTimeInfo.phone;
    }
    view.resumeButton.textLabel.text=@"投简历";
    view.resumeButton.jobImageView.image=[UIImage imageNamed:@"gchezixun-01"];
    [view.resumeButton addTarget:self action:@selector(resumeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    view.phoneButton.textLabel.text=@"打电话";
    view.phoneButton.jobImageView.image=[UIImage imageNamed:@"gchezixun-01"];
    [view.phoneButton addTarget:self action:@selector(phoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
}
//投递简历
-(void)resumeButtonClick{
    
}
//打电话
-(void)phoneButtonClick{
    
}
//创建顶部切换页面View
-(void)creatTopView{
    changeButtonView *buttonView =[[changeButtonView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    NSArray *titleArr=@[@"职位信息",@"公司信息"];
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
    _leftTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+40 , WIDTH, HEIGHT-(64+40+45)) style:UITableViewStyleGrouped];
    _leftTableView.delegate=self;
    _leftTableView.dataSource=self;
    _leftTableView.sectionFooterHeight=5;
    _leftTableView.sectionHeaderHeight=5;
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, CGFLOAT_MIN)];
    _leftTableView.tableHeaderView=view;
    [_leftTableView registerNib:[UINib nibWithNibName:@"Section1TableViewCell" bundle:nil] forCellReuseIdentifier:@"S1"];
    [_leftTableView registerNib:[UINib nibWithNibName:@"Section2TableViewCell" bundle:nil] forCellReuseIdentifier:@"S2R1"];
    [_leftTableView registerNib:[UINib nibWithNibName:@"Section2row2TableViewCell" bundle:nil] forCellReuseIdentifier:@"S2R2"];
    [_leftTableView registerNib:[UINib nibWithNibName:@"S2R3TableViewCell" bundle:nil] forCellReuseIdentifier:@"S2R3"];
    [_leftTableView registerNib:[UINib nibWithNibName:@"S3R1TableViewCell" bundle:nil] forCellReuseIdentifier:@"S3R1"];
    [_leftTableView registerNib:[UINib nibWithNibName:@"S4R1TableViewCell" bundle:nil] forCellReuseIdentifier:@"S4R1"];
    _leftTableView.tag=1;
    _leftTableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:_leftTableView];
}
-(void)creatRightTable{
    _rightTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+40 , WIDTH, HEIGHT-(64+40)) style:UITableViewStyleGrouped];
    _rightTableView.delegate=self;
    _rightTableView.dataSource=self;
    _rightTableView.sectionFooterHeight=5;
    _rightTableView.sectionHeaderHeight=5;
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, CGFLOAT_MIN)];
    _rightTableView.tableHeaderView=view;
    [_rightTableView registerNib:[UINib nibWithNibName:@"T2S0R0TableViewCell" bundle:nil] forCellReuseIdentifier:@"T2S0R0"];
    [_rightTableView registerNib:[UINib nibWithNibName:@"S3R1TableViewCell" bundle:nil] forCellReuseIdentifier:@"S3R1"];
    [_rightTableView registerNib:[UINib nibWithNibName:@"T2S2TableViewCell" bundle:nil] forCellReuseIdentifier:@"T2S2R0"];
    _rightTableView.tag=2;
    _rightTableView.tableFooterView=[[UIView alloc]init];
    _rightTableView.estimatedRowHeight=40;
    _rightTableView.rowHeight=UITableViewAutomaticDimension;
    [self.view addSubview:_rightTableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag==1) {
        return 4;
    }else{
        return 2;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==1) {
        if (section==1) {
            return 3;
        }
        return 1;
    }else{
        if (section==0) {
            return 2;
        }
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==1) {
        if (indexPath.section==0) {
            return 75;
        }else if (indexPath.section==1) {
            if (indexPath.row==0) {
                return 175;
            }else if (indexPath.row==1) {
                return 40;
            }else{
                return rect1.height+20;
            }
        }else if (indexPath.section==2){
            return 40;
        }else{
            return 95;
        }
    }else{
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                return 135;
            }
            return 40;
        }
        return rect2.height+20;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag==1) {
        if (indexPath.section==0) {
            Section1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            if ([self.tableViewtagStr isEqualToString:@"1"]) {
                cell.titleLabel.text=_fullTimeInfo.title;
                cell.timeLabel.text=[NSString stringWithFormat:@"发布时间 %@",_fullTimeInfo.dt_datetime];
            }else{
                cell.titleLabel.text=_partTimeInfo.title;
                cell.timeLabel.text=[NSString stringWithFormat:@"发布时间 %@",_partTimeInfo.dt_datetime];
            }
            return cell;
        }else if (indexPath.section==1) {
            if (indexPath.row==0) {
                Section2TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S2R1"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if ([self.tableViewtagStr isEqualToString:@"1"]) {
                    cell.priceLabel.text=[NSString stringWithFormat:@"%@/月",_fullTimeInfo.dec_yuexin];
                    cell.companyLabel.text=_fullTimeInfo.gongsiname;
                    cell.addressLabel.text=_fullTimeInfo.gongzuodidian;
                    cell.personNumberLabel.text=_fullTimeInfo.i_zhaopinrenshu;
                    cell.schoolLabel.text=_fullTimeInfo.xueli;
                    cell.experienceLabel.text=_fullTimeInfo.gongzuonianxian;
                }else{
                    cell.priceLabel.text=[NSString stringWithFormat:@"%@元/天",_partTimeInfo.dec_xinzi];
                    cell.companyLabel.text=_partTimeInfo.gongsiname;
                    cell.addressLabel.text=_partTimeInfo.gongzuodidian;
                    cell.personNumberLabel.text=_partTimeInfo.i_zhaopinrenshu;
                    cell.schoolLabel.text=_partTimeInfo.xueli;
                    cell.experienceLabel.text=_partTimeInfo.gongzuonianxian;
                }
                return cell;
                
            }else if (indexPath.row==1) {
                Section2row2TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"S2R2"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if ([self.tableViewtagStr isEqualToString:@"1"]) {
                    cell.otherLabel.text=_fullTimeInfo.shehuifuli;
                }else{
                    cell.otherLabel.text=_partTimeInfo.shehuifuli;
                }
                return cell;
                
            }else{
                S2R3TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S2R3"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
                if ([self.tableViewtagStr isEqualToString:@"1"]) {
                    cell.jobDescriptionLabel.text=_fullTimeInfo.zhiweimiaoshu;
                }else{
                    cell.jobDescriptionLabel.text=_partTimeInfo.zhiweimiaoshu;
                }
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
                paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
                NSDictionary *attributes = @{NSFontAttributeName:cell.textLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
                
                rect1 = [cell.jobDescriptionLabel.text boundingRectWithSize:CGSizeMake(cell.jobDescriptionLabel.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
                cell.jobDescriptionLabel.frame=CGRectMake(cell.jobDescriptionLabel.frame.origin.x, cell.jobDescriptionLabel.frame.origin.y, cell.jobDescriptionLabel.frame.size.width, rect1.height);

                return cell;
                
            }
        }else if (indexPath.section==2){
            S3R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S3R1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            if ([self.tableViewtagStr isEqualToString:@"1"]) {
                cell.detailAddress.text=_fullTimeInfo.gongzuodidian;
            }else{
                cell.detailAddress.text=_partTimeInfo.gongzuodidian;
            }
            return cell;
        }else{
            S4R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S4R1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            if ([self.tableViewtagStr isEqualToString:@"1"]) {
                cell.personNameLabel.text=_fullTimeInfo.lianxiren;
                cell.phoneLabel.text=_fullTimeInfo.phone;
            }else{
                cell.personNameLabel.text=_partTimeInfo.lianxiren;
                cell.phoneLabel.text=_partTimeInfo.phone;
            }
            return cell;
        }
    }else{
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                T2S0R0TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"T2S0R0"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if ([self.tableViewtagStr isEqualToString:@"1"]) {
                    cell.companyLabel.text=_fullTimeInfo.gongsiname;
                    cell.addressLabel.text=_fullTimeInfo.area;
                    cell.personNumberLabel.text=_fullTimeInfo.guimo;
                }else{
                    cell.companyLabel.text=_partTimeInfo.gongsiname;
                    cell.addressLabel.text=_partTimeInfo.area;
                    cell.personNumberLabel.text=_partTimeInfo.guimo;
                }
                return cell;
            }else{
                S3R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S3R1"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if ([self.tableViewtagStr isEqualToString:@"1"]) {
                    cell.detailAddress.text=_fullTimeInfo.qitafuli;
                }else{
                    cell.detailAddress.text=_partTimeInfo.qitafuli;
                }
                return cell;
                 }
        }
        else{
            T2S2TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"T2S2R0"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            if ([self.tableViewtagStr isEqualToString:@"1"]) {
                cell.detailLabel.text=_fullTimeInfo.gongsijianjie;
            }else{
                cell.detailLabel.text=_partTimeInfo.gongsijianjie;
            }
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
            NSDictionary *attributes = @{NSFontAttributeName:cell.textLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
            
            rect2 = [cell.detailLabel.text boundingRectWithSize:CGSizeMake(cell.detailLabel.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            cell.detailLabel.frame=CGRectMake(cell.detailLabel.frame.origin.x, cell.detailLabel.frame.origin.y, cell.detailLabel.frame.size.width, rect2.height);

            return cell;
        }
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
