//
//  SelectCarButton.m
//  temp
//
//  Created by l x on 16/5/17.
//  Copyright (c) 2016年 wangli. All rights reserved.
//
#define BUTTON_WIDTH self.bounds.size.width
#define BUTTON_HEIGHT self.bounds.size.height

#import "SelectCarButton.h"

@implementation SelectCarButton

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
        self.carImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT-20*2)];
        [self addSubview:self.carImageView];
        
        self.carNameLable=[[UILabel alloc]initWithFrame:CGRectMake(0, BUTTON_HEIGHT-20*2, BUTTON_WIDTH, 20)];
        self.carNameLable.font=[UIFont systemFontOfSize:12.0];
        self.carNameLable.textColor=[UIColor lightGrayColor];
        self.carNameLable.textAlignment=NSTextAlignmentCenter;
        [self addSubview:self.carNameLable];
        
        self.carPriceLable=[[UILabel alloc]initWithFrame:CGRectMake(0, BUTTON_HEIGHT-20, BUTTON_WIDTH, 20)];
        self.carPriceLable.font=[UIFont systemFontOfSize:12.0];
        self.carPriceLable.textAlignment=NSTextAlignmentCenter;

        self.carPriceLable.textColor=[UIColor orangeColor];
        [self addSubview:self.carPriceLable];

    }
    return self;
}
@end
