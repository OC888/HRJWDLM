//
//  RentHouseDetailViewController.m
//  temp
//
//  Created by l x on 16/5/24.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "RentHouseDetailViewController.h"
#import "CarS0R0TableViewCell.h"
#import "Section1TableViewCell.h"
#import "HouseS1R0TableViewCell.h"
#import "HouseS1R1TableViewCell.h"
#import "CarS1R4TableViewCell.h"
#import "HouseS2R0TableViewCell.h"
#import "HouseS2R1TableViewCell.h"
#import "S4R1TableViewCell.h"

@interface RentHouseDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGSize rect;
}
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation RentHouseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatNavigationItem];
    [self creatTable];
    [self creatBottomView];
}
-(void)creatNavigationItem{
    if ([_biaozhi isEqualToString:@"二手房"]) {
        if (![_erShouFangInfo.xinxilaiyuan isKindOfClass:[NSNull class]]) {
            self.title=[NSString stringWithFormat:@"%@房源",_erShouFangInfo.xinxilaiyuan];
        }
    }else{
        if (![_xinFangInfo.xinxilaiyuan isKindOfClass:[NSNull class]]) {
            self.title=[NSString stringWithFormat:@"%@房源",_xinFangInfo.xinxilaiyuan];
        }
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    }

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
    if ([_biaozhi isEqualToString:@"二手房"]) {
        if (![_erShouFangInfo.phone isKindOfClass:[NSNull class]]) {
            view.phoneLabel.text=_erShouFangInfo.phone;
        }
        if (![_erShouFangInfo.lianxiren isKindOfClass:[NSNull class]]) {
            view.nameLabel.text=_erShouFangInfo.lianxiren;
        }
    }else{
        if (![_xinFangInfo.phone isKindOfClass:[NSNull class]]) {
            view.phoneLabel.text=_xinFangInfo.phone;
        }
        if (![_xinFangInfo.lianxiren isKindOfClass:[NSNull class]]) {
            view.nameLabel.text=_xinFangInfo.lianxiren;
        }
    }
    view.resumeButton.textLabel.text=@"留言";
    view.resumeButton.jobImageView.image=[UIImage imageNamed:@"gchezixun-01"];
    [view.resumeButton addTarget:self action:@selector(resumeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    view.phoneButton.textLabel.text=@"打电话";
    view.phoneButton.jobImageView.image=[UIImage imageNamed:@"gchezixun-01"];
    [view.phoneButton addTarget:self action:@selector(phoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CarS0R0TableViewCell" bundle:nil] forCellReuseIdentifier:@"CarS0R0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"Section1TableViewCell" bundle:nil] forCellReuseIdentifier:@"S1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HouseS1R0TableViewCell" bundle:nil] forCellReuseIdentifier:@"HouseS1R0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HouseS1R1TableViewCell" bundle:nil] forCellReuseIdentifier:@"HouseS1R1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CarS1R4TableViewCell" bundle:nil] forCellReuseIdentifier:@"CarS1R4"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HouseS2R0TableViewCell" bundle:nil] forCellReuseIdentifier:@"HouseS2R0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HouseS2R1TableViewCell" bundle:nil] forCellReuseIdentifier:@"HouseS2R1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"S4R1TableViewCell" bundle:nil] forCellReuseIdentifier:@"S4R1"];
    [self.view addSubview:self.tableView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else if (section==1) {
        return 3;
    }else if (section==2) {
        return 2;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return (WIDTH-10*5)/4+20;
        }else{
            return 80;
        }
    }else if (indexPath.section==1) {
        if (indexPath.row==0) {
            return 90;
        }else if (indexPath.row==1) {
            return 80;
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
    if ([_biaozhi isEqualToString:@"二手房"]) {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                CarS0R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS0R0"];
                cell.carImageScrollView.contentSize=CGSizeMake(WIDTH*2, (WIDTH-5*5)/4);
                NSArray *imageArr=@[_erShouFangInfo.img1,_erShouFangInfo.img2,_erShouFangInfo.img3,_erShouFangInfo.img4,_erShouFangInfo.img5,_erShouFangInfo.img6,_erShouFangInfo.img7];
                
                for (int i=0; i<7; i++) {
                    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10+((WIDTH-10*5)/4+10)*i, 10, (WIDTH-10*5)/4, (WIDTH-10*5)/4)];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageArr[i]] placeholderImage:[UIImage imageNamed:@"tu.png"] options:SDWebImageRefreshCached];
                    [cell.carImageScrollView addSubview:imageView];
                }
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                Section1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S1"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (![_erShouFangInfo.title isKindOfClass:[NSNull class]]) {
                    cell.titleLabel.text=_erShouFangInfo.title;
                }
                if (![_erShouFangInfo.dt_datetime isKindOfClass:[NSNull class]]) {
                    cell.timeLabel.text=[NSString stringWithFormat:@"发布时间 %@",_erShouFangInfo.dt_datetime];
                }
                return cell;
            }
        }else if (indexPath.section==1) {
            if (indexPath.row==0) {
                HouseS1R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HouseS1R0"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (![_erShouFangInfo.dec_price isKindOfClass:[NSNull class]]) {
                    cell.housePriceLabel.text=[NSString stringWithFormat:@"%d万元",[_erShouFangInfo.dec_price intValue]];
                }
                if (![_erShouFangInfo.huxing isKindOfClass:[NSNull class]]) {
                    cell.houseLabel1.text=_erShouFangInfo.huxing;
                }
                if (![_erShouFangInfo.dec_mianji isKindOfClass:[NSNull class]]) {
                    cell.houseLabel2.text=[NSString stringWithFormat:@"%d㎡",[_erShouFangInfo.dec_mianji intValue]];
                }
                if (![_erShouFangInfo.chaoxiang isKindOfClass:[NSNull class]]) {
                    cell.houseLabel3.text=[NSString stringWithFormat:@"%@朝向",_erShouFangInfo.chaoxiang];
                }
                if (![_erShouFangInfo.louceng isKindOfClass:[NSNull class]]) {
                    cell.houseLabel4.text=_erShouFangInfo.louceng;
                }
                if (![_erShouFangInfo.dec_fangling isKindOfClass:[NSNull class]]) {
                    cell.houseLabel5.text=[NSString stringWithFormat:@"%d年房龄",[_erShouFangInfo.dec_fangling intValue]];
                }
                //            if (![_info.chaoxiang isKindOfClass:[NSNull class]]) {
                //                cell.houseLabel6.text=_info.chaoxiang;
                //            }
                
                return cell;
                
            }else if (indexPath.row==1) {
                HouseS1R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HouseS1R1"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                CarS1R4TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS1R4"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (![_erShouFangInfo.miaoshu isKindOfClass:[NSNull class]]) {
                    cell.detailText.text=_erShouFangInfo.miaoshu;
                }
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
                paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
                NSDictionary *attributes = @{NSFontAttributeName:cell.textLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
                
                rect = [cell.detailText.text boundingRectWithSize:CGSizeMake(cell.textLabel.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
                cell.detailText.frame=CGRectMake(cell.detailText.frame.origin.x, cell.textLabel.frame.origin.y, cell.detailText.frame.size.width, rect.height+20);
                return cell;
            }
        }else if (indexPath.section==2) {
            if (indexPath.row==0) {
                HouseS2R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HouseS2R0"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (![_erShouFangInfo.xiaoqu isKindOfClass:[NSNull class]]) {
                    cell.xiaoquLabel.text=_erShouFangInfo.xiaoqu;
                }
                return cell;
            }else{
                HouseS2R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HouseS2R1"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (![_erShouFangInfo.quyu isKindOfClass:[NSNull class]]) {
                    cell.addressLabel.text=_erShouFangInfo.quyu;
                }
                return cell;
            }
        }else{
            S4R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S4R1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            if (![_erShouFangInfo.phone isKindOfClass:[NSNull class]]) {
                cell.phoneLabel.text=_erShouFangInfo.phone;
            }
            if (![_erShouFangInfo.lianxiren isKindOfClass:[NSNull class]]) {
                cell.personNameLabel.text=_erShouFangInfo.lianxiren;
            }
            return cell;
        }
    }else{
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                CarS0R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS0R0"];
                cell.carImageScrollView.contentSize=CGSizeMake(WIDTH*2, (WIDTH-5*5)/4);
                NSArray *imageArr=@[_xinFangInfo.img1,_xinFangInfo.img2,_xinFangInfo.img3,_xinFangInfo.img4,_xinFangInfo.img5,_xinFangInfo.img6,_xinFangInfo.img7];
                
                for (int i=0; i<7; i++) {
                    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10+((WIDTH-10*5)/4+10)*i, 10, (WIDTH-10*5)/4, (WIDTH-10*5)/4)];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageArr[i]] placeholderImage:[UIImage imageNamed:@"tu.png"] options:SDWebImageRefreshCached];
                    [cell.carImageScrollView addSubview:imageView];
                }
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                Section1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S1"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (![_xinFangInfo.title isKindOfClass:[NSNull class]]) {
                    cell.titleLabel.text=_xinFangInfo.title;
                }
                if (![_xinFangInfo.dt_datetime isKindOfClass:[NSNull class]]) {
                    cell.timeLabel.text=[NSString stringWithFormat:@"发布时间 %@",_xinFangInfo.dt_datetime];
                }
                return cell;
            }
        }else if (indexPath.section==1) {
            if (indexPath.row==0) {
                HouseS1R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HouseS1R0"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (![_xinFangInfo.dec_shoujia isKindOfClass:[NSNull class]]) {
                    cell.housePriceLabel.text=[NSString stringWithFormat:@"%d万元",[_xinFangInfo.dec_shoujia intValue]];
                }
                if (![_xinFangInfo.huxing isKindOfClass:[NSNull class]]) {
                    cell.houseLabel1.text=_xinFangInfo.huxing;
                }
                if (![_xinFangInfo.dec_jianzhumianji isKindOfClass:[NSNull class]]) {
                    cell.houseLabel2.text=[NSString stringWithFormat:@"%d㎡",[_xinFangInfo.dec_jianzhumianji intValue]];
                }
                if (![_xinFangInfo.chaoxiang isKindOfClass:[NSNull class]]) {
                    cell.houseLabel3.text=[NSString stringWithFormat:@"%@朝向",_xinFangInfo.chaoxiang];
                }
                if (![_xinFangInfo.louceng isKindOfClass:[NSNull class]]) {
                    cell.houseLabel4.text=_xinFangInfo.louceng;
                }
                if (![_xinFangInfo.zhuangxiu isKindOfClass:[NSNull class]]) {
                    cell.houseLabel5.text=_xinFangInfo.zhuangxiu;
                }
                //            if (![_info.chaoxiang isKindOfClass:[NSNull class]]) {
                //                cell.houseLabel6.text=_info.chaoxiang;
                //            }
                
                return cell;
                
            }else if (indexPath.row==1) {
                HouseS1R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HouseS1R1"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                CarS1R4TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS1R4"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (![_xinFangInfo.miaoshu isKindOfClass:[NSNull class]]) {
                    cell.detailText.text=_xinFangInfo.miaoshu;
                }
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
                paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
                NSDictionary *attributes = @{NSFontAttributeName:cell.textLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
                
                rect = [cell.detailText.text boundingRectWithSize:CGSizeMake(cell.textLabel.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
                cell.detailText.frame=CGRectMake(cell.detailText.frame.origin.x, cell.textLabel.frame.origin.y, cell.detailText.frame.size.width, rect.height+20);
                return cell;
            }
        }else if (indexPath.section==2) {
            if (indexPath.row==0) {
                HouseS2R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HouseS2R0"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (![_xinFangInfo.xiaoquname isKindOfClass:[NSNull class]]) {
                    cell.xiaoquLabel.text=_xinFangInfo.xiaoquname;
                }
                return cell;
            }else{
                HouseS2R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HouseS2R1"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (![_xinFangInfo.quyu isKindOfClass:[NSNull class]]) {
                    cell.addressLabel.text=_xinFangInfo.quyu;
                }
                return cell;
            }
        }else{
            S4R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S4R1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            if (![_xinFangInfo.phone isKindOfClass:[NSNull class]]) {
                cell.phoneLabel.text=_xinFangInfo.phone;
            }
            if (![_xinFangInfo.lianxiren isKindOfClass:[NSNull class]]) {
                cell.personNameLabel.text=_xinFangInfo.lianxiren;
            }
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
