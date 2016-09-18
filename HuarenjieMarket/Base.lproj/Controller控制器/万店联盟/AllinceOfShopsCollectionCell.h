//
//  AllinceOfShopsCollectionCell.h
//  HuarenjieMarket
//
//  Created by aaa on 16/9/13.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllinceOfShopsCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icomImageView;//店家图片

@property (weak, nonatomic) IBOutlet UILabel *shopName;//店家名字

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;//店家简介

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;//店家距离

@end
