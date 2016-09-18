//
//  CarDetailViewController.m
//  temp
//
//  Created by l x on 16/5/21.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "CarDetailViewController.h"
#import "Section1TableViewCell.h"
#import "CarS0R0TableViewCell.h"
#import "CarS1R0TableViewCell.h"
#import "CarS1R1TableViewCell.h"
#import "CarS1R2TableViewCell.h"
#import "CarS1R3TableViewCell.h"
#import "CarS1R4TableViewCell.h"
#import "S4R1TableViewCell.h"

@interface CarDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGSize rect;
}
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation CarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatNavigationItem];
    [self creatTable];
    [self creatBottomView];
}
//创建导航栏按钮
-(void)creatNavigationItem{
    
    self.title=@"个人车源（郑州市）";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(collectionButtonClick)];
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
-(void)collectionButtonClick{
    
}
//底部功能View
-(void)creatBottomView{
    BottomView *view =[[BottomView alloc]initWithFrame:CGRectMake(0, HEIGHT-45,WIDTH , 45)];
    view.nameLabel.text=_carInfo.lianxiren;
    view.phoneLabel.text=_carInfo.phone;
    view.resumeButton.textLabel.text=@"留言";
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

//创建表
-(void)creatTable{
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-45) style:UITableViewStyleGrouped];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.sectionFooterHeight=5;
    self.tableView.sectionHeaderHeight=5;
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, CGFLOAT_MIN)];
    self.tableView.tableHeaderView=view;
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"Section1TableViewCell" bundle:nil] forCellReuseIdentifier:@"S1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"S4R1TableViewCell" bundle:nil] forCellReuseIdentifier:@"S4R1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CarS0R0TableViewCell" bundle:nil] forCellReuseIdentifier:@"CarS0R0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CarS1R0TableViewCell" bundle:nil] forCellReuseIdentifier:@"CarS1R0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CarS1R1TableViewCell" bundle:nil] forCellReuseIdentifier:@"CarS1R1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CarS1R2TableViewCell" bundle:nil] forCellReuseIdentifier:@"CarS1R2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CarS1R3TableViewCell" bundle:nil] forCellReuseIdentifier:@"CarS1R3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CarS1R4TableViewCell" bundle:nil] forCellReuseIdentifier:@"CarS1R4"];

    [self.view addSubview:self.tableView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else if (section==1) {
        return 5;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 200;
        }else{
            return 75;
        }
    }else if (indexPath.section==1) {
        if (indexPath.row==0) {
            return 60;
        }else if (indexPath.row==1) {
            return 110;
        }else if (indexPath.row==2) {
            return 40;
        }else if (indexPath.row==3) {
            return 35;
        }else{
            return rect.height+40;
        }
    }else{
        return 95;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            CarS0R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS0R0"];
            cell.carImageScrollView.contentSize=CGSizeMake(cell.carImageScrollView.frame.size.width*7, cell.carImageScrollView.frame.size.height);
            cell.carImageScrollView.pagingEnabled=YES;
            NSArray *imageArr=@[_carInfo.image1,_carInfo.image2,_carInfo.image3,_carInfo.image4,_carInfo.image5,_carInfo.image6,_carInfo.image7];
            for (int i=0; i<7; i++) {
                UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(cell.carImageScrollView.frame.size.width*i, 0, cell.carImageScrollView.frame.size.width, cell.carImageScrollView.frame.size.height)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:imageArr[i]] placeholderImage:[UIImage imageNamed:@"datu.png"] options:SDWebImageRefreshCached];

                [cell.carImageScrollView addSubview:imageView];
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            Section1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.titleLabel.text=_carInfo.biaoti;
            return cell;
        }
    }else if (indexPath.section==1) {
        if (indexPath.row==0) {
            CarS1R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS1R0"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.priceLabel.text=[NSString stringWithFormat:@"%@万元",_carInfo.price];
            return cell;
        }else if (indexPath.row==1) {
            CarS1R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS1R1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.xslcLabel.text=_carInfo.xingshilicheng;
            cell.kcddLabel.text=_carInfo.place;
            cell.spsjLabel.text=_carInfo.shangpaidate;
            return cell;
        }else if (indexPath.row==2) {
            CarS1R2TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS1R2"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row==3) {
            NSArray *arr=@[@"倒车雷达",@"倒车影像",@"电动天窗",@"电动后视镜"];
            CarS1R3TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS1R3"];
            NSArray *cellLabelArr=@[cell.pzLabel1,cell.pzLabel2,cell.pzLabel3,cell.pzLabel4];
            for (UILabel *label in cellLabelArr) {
                label.text=arr[label.tag];
                label.textColor=BJCOLOR;
            }
            cell.pzLabel1.frame=CGRectMake(10, 10, (WIDTH-50)/4, 15);
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            CarS1R4TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS1R4"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.detailText.text=_carInfo.description;
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
            NSDictionary *attributes = @{NSFontAttributeName:cell.textLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
            
            rect = [cell.detailText.text boundingRectWithSize:CGSizeMake(cell.textLabel.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            cell.detailText.frame=CGRectMake(cell.detailText.frame.origin.x, cell.textLabel.frame.origin.y, cell.detailText.frame.size.width, rect.height+20);
            return cell;
        }
    }else{
        S4R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S4R1"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.personNameLabel.text=_carInfo.lianxiren;
        cell.phoneLabel.text=_carInfo.phone;
        return cell;
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
