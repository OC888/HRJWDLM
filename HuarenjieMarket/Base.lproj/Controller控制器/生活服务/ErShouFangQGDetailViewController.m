//
//  ErShouFangQGDetailViewController.m
//  temp
//
//  Created by l x on 16/6/2.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "Section1TableViewCell.h"
#import "FS1R0TableViewCell.h"
#import "CarS1R4TableViewCell.h"
#import "S3R1TableViewCell.h"
#import "S4R1TableViewCell.h"
#import "ErShouFangQGDetailViewController.h"
#import "QiuZuTableViewCell.h"

@interface ErShouFangQGDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGSize rect;
}
@property (nonatomic,strong) UITableView *tableView;


@end

@implementation ErShouFangQGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatNavigationItem];
    [self creatTable];
    [self creatBottomView];
}
-(void)creatNavigationItem{
    if ([_biaozhi isEqualToString:@"二手房求购"]) {
        self.title=[NSString stringWithFormat:@"%@房源",_qiuGouInfo.xinxilaiyuan];
    }else{
        self.title=[NSString stringWithFormat:@"%@房源",_qiuZuInfo.xinxilaiyuan];
    }

    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(collectionButtonClick)];
    [rightItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem=rightItem;
}
//导航右栏按钮绑定方法
-(void)collectionButtonClick{
    
}
//底部功能View
-(void)creatBottomView{
    BottomView *view =[[BottomView alloc]initWithFrame:CGRectMake(0, HEIGHT-45,WIDTH , 45)];
    if ([_biaozhi isEqualToString:@"二手房求购"]) {
        view.nameLabel.text=_qiuGouInfo.lianxiren;
        view.phoneLabel.text=_qiuGouInfo.phone;
    }else{
        view.nameLabel.text=_qiuZuInfo.lianxiren;
        view.phoneLabel.text=_qiuZuInfo.phone;
    }
    view.resumeButton.textLabel.text=@"留言";
    view.resumeButton.jobImageView.image=[UIImage imageNamed:@"gchezixun-01"];
    [view.resumeButton addTarget:self action:@selector(resumeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    view.phoneButton.textLabel.text=@"打电话";
    view.phoneButton.jobImageView.image=[UIImage imageNamed:@"gchezixun-01"];
    [view.phoneButton addTarget:self action:@selector(phoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
}
//留言
-(void)resumeButtonClick{
    
}
//打电话
-(void)phoneButtonClick{
    
}

//创建表
-(void)creatTable{
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-45) style:UITableViewStyleGrouped];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.sectionFooterHeight=5;
    self.tableView.sectionHeaderHeight=5;
    self.tableView.tableFooterView=[[UIView alloc]init];
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, CGFLOAT_MIN)];
    self.tableView.tableHeaderView=view;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"Section1TableViewCell" bundle:nil] forCellReuseIdentifier:@"S1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FS1R0TableViewCell" bundle:nil] forCellReuseIdentifier:@"FS1R0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CarS1R4TableViewCell" bundle:nil] forCellReuseIdentifier:@"CarS1R4"];
    [self.tableView registerNib:[UINib nibWithNibName:@"S3R1TableViewCell" bundle:nil] forCellReuseIdentifier:@"S3R1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"S4R1TableViewCell" bundle:nil] forCellReuseIdentifier:@"S4R1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QiuZuTableViewCell" bundle:nil] forCellReuseIdentifier:@"QiuZu"];
    [self.view addSubview:self.tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1) {
        return 2;
    }else if (section==2) {
        return 1;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 80;
    }else if (indexPath.section==1) {
        if (indexPath.row==0) {
            return 60;
        }else{
            return rect.height+20;
        }
    }else if (indexPath.section==2) {
        return 40;
        
    }else{
        return 95;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_biaozhi isEqualToString:@"二手房求购"]) {
        if (indexPath.section==0) {
            Section1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.titleLabel.text=_qiuGouInfo.title;
            cell.timeLabel.text=[NSString stringWithFormat:@"发布时间 %@",_qiuGouInfo.dt_datetime];
            return cell;
        }else if (indexPath.section==1) {
            if (indexPath.row==0) {
                FS1R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"FS1R0"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.houseRectLabel.text=[NSString stringWithFormat:@"%@",_qiuGouInfo.huxing];
                return cell;
            }else{
                CarS1R4TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS1R4"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.detailText.text=_qiuGouInfo.miaoshu;
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
                paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
                NSDictionary *attributes = @{NSFontAttributeName:cell.textLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
                
                rect = [cell.detailText.text boundingRectWithSize:CGSizeMake(cell.textLabel.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
                cell.detailText.frame=CGRectMake(cell.detailText.frame.origin.x, cell.textLabel.frame.origin.y, cell.detailText.frame.size.width, rect.height+20);
                return cell;
            }
        }else if (indexPath.section==2) {
            S3R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S3R1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.detailAddress.text=_qiuGouInfo.quyu;
            return cell;
        }else{
            S4R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S4R1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.personNameLabel.text=_qiuGouInfo.lianxiren;
            cell.phoneLabel.text=_qiuGouInfo.phone;
            return cell;
        }
    }else{
        if (indexPath.section==0) {
            Section1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.titleLabel.text=_qiuZuInfo.biaoti;
            cell.timeLabel.text=[NSString stringWithFormat:@"发布时间 %@",_qiuZuInfo.dt_datetime];
            return cell;
        }else if (indexPath.section==1) {
            if (indexPath.row==0) {
                QiuZuTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"QiuZu"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.priceLabel.text=_qiuZuInfo.dec_qiwangzujin;
                cell.rectLabel.text=[NSString stringWithFormat:@"%@",_qiuZuInfo.huxing];
                return cell;
            }else{
                CarS1R4TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS1R4"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.detailText.text=_qiuZuInfo.miaoshu;
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
                paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
                NSDictionary *attributes = @{NSFontAttributeName:cell.textLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
                
                rect = [cell.detailText.text boundingRectWithSize:CGSizeMake(cell.textLabel.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
                cell.detailText.frame=CGRectMake(cell.detailText.frame.origin.x, cell.textLabel.frame.origin.y, cell.detailText.frame.size.width, rect.height+20);
                return cell;
            }
        }else if (indexPath.section==2) {
            S3R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S3R1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.detailAddress.text=_qiuZuInfo.quyu;
            return cell;
        }else{
            S4R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S4R1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.personNameLabel.text=_qiuZuInfo.lianxiren;
            cell.phoneLabel.text=_qiuZuInfo.phone;
            return cell;
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
