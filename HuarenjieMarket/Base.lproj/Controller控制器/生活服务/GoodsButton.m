//
//  GoodsButton.m
//  temp
//
//  Created by l x on 16/5/17.
//  Copyright (c) 2016年 wangli. All rights reserved.
//
#define BUTTON_WIDTH self.bounds.size.width
#define BUTTON_HEIGHT self.bounds.size.height

#import "GoodsButton.h"

@implementation GoodsButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        self.goodImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, BUTTON_WIDTH-40, BUTTON_HEIGHT-50)];
        [self addSubview:self.goodImageView];
        
        self.goodNameLable=[[UILabel alloc]initWithFrame:CGRectMake(0, BUTTON_HEIGHT-20, BUTTON_WIDTH, 20)];
        self.goodNameLable.font=[UIFont systemFontOfSize:12.0];
        self.goodNameLable.textAlignment=NSTextAlignmentCenter;
        [self addSubview:self.goodNameLable];
    }
    return self;
}
@end
