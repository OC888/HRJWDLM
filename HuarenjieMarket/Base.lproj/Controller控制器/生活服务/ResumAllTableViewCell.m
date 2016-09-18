//
//  ResumAllTableViewCell.m
//  temp
//
//  Created by l x on 16/5/22.
//  Copyright © 2016年 wangli. All rights reserved.
//
#define CELL_WIDTH self.contentView.bounds.size.width
#define CELL_HEIGHT self.contentView.bounds.size.height
#import "ResumAllTableViewCell.h"

@implementation ResumAllTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.headerImageView =[[UIImageView alloc]initWithFrame:CGRectMake(15, 15,CELL_HEIGHT , CELL_HEIGHT)];
        [self.contentView addSubview:self.headerImageView];
        
        self.titleLable=[[UILabel alloc]initWithFrame:CGRectMake(CELL_HEIGHT*1.5, 15, CELL_WIDTH-CELL_HEIGHT, 20)];
        self.titleLable.font=[UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.titleLable];
        
        self.detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(CELL_HEIGHT*1.5, 35, CELL_WIDTH-CELL_HEIGHT, 20)];
        self.detailLabel.font=[UIFont systemFontOfSize:13.0];
        self.detailLabel.textColor=[UIColor lightGrayColor];
        [self.contentView addSubview:self.detailLabel];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
