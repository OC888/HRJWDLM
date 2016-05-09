//
//  ShopTableViewCell.m
//  ScrollViewDemo
//
//  Created by 赵一 on 16/5/3.
//  Copyright © 2016年 赵一. All rights reserved.
//

#import "ShopTableViewCell.h"
#import "goodModel.h"
#import "UIImageView+WebCache.h"

@implementation ShopTableViewCell

- (void)show:(goodModel *)goodM {
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:goodM.goods_image_url]];
    self.shopName.text = goodM.goods_name;
    self.shopPrice.text = [NSString stringWithFormat:@"￥%@",goodM.goods_price];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
