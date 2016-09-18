//
//  GoodsButton1.m
//  temp
//
//  Created by aaa on 16/5/9.
//  Copyright © 2016年 wangli. All rights reserved.
//

#define BUTTON_WIDTH self.bounds.size.width
#define BUTTON_HEIGHT self.bounds.size.height
#import "GoodsButton1.h"

@implementation GoodsButton1

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 200 / 255.0, 190 / 255.0, 204 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, BUTTON_WIDTH, 0);  //起点坐标
    CGContextAddLineToPoint(context, BUTTON_WIDTH, BUTTON_HEIGHT);   //终点坐标
    
    CGContextStrokePath(context);

}
-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        _textLael =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, BUTTON_WIDTH/3*2-20, BUTTON_HEIGHT/3)];
        _textLael.font=[UIFont systemFontOfSize:14.0];
        _textLael.text=@"二手优品";
        [self addSubview:_textLael];
        
        _detailTextLael =[[UILabel alloc]initWithFrame:CGRectMake(10, 10+BUTTON_HEIGHT/3, BUTTON_WIDTH/3*2-20, BUTTON_HEIGHT/3)];
        _detailTextLael.font=[UIFont systemFontOfSize:12.0];
        _detailTextLael.text=@"iPhone降价百元";
        _detailTextLael.textColor=[UIColor lightGrayColor];
        [self addSubview:_detailTextLael];
        
        _imageVieww =[[UIImageView alloc]initWithFrame:CGRectMake(BUTTON_WIDTH/3*2, 10, BUTTON_WIDTH/4, BUTTON_HEIGHT-15)];
        _imageVieww.image=[UIImage imageNamed:@"secondhand_anchor_img"];
        [self addSubview:_imageVieww];
    }
    return self;
}

@end
