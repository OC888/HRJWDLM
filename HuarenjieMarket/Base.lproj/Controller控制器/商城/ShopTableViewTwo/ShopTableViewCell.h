//
//  ShopTableViewCell.h
//  ScrollViewDemo
//
//  Created by 赵一 on 16/5/3.
//  Copyright © 2016年 赵一. All rights reserved.
//

#import <UIKit/UIKit.h>
@class goodModel;

@interface ShopTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *shopImage;//照片
@property (strong, nonatomic) IBOutlet UILabel *shopName;//商品名称
@property (strong, nonatomic) IBOutlet UILabel *shopDetail;//优惠券
@property (strong, nonatomic) IBOutlet UILabel *shopPrice;//价格
@property (strong, nonatomic) IBOutlet UILabel *shopOld;//门市价
@property (strong, nonatomic) IBOutlet UILabel *shopLocal;//距离
@property (strong, nonatomic) IBOutlet UILabel *shopNum;

- (void)show:(goodModel *)goodM;

@end
