//
//  changeButtonView.m
//  temp
//
//  Created by l x on 16/5/21.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "changeButtonView.h"

@implementation changeButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)createWithTitleArr:(NSArray *)titleArr{
    NSMutableArray *arr=[NSMutableArray array];
    for (int i=0; i<titleArr.count; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(i*WIDTH/titleArr.count, 0, WIDTH/titleArr.count, 40);
        button.backgroundColor=[UIColor whiteColor];
        button.tag=i+1;
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:BJCOLOR forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [self addSubview:button];
        [arr addObject:button];
    }
    self.buttonArr=arr;
    for (int i=1; i<titleArr.count; i++) {
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(WIDTH/titleArr.count*i , 5, 1, 40-10)];
        view.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:view];
    }
    
    UIButton *button =_buttonArr[0];
    UIView *littleView =[[UIView alloc]init];
    littleView.center=CGPointMake(button.center.x, button.center.y+button.bounds.size.height/2);
    littleView.bounds=CGRectMake(0, 0, WIDTH/titleArr.count-20, 5);
    littleView.backgroundColor=BJCOLOR;
    [self addSubview:littleView];
    self.littleView=littleView;
}
@end
