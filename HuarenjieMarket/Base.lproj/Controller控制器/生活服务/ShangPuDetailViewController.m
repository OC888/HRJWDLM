//
//  ShangPuDetailViewController.m
//  temp
//
//  Created by l x on 16/6/4.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ShangPuDetailViewController.h"
#import "CarS0R0TableViewCell.h"
#import "Section1TableViewCell.h"
#import "GoodsS1R0TableViewCell.h"
#import "ShangPuS1R1TableViewCell.h"
#import "CarS1R4TableViewCell.h"
#import "HouseS2R0TableViewCell.h"
#import "S4R1TableViewCell.h"
#import "XieZiLouS1R0TableViewCell.h"

@interface ShangPuDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGSize rect;
}
@property (nonatomic,strong) UITableView *tableView;


@end

@implementation ShangPuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNavigationItem];
    [self creatTable];
    [self creatBottomView];
}
-(void)creatNavigationItem{
    if ([_biaozhi isEqualToString:@"商铺出售"]) {
        if (![_info.xinxilaiyuan isKindOfClass:[NSNull class]]) {
            self.title=[NSString stringWithFormat:@"%@房源",_info.xinxilaiyuan];
        }
    }else{
        if (![_heZuInfo.xinxilaiyuan isKindOfClass:[NSNull class]]) {
            self.title=[NSString stringWithFormat:@"%@房源",_heZuInfo.xinxilaiyuan];
        }
    }
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
    if ([_biaozhi isEqualToString:@"商铺出售"]) {
        if (![_info.phone isKindOfClass:[NSNull class]]) {
            view.phoneLabel.text=_info.phone;
        }
        if (![_info.lianxiren isKindOfClass:[NSNull class]]) {
            view.nameLabel.text=_info.lianxiren;
        }
    }else{
        if (![_heZuInfo.phone isKindOfClass:[NSNull class]]) {
            view.phoneLabel.text=_heZuInfo.phone;
        }
        if (![_heZuInfo.lianxiren isKindOfClass:[NSNull class]]) {
            view.nameLabel.text=_heZuInfo.lianxiren;
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
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsS1R0TableViewCell" bundle:nil] forCellReuseIdentifier:@"GoodsS1R0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShangPuS1R1TableViewCell" bundle:nil] forCellReuseIdentifier:@"ShangPuS1R1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CarS1R4TableViewCell" bundle:nil] forCellReuseIdentifier:@"CarS1R4"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HouseS2R0TableViewCell" bundle:nil] forCellReuseIdentifier:@"HouseS2R0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"S4R1TableViewCell" bundle:nil] forCellReuseIdentifier:@"S4R1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XieZiLouS1R0TableViewCell" bundle:nil] forCellReuseIdentifier:@"XieZiLouS1R0"];
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
        if ([_biaozhi isEqualToString:@"写字楼出租"]) {
            return 2;
        }else{
            return 1;
        }
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
            return 50;
        }else if (indexPath.row==1) {
            return 75;
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
    if ([_biaozhi isEqualToString:@"商铺出售"]) {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                CarS0R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS0R0"];
                cell.carImageScrollView.contentSize=CGSizeMake(WIDTH*2, (WIDTH-5*5)/4);
                NSArray *imageArr=@[_info.img1,_info.img2,_info.img3,_info.img4,_info.img5,_info.img6,_info.img7];
                
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
                if (![_info.title isKindOfClass:[NSNull class]]) {
                    cell.titleLabel.text=_info.title;
                }
                if (![_info.dt_datetime isKindOfClass:[NSNull class]]) {
                    cell.timeLabel.text=[NSString stringWithFormat:@"发布时间 %@",_info.dt_datetime];
                }
                return cell;
            }
        }else if (indexPath.section==1) {
            if (indexPath.row==0) {
                GoodsS1R0TableViewCell*cell =[tableView dequeueReusableCellWithIdentifier:@"GoodsS1R0"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (![_info.dec_price isKindOfClass:[NSNull class]]) {
                    cell.goodsPriceLabel.text=[NSString stringWithFormat:@"%d万元",[_info.dec_price intValue]];
                }
                return cell;
                
            }else if (indexPath.row==1) {
                if ([_biaozhi isEqualToString:@"商铺出售"]) {
                    ShangPuS1R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ShangPuS1R1"];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.rectLabel.text=[NSString stringWithFormat:@"%d㎡",[_info.dec_mianji intValue]];
                    cell.leixingLabel.text=_info.leixing;
                    cell.jingyingLabel.text=@"其他";
                    return cell;
                }else if ([_biaozhi isEqualToString:@"写字楼出售"]){
                    XieZiLouS1R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"XieZiLouS1R0"];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.rectLabel.text=[NSString stringWithFormat:@"%d㎡",[_info.dec_mianji intValue]];
                    cell.leixingLabel.text=_info.leixing;
                    return cell;
                }else{
                    XieZiLouS1R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"XieZiLouS1R0"];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.rectLabel.text=[NSString stringWithFormat:@"%d㎡",[_info.dec_mianji intValue]];
                    cell.leixingLabel.text=_info.leixing;
                    return cell;
                }
            }else{
                CarS1R4TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS1R4"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (![_info.miaoshu isKindOfClass:[NSNull class]]) {
                    cell.detailText.text=_info.miaoshu;
                }
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
                paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
                NSDictionary *attributes = @{NSFontAttributeName:cell.textLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
                
                rect = [cell.detailText.text boundingRectWithSize:CGSizeMake(cell.textLabel.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
                cell.detailText.frame=CGRectMake(cell.detailText.frame.origin.x, cell.textLabel.frame.origin.y, cell.detailText.frame.size.width, rect.height+20);
                return cell;
            }
        }else if (indexPath.section==2) {
            HouseS2R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HouseS2R0"];
            cell.xiaoquTitleLabel.text=@"地       址";
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            if (![_info.dizhi isKindOfClass:[NSNull class]]) {
                cell.xiaoquLabel.text=[NSString stringWithFormat:@"%@ %@",_info.quyu,_info.dizhi];
            }
            return cell;
        }else{
            S4R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S4R1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            if (![_info.phone isKindOfClass:[NSNull class]]) {
                cell.phoneLabel.text=_info.phone;
            }
            if (![_info.lianxiren isKindOfClass:[NSNull class]]) {
                cell.personNameLabel.text=_info.lianxiren;
            }
            return cell;
        }
    }else{
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                CarS0R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS0R0"];
                cell.carImageScrollView.contentSize=CGSizeMake(WIDTH*2, (WIDTH-5*5)/4);
                NSArray *imageArr=@[_heZuInfo.img1,_heZuInfo.img2,_heZuInfo.img3,_heZuInfo.img4,_heZuInfo.img5,_heZuInfo.img6,_heZuInfo.img7];
                
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
                if (![_heZuInfo.biaoti isKindOfClass:[NSNull class]]) {
                    cell.titleLabel.text=_heZuInfo.biaoti;
                }
                if (![_heZuInfo.dt_datetime isKindOfClass:[NSNull class]]) {
                    cell.timeLabel.text=[NSString stringWithFormat:@"发布时间 %@",_heZuInfo.dt_datetime];
                }
                return cell;
            }
        }else if (indexPath.section==1) {
            if (indexPath.row==0) {
                GoodsS1R0TableViewCell*cell =[tableView dequeueReusableCellWithIdentifier:@"GoodsS1R0"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (![_heZuInfo.dec_zujin isKindOfClass:[NSNull class]]) {
                    cell.goodsPriceLabel.text=[NSString stringWithFormat:@"%d万元",[_heZuInfo.dec_zujin intValue]];
                }
                return cell;
                
            }else if (indexPath.row==1) {
                if ([_biaozhi isEqualToString:@"商铺出租"]) {
                    ShangPuS1R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ShangPuS1R1"];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.rectLabel.text=[NSString stringWithFormat:@"%d㎡",[_heZuInfo.dec_mianji intValue]];
                    cell.leixingLabel.text=_heZuInfo.shangpuleixing;
                    cell.jingyingLabel.text=@"其他";
                    return cell;
                }else if ([_biaozhi isEqualToString:@"写字楼出租"]){
                    XieZiLouS1R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"XieZiLouS1R0"];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.rectLabel.text=[NSString stringWithFormat:@"%d㎡",[_heZuInfo.dec_mianji intValue]];
                    cell.leixingLabel.text=_heZuInfo.leixing;
                    return cell;
                }else{
                    XieZiLouS1R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"XieZiLouS1R0"];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.rectLabel.text=[NSString stringWithFormat:@"%d㎡",[_heZuInfo.dec_mianji intValue]];
                    cell.leixingLabel.text=_heZuInfo.leixing;
                    return cell;
                }
            }else{
                CarS1R4TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CarS1R4"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (![_heZuInfo.miaoshu isKindOfClass:[NSNull class]]) {
                    cell.detailText.text=_heZuInfo.miaoshu;
                }
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
                paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
                NSDictionary *attributes = @{NSFontAttributeName:cell.textLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
                
                rect = [cell.detailText.text boundingRectWithSize:CGSizeMake(cell.textLabel.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
                cell.detailText.frame=CGRectMake(cell.detailText.frame.origin.x, cell.textLabel.frame.origin.y, cell.detailText.frame.size.width, rect.height+20);
                return cell;
            }
        }else if (indexPath.section==2) {
            if ([_biaozhi isEqualToString:@"写字楼出租"]) {
                HouseS2R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HouseS2R0"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (indexPath.row==0) {
                    cell.xiaoquTitleLabel.text=@"名       称";
                    if (![_heZuInfo.dizhi isKindOfClass:[NSNull class]]) {
                        cell.xiaoquLabel.text=_heZuInfo.name;
                    }
                }else{
                    cell.xiaoquTitleLabel.text=@"地       址";
                    if (![_heZuInfo.dizhi isKindOfClass:[NSNull class]]) {
                        cell.xiaoquLabel.text=[NSString stringWithFormat:@"%@ %@",_heZuInfo.quyu,_heZuInfo.dizhi];
                    }
                }
                return cell;
            }else{
                HouseS2R0TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HouseS2R0"];
                cell.xiaoquTitleLabel.text=@"地       址";
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (![_heZuInfo.dizhi isKindOfClass:[NSNull class]]) {
                    cell.xiaoquLabel.text=[NSString stringWithFormat:@"%@ %@",_heZuInfo.quyu,_heZuInfo.dizhi];
                }
                return cell;
            }
        }else{
            S4R1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"S4R1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            if (![_heZuInfo.phone isKindOfClass:[NSNull class]]) {
                cell.phoneLabel.text=_heZuInfo.phone;
            }
            if (![_heZuInfo.lianxiren isKindOfClass:[NSNull class]]) {
                cell.personNameLabel.text=_heZuInfo.lianxiren;
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
