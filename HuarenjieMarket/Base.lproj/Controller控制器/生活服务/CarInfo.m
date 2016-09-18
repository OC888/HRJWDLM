//
//  CarInfo.m
//  temp
//
//  Created by l x on 16/5/26.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "CarInfo.h"

@implementation CarInfo

+(CarInfo *)parseResumeInfoWithDic:(NSDictionary *)dic{
    CarInfo *carInfo =[[CarInfo alloc]init];
    carInfo.biaoti=[dic objectForKey:@"biaoti"];
    carInfo.brand=[dic objectForKey:@"brand"];
    carInfo.color=[dic objectForKey:@"color"];
    carInfo.image1=[dic objectForKey:@"image1"];
    carInfo.image2=[dic objectForKey:@"image2"];
    carInfo.image3=[dic objectForKey:@"image3"];
    carInfo.image4=[dic objectForKey:@"image4"];
    carInfo.image5=[dic objectForKey:@"image5"];
    carInfo.image6=[dic objectForKey:@"image6"];
    carInfo.image7=[dic objectForKey:@"image7"];
    carInfo.lianxiren=[dic objectForKey:@"lianxiren"];
    carInfo.miaoshu=[dic objectForKey:@"miaoshu"];
    carInfo.phone=[dic objectForKey:@"phone"];
    carInfo.place=[dic objectForKey:@"place"];
    carInfo.price=[dic objectForKey:@"price"];
    carInfo.shangpaidate=[dic objectForKey:@"shangpaidate"];
    carInfo.xingshilicheng=[dic objectForKey:@"xingshilicheng"];
    
    return carInfo;
}
@end
