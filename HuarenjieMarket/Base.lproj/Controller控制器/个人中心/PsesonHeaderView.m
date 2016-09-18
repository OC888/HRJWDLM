//
//  PsesonHeaderView.m
//  HuarenjieMarket
//
//  Created by 赵一 on 16/8/12.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "PsesonHeaderView.h"

@implementation PsesonHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"PersonHeaderView" owner:self options:nil] objectAtIndex:0];
        _PImageView.layer.cornerRadius = 49.0;
        _PImageView.layer.masksToBounds = YES;
    }
    return self;
}


@end
