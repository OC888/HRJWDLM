//
//  JobButton.m
//  temp
//
//  Created by l x on 16/5/16.
//  Copyright (c) 2016年 wangli. All rights reserved.
//
#define BUTTON_WIDTH self.bounds.size.width
#define BUTTON_HEIGHT self.bounds.size.height

#import "JobButton.h"

@implementation JobButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 200 / 255.0, 190 / 255.0, 204 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, BUTTON_WIDTH, 5);  //起点坐标
    CGContextAddLineToPoint(context, BUTTON_WIDTH, BUTTON_HEIGHT-10);   //终点坐标
    
    CGContextStrokePath(context);
    
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.jobImageView =[[UIImageView alloc]initWithFrame:CGRectMake(BUTTON_WIDTH/7, BUTTON_HEIGHT/3, BUTTON_WIDTH/6, BUTTON_HEIGHT/3)];
        [self addSubview:self.jobImageView];
        
        self.textLabel =[[UILabel alloc]initWithFrame:CGRectMake(BUTTON_WIDTH/5*2, BUTTON_HEIGHT/3, BUTTON_WIDTH/5*3, BUTTON_HEIGHT/4)];
        self.textLabel.font=[UIFont systemFontOfSize:13.0];
        [self addSubview:self.textLabel];
        

    }
    return self;
}

@end
