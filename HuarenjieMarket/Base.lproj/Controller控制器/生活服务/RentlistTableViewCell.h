//
//  RentlistTableViewCell.h
//  temp
//
//  Created by l x on 16/5/24.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentlistTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *houseImageView;
@property (strong, nonatomic) IBOutlet UILabel *houseTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *housePriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *houseAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *houseRectLabel;
@property (strong, nonatomic) IBOutlet UILabel *houseResumTimeLabel;

@end
