//
//  ChooseShiJianViewController.m
//  temp
//
//  Created by l x on 16/6/3.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ChooseShiJianViewController.h"

@interface ChooseShiJianViewController ()

@end

@implementation ChooseShiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(id)initWithTile:(NSString *)title textArray:(NSArray *)array withKey:(NSString*)key{
    self=[super init];
    if (self) {
        
        self.navigationItem.title=title;
        _key=key;
        _buttonArr =[NSMutableArray array];
        _selectButtonArr =[NSMutableArray array];
        _labelArr =[NSMutableArray array];
        _tagArr =[NSMutableArray array];
        
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
            
            BoolButton *button =[[BoolButton alloc]init];
            button.frame=CGRectMake(WIDTH-40, 5+40*i, 30, 30);
            button.tag=i+1;
            button.isSelect=NO;
            [button setImage:[UIImage imageNamed:@"widget_check_e.png"] forState:UIControlStateNormal];
            [view addSubview:button];
            [_buttonArr addObject:button];
            [button addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        }
        _choosButton =[[BoolButton alloc]init];
        _choosButton.frame=CGRectMake(10, 40*array.count+20, WIDTH-20, 40);
        _choosButton.backgroundColor=[UIColor lightGrayColor];
        _choosButton.enabled=NO;
        _choosButton.layer.cornerRadius=5;
        _choosButton.layer.masksToBounds=YES;
        [_choosButton setTitle:@"确定" forState:UIControlStateNormal];
        [scrollView addSubview:_choosButton];
        self.choosButton=_choosButton;
        
    }
    return self;
}
-(void)choose:(BoolButton *)button{
    if (button.tag==8) {
        if (button.isSelect==NO) {
            for (BoolButton *btn in _buttonArr) {
                [btn setImage:[UIImage imageNamed:@"widget_check_s.png"] forState:UIControlStateNormal];
                btn.isSelect=YES;
                self.choosButton.tag=8;
                [_selectButtonArr addObject:btn];
            }
        }else{
            for (BoolButton *btn in _buttonArr) {
                [btn setImage:[UIImage imageNamed:@"widget_check_e.png"] forState:UIControlStateNormal];
                btn.isSelect=NO;
                [_selectButtonArr removeAllObjects];
            }
        }
    }else{
        if (button.isSelect==NO) {
            [button setImage:[UIImage imageNamed:@"widget_check_s.png"] forState:UIControlStateNormal];
            button.isSelect=YES;
            self.button=button;
            _choosButton.tag=button.tag;
            NSNumber *number =[NSNumber numberWithInteger:button.tag];
            [_tagArr addObject:number];
            [_selectButtonArr addObject:button];
        }else{
            [button setImage:[UIImage imageNamed:@"widget_check_e.png"] forState:UIControlStateNormal];
            button.isSelect=NO;
            self.button=button;
            NSNumber *number =[NSNumber numberWithInteger:button.tag];
            [_tagArr removeObject:number];
            [_selectButtonArr removeObject:button];
        }
    }
    if (_selectButtonArr.count>0) {
        _choosButton.backgroundColor=BJCOLOR;
        _choosButton.enabled=YES;
    }else{
        _choosButton.backgroundColor=[UIColor lightGrayColor];
        _choosButton.enabled=NO;
    }
    _choosButton.tagArr=_tagArr;
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
