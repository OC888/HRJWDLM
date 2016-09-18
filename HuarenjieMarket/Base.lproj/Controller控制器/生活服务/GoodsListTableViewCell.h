//
//  GoodsListTableViewCell.h
//  temp
//
//  Created by l x on 16/5/22.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (strong, nonatomic) IBOutlet UILabel *goodsTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *goodsDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *goodsTimeLabel;

@end
