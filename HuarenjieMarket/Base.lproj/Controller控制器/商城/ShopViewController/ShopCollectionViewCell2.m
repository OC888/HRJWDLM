//
//  ShopCollectionViewCell2.m
//  shangchengDemo
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "ShopCollectionViewCell2.h"
#import "UIImageView+WebCache.h"
#import "goodModel.h"

@implementation ShopCollectionViewCell2



- (void)show:(goodModel *)goodM {
    [self.good_image sd_setImageWithURL:[NSURL URLWithString:goodM.goods_image]];
    self.good_name.text = goodM.goods_name;
    
}
@end
