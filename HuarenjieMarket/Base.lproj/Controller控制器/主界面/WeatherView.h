//
//  WeatherView.h
//  HuarenjieMarket
//
//  Created by 赵一 on 16/6/16.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherView : UIView
@property (strong, nonatomic) IBOutlet UILabel *numNight;

@property (strong, nonatomic) IBOutlet UILabel *num;
@property (strong, nonatomic) IBOutlet UILabel *highAndLow;
@property (strong, nonatomic) IBOutlet UILabel *wind;
@property (strong, nonatomic) IBOutlet UILabel *todatData;
@property (strong, nonatomic) IBOutlet UILabel *air;

@end
