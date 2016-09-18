//
//  BottomView.m
//  temp
//
//  Created by l x on 16/5/22.
//  Copyright © 2016年 wangli. All rights reserved.
//

#define VIEW_WIDTH self.bounds.size.width
#define VIEW_HEIGHT self.bounds.size.height

#import "BottomView.h"

@implementation BottomView

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

        self.backgroundColor=[UIColor whiteColor];
        
        self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, VIEW_WIDTH/5*2, (VIEW_HEIGHT-15)/2)];
        self.nameLabel.font=[UIFont systemFontOfSize:14.0];
        self.nameLabel.textColor=[UIColor blackColor];
        [self addSubview:self.nameLabel];
        self.phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, (VIEW_HEIGHT-15)/5*2+10, VIEW_WIDTH/5*2, (VIEW_HEIGHT-15)/2)];
        self.phoneLabel.font=[UIFont systemFontOfSize:14.0];
        self.phoneLabel.textColor=[UIColor lightGrayColor];
        [self addSubview:self.phoneLabel];

        self.resumeButton =[[JobButton alloc]initWithFrame:CGRectMake(VIEW_WIDTH/5*2+10, 5, (VIEW_WIDTH/5*3-30)/2, VIEW_HEIGHT-10)];
        [self.resumeButton setBackgroundColor:BJCOLOR];
        self.resumeButton.layer.masksToBounds=YES;
        self.resumeButton.layer.cornerRadius=5;
        self.resumeButton.textLabel.textColor=[UIColor whiteColor];
        [self addSubview:self.resumeButton];
        
        self.phoneButton =[[JobButton alloc]initWithFrame:CGRectMake(VIEW_WIDTH/5*2+20+(VIEW_WIDTH/5*3-30)/2, 5, (VIEW_WIDTH/5*3-30)/2, VIEW_HEIGHT-10)];
        self.phoneButton.layer.masksToBounds=YES;
        self.phoneButton.layer.cornerRadius=5;
        [self.phoneButton setBackgroundColor:BJCOLOR];
        self.phoneButton.textLabel.textColor=[UIColor whiteColor];
        [self addSubview:self.phoneButton];
    }
    return self;
}
@end
