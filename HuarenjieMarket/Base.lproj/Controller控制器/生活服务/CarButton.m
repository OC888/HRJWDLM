//
//  CarButton.m
//  temp
//
//  Created by l x on 16/5/17.
//  Copyright (c) 2016年 wangli. All rights reserved.
//
#define BUTTON_WIDTH self.bounds.size.width
#define BUTTON_HEIGHT self.bounds.size.height

#import "CarButton.h"

@implementation CarButton
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 200 / 255.0, 190 / 255.0, 204 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, BUTTON_WIDTH, 10);  //起点坐标
    CGContextAddLineToPoint(context, BUTTON_WIDTH, BUTTON_HEIGHT-10);   //终点坐标
    
    CGContextStrokePath(context);
    
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.titleLabel.font=[UIFont systemFontOfSize:14.0];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
