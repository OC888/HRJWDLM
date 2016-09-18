//
//  CarListTableViewCell.h
//  temp
//
//  Created by l x on 16/5/21.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *carImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end
