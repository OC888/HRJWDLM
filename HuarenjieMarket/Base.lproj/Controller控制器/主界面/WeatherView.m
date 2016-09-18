//
//  WeatherView.m
//  HuarenjieMarket
//
//  Created by 赵一 on 16/6/16.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "WeatherView.h"

@implementation WeatherView
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WeatherView" owner:self options:nil] objectAtIndex:0];
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
