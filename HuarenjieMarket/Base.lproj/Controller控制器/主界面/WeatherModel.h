//
//  WeatherModel.h
//  HuarenjieMarket
//
//  Created by 赵一 on 16/6/18.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject
@property(nonatomic,copy)NSString *date;
@property(nonatomic,copy)NSString *night;

@property(nonatomic,copy)NSString *dayTime;
@property(nonatomic,copy)NSString *temperature;

@property(nonatomic,copy)NSString *week;
@property(nonatomic,copy)NSString *wind;


@end
