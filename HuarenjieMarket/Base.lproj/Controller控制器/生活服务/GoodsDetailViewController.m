//
//  GoodsDetailViewController.m
//  temp
//
//  Created by l x on 16/5/22.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "CarS0R0TableViewCell.h"
#import "Section1TableViewCell.h"
#import "GoodsS1R0TableViewCell.h"
#import "GoodsS1R1TableViewCell.h"
#import "CarS1R4TableViewCell.h"
#import "GoodsS1R3TableViewCell.h"
#import "S4R1TableViewCell.h"

@interface GoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGSize rect;
}
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self creatNavigationItem];
    [self creatTable];
    [self creatBottomView];
}
-(void)creatNavigationItem{
    
    self.title=_erShouGood.gongxu;
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
    view.nameLabel.text=_erShouGood.lianxiren;
    view.phoneLabel.text=_erShouGood.phone;
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
    self.tableView.tableFooterView=[[UIView alloc]init];
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, CGFLOAT_MIN)];
    self.tableView.tableHeaderView=view;
    [self.tableView registerNib:[UINib nibWithNibName:@"Section1TableViewCell" bundle:nil] forCellReuseIdentifier:@"S1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CarS0R0TableViewCell" bundle:nil] forCellReuseIdentifier:@"CarS0R0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsS1R0TableViewCell" bundle:nil] forCellReuseIdentifier:@"GoodsS1R0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsS1R1TableViewCell" bundle:nil] forCellReuseIdentifier:@"GoodsS1R1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CarS1R4TableViewCell" bundle:nil] forCellReuseIdentifier:@"CarS1R4"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsS1R3TableViewCell" bundle:nil] forCellReuseIdentifier:@"GoodsS1R3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"S4R1TableViewCell" bundle:nil] forCellReuseIdentifier:@"S4R1"];
    [self.view addSubview:self.tableView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else if (section==1) {
        return 4;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return (WIDTH-10*5)/4+20;
        }else{
            return 75;
        }
    }else if (indexPath.section==1) {
        if (indexPath.row==0) {
            return 40;
        }else if (indexPath.row==1) {
            return 110;
        }else if (indexPath.row==2) {
            return rect.height+20;
        }else{
            return 40;
        }
    }else{
        return 95;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            CarS0R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS0R0"];
            cell.carImageScrollView.contentSize=CGSizeMake(WIDTH*2, (WIDTH-5*5)/4);
            NSArray *imageArr=@[_erShouGood.img1,_erShouGood.img2,_erShouGood.img3,_erShouGood.img4,_erShouGood.img5,_erShouGood.img5,_erShouGood.img6,_erShouGood.img7];
            for (int i=0; i<8; i++) {
                UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10+((WIDTH-10*5)/4+10)*i, 10, (WIDTH-10*5)/4, (WIDTH-10*5)/4)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:imageArr[i]] placeholderImage:[UIImage imageNamed:@"tu.png"] options:SDWebImageRefreshCached];
                [cell.carImageScrollView addSubview:imageView];
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            Section1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.titleLabel.text=_erShouGood.title;
            cell.timeLabel.text=_erShouGood.dt_datetime;
            return cell;
        }
    }else if (indexPath.section==1) {
        if (indexPath.row==0) {
            GoodsS1R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"GoodsS1R0"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.goodsPriceLabel.text=_erShouGood.dec_jiage;
            return cell;
        }else if (indexPath.row==1) {
            GoodsS1R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"GoodsS1R1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row==2) {
            CarS1R4TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS1R4"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
            NSDictionary *attributes = @{NSFontAttributeName:cell.textLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
            
            rect = [cell.detailText.text boundingRectWithSize:CGSizeMake(cell.textLabel.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            cell.detailText.frame=CGRectMake(cell.detailText.frame.origin.x, cell.textLabel.frame.origin.y, cell.detailText.frame.size.width, rect.height+10);
            if ([_erShouGood.miaoshu isEqualToString:@""]) {
                cell.detailText.text=@"卖家什么都没留下";
            }else{
                cell.detailText.text=_erShouGood.miaoshu;
            }
            return cell;
        }else{
            GoodsS1R3TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"GoodsS1R3"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.addressLabel.text=_erShouGood.quyu;
            return cell;
        }
    }else{
        S4R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S4R1"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.personNameLabel.text=_erShouGood.lianxiren;
        cell.phoneLabel.text=_erShouGood.phone;
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
