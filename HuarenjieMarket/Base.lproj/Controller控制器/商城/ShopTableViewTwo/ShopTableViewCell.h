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
@property (strong, nonatomic) IBOutlet UIImageView *shopImage;
@property (strong, nonatomic) IBOutlet UILabel *shopName;
@property (strong, nonatomic) IBOutlet UILabel *shopDetail;
@property (strong, nonatomic) IBOutlet UILabel *shopPrice;
@property (strong, nonatomic) IBOutlet UILabel *shopOld;
@property (strong, nonatomic) IBOutlet UILabel *shopLocal;
@property (strong, nonatomic) IBOutlet UILabel *shopNum;

- (void)show:(goodModel *)goodM;

@end
