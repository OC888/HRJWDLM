//
//  ShopCollectionViewCell2.h
//  shangchengDemo
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodModel.h"
@interface ShopCollectionViewCell2 : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *good_image;
@property (weak, nonatomic) IBOutlet UILabel *good_name;

- (void)show:(goodModel *)goodM;
@end
