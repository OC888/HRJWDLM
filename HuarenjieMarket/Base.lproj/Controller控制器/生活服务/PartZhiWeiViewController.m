//
//  PartZhiWeiViewController.m
//  temp
//
//  Created by l x on 16/6/3.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "PartZhiWeiViewController.h"
#import "PartViewController.h"

@interface PartZhiWeiViewController ()

@property (nonatomic,copy) NSArray *buttonTitleArr;
@end

@implementation PartZhiWeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"请选择职位类别";
    self.view.backgroundColor=LINECOLOR;
    [self creatbutton];
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

-(void)creatbutton{
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64+HEIGHT/5*2/5*7)];
    view.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view];
    _buttonTitleArr=@[@"传单派发",@"促销员",@"服务员",@"家教",@"翻译",@"会计",@"模特",@"酒吧KTV",@"礼仪小姐",@"设计制作",@"摄影师",@"实习生",@"手工制作",@"网站建设",@"问卷调查",@"钟点工",@"销售",@"学生兼职",@"其他兼职"];

    for (int i=0 ; i<19; i++) {
        int col =i%3;
        int row =i/3;
        JobButton *button =[[JobButton alloc]initWithFrame:CGRectMake(col*WIDTH/3,64+HEIGHT/5*2/5*row, WIDTH/3, HEIGHT/5*2/5)];
        [button addTarget:self action:@selector(jobButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i+1;
        button.jobImageView.image=[UIImage imageNamed:@"gchezixun-01.png"];
        button.textLabel.text=[NSString stringWithFormat:@"%@",_buttonTitleArr[i]];
        [view addSubview:button];
    }
}
-(void)jobButtonClick:(JobButton *)button{
    
    PartViewController *vc=[[PartViewController alloc]init];
    vc.zhiwei=button.textLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
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
