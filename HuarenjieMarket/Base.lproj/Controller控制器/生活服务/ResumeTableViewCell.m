//
//  ResumeTableViewCell.m
//  temp
//
//  Created by l x on 16/5/17.
//  Copyright (c) 2016年 wangli. All rights reserved.
//
#define CELL_HEIGHT self.bounds.size.height

#import "ResumeTableViewCell.h"

@implementation ResumeTableViewCell
-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 200 / 255.0, 190 / 255.0, 204 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, WIDTH/4, 10);  //起点坐标
    CGContextAddLineToPoint(context, WIDTH/4, CELL_HEIGHT-10);   //终点坐标
    
    CGContextStrokePath(context);

}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDTH/4-10, CELL_HEIGHT-20)];
        self.nameLabel.textColor=BJCOLOR;
        self.nameLabel.textAlignment=NSTextAlignmentCenter;
        self.nameLabel.font=[UIFont systemFontOfSize:14.0];
        [self addSubview:self.nameLabel];
        
        self.detailTextField=[[ResumeUITextField alloc]initWithFrame:CGRectMake(WIDTH/4+10, 10, WIDTH/4*3-20, CELL_HEIGHT-20)];
        self.detailTextField.textAlignment=NSTextAlignmentLeft;
        self.detailTextField.font=[UIFont systemFontOfSize:14.0];
        [self addSubview:self.detailTextField];

    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
