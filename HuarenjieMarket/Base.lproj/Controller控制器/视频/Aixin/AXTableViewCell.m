//
//  AXTableViewCell.m
//  AideoPlayProject
//
//  Created by aaa on 16/6/20.
//  Copyright © 2016年 wangli. All rights reserved.

#import "AXTableViewCell.h"
#import "UIViewExt.h"
#import "Color+Hex.h"
#import "UIImageView+WebCache.h"

#define cellHeight [[UIScreen mainScreen] bounds].size.height/3

//获取设备的物理宽高
#define cellWidth [[UIScreen mainScreen] bounds].size.width

@implementation AXTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        [self initSubView];
    }
    return self;
}

- (void)initSubView
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight - 10)];
    [self.contentView addSubview:self.backView];
    
    _imgView = [[UIImageView alloc] initWithFrame:self.backView.bounds];
    _imgView.backgroundColor = [UIColor hexStringToColor:@"#dbdbdb"];
    _imgView.layer.masksToBounds = YES;
    _imgView.contentMode = UIViewContentModeCenter;
    _imgView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"]];
    [_imgView layer].shadowPath =[UIBezierPath bezierPathWithRect:_imgView.bounds].CGPath;
    
    [self.backView addSubview:_imgView];
    
    
    UIImage *img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"video_play_btn_bg@2x" ofType:@"png"]];
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playBtn.frame = CGRectMake((cellWidth-img.size.width)/2, (cellHeight-img.size.height)/2, img.size.width, img.size.height);
    [_playBtn setBackgroundImage:img forState:UIControlStateNormal];
    [self.backView addSubview:_playBtn];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, cellWidth - 30, 33)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.backView addSubview:_titleLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_model == nil) return;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.detail] placeholderImage:nil];
    
    self.titleLabel.text = _model.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
