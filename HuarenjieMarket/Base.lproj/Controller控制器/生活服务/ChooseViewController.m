//
//  ChooseViewController.m
//  temp
//
//  Created by l x on 16/5/18.
//  Copyright (c) 2016年 wangli. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ChooseViewController.h"

@interface ChooseViewController ()

@end

@implementation ChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//返回按钮绑定方法
-(void)doBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(id)initWithTile:(NSString *)title textArray:(NSArray *)array withKey:(NSString*)key{
    self=[super init];
    if (self) {
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 44, 44);
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;

        self.navigationItem.title=title;
        _key=key;
        _buttonArr =[NSMutableArray array];
        _labelArr =[NSMutableArray array];
        
        UIScrollView *scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        scrollView.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:242/255.0 alpha:1];
        scrollView.contentSize=CGSizeMake(WIDTH, 40*array.count+10+20+40);
        self.view=scrollView;
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 10, WIDTH, 40*array.count)];
        view.backgroundColor=[UIColor whiteColor];
        [scrollView addSubview:view];
        
        scrollView.bounces=NO;
        
        for (int i=0; i<array.count; i++) {
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(10, 40*i, WIDTH-60, 40)];
            label.text=array[i];
            label.tag=i+1;
            label.userInteractionEnabled=YES;
            label.font=[UIFont systemFontOfSize:14.0];
            label.backgroundColor=[UIColor whiteColor];
            [view addSubview:label];
            
            UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(WIDTH-40, 5+40*i, 30, 30);
            button.tag=i+1;
            [button setImage:[UIImage imageNamed:@"widget_check_e.png"] forState:UIControlStateNormal];
            [view addSubview:button];
            [_buttonArr addObject:button];
            [button addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        }
        _choosButton =[[UIButton alloc]initWithFrame:CGRectMake(10, 40*array.count+20, WIDTH-20, 40)];
        _choosButton.backgroundColor=[UIColor lightGrayColor];
        _choosButton.enabled=NO;
        _choosButton.layer.cornerRadius=5;
        _choosButton.layer.masksToBounds=YES;
        [_choosButton setTitle:@"提交修改" forState:UIControlStateNormal];
        [scrollView addSubview:_choosButton];
        self.choosButton=_choosButton;
        
    }
    return self;
}
-(void)choose:(UIButton *)button{
    for (UIButton *btn in _buttonArr) {
        [btn setImage:[UIImage imageNamed:@"widget_check_e.png"] forState:UIControlStateNormal];
    }
    [button setImage:[UIImage imageNamed:@"widget_check_s.png"] forState:UIControlStateNormal];
    self.button=button;
    _choosButton.tag=button.tag;
    [_choosButton setBackgroundColor:BJCOLOR];
    _choosButton.enabled=YES;
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
