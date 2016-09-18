//
//  RentHouseListTableViewCell.h
//  temp
//
//  Created by l x on 16/5/23.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentHouseListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *houseImageView;
@property (strong, nonatomic) IBOutlet UILabel *houseTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *houseAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *houoseRectLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@end
