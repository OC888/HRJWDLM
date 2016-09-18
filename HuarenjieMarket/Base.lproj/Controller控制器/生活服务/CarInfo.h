//
//  CarInfo.h
//  temp
//
//  Created by l x on 16/5/26.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarInfo : NSObject

@property (nonatomic,copy) NSString *biaoti;
@property (nonatomic,copy) NSString *brand;
@property (nonatomic,copy) NSString *color;
@property (nonatomic,copy) NSString *image1;
@property (nonatomic,copy) NSString *image2;
@property (nonatomic,copy) NSString *image3;
@property (nonatomic,copy) NSString *image4;
@property (nonatomic,copy) NSString *image5;
@property (nonatomic,copy) NSString *image6;
@property (nonatomic,copy) NSString *image7;
@property (nonatomic,copy) NSString *lianxiren;
@property (nonatomic,copy) NSString *miaoshu;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *place;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *shangpaidate;
@property (nonatomic,copy) NSString *xingshilicheng;


+(CarInfo *)parseResumeInfoWithDic:(NSDictionary *)dic;

@end
