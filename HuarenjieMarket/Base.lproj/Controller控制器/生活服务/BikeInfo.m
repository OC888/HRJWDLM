//
//  BikeInfo.m
//  temp
//
//  Created by l x on 16/5/27.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "BikeInfo.h"

@implementation BikeInfo

+(BikeInfo *)parseResumeInfoWithDic:(NSDictionary *)dic{
    BikeInfo *bikeInfo =[[BikeInfo alloc]init];
    bikeInfo.biaoti=[dic objectForKey:@"biaoti"];
    bikeInfo.gongxubiaozhi=[dic objectForKey:@"gongxubiaozhi"];
    bikeInfo.image1=[dic objectForKey:@"image1"];
    bikeInfo.image2=[dic objectForKey:@"image2"];
    bikeInfo.image3=[dic objectForKey:@"image3"];
    bikeInfo.image4=[dic objectForKey:@"image4"];
    bikeInfo.image5=[dic objectForKey:@"image5"];
    bikeInfo.image6=[dic objectForKey:@"image6"];
    bikeInfo.image7=[dic objectForKey:@"image7"];
    bikeInfo.lianxiren=[dic objectForKey:@"lianxiren"];
    bikeInfo.miaoshu=[dic objectForKey:@"miaoshu"];
    bikeInfo.phone=[dic objectForKey:@"phone"];
    bikeInfo.price=[dic objectForKey:@"price"];
    bikeInfo.quyu=[dic objectForKey:@"quyu"];
    bikeInfo.zhonglei=[dic objectForKey:@"zhonglei"];


    return bikeInfo;
}
@end
