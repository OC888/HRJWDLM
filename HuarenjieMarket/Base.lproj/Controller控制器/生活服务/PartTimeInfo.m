//
//  PartTimeInfo.m
//  temp
//
//  Created by l x on 16/6/3.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "PartTimeInfo.h"

@implementation PartTimeInfo
+(PartTimeInfo *)parsePartTimeInfoWithDic:(NSDictionary *)dic{
    PartTimeInfo *fullTimeInfo =[[PartTimeInfo alloc]init];
    fullTimeInfo.area=[dic objectForKey:@"area"];
    fullTimeInfo.dec_xinzi=[dic objectForKey:@"dec_xinzi"];
    fullTimeInfo.dt_datetime=[dic objectForKey:@"dt_datetime"];
    fullTimeInfo.gongsijianjie=[dic objectForKey:@"gongsijianjie"];
    fullTimeInfo.gongsiname=[dic objectForKey:@"gongsiname"];
    fullTimeInfo.gongzuodidian=[dic objectForKey:@"gongzuodidian"];
    fullTimeInfo.gongzuonianxian=[dic objectForKey:@"gongzuonianxian"];
    fullTimeInfo.gongzuoshijian=[dic objectForKey:@"gongzuoshijian"];
    fullTimeInfo.guimo=[dic objectForKey:@"guimo"];
    fullTimeInfo.i_zhaopinrenshu=[dic objectForKey:@"i_zhaopinrenshu"];
    fullTimeInfo.lianxiren=[dic objectForKey:@"lianxiren"];
    fullTimeInfo.zhiweimiaoshu=[dic objectForKey:@"zhiweimiaoshu"];
    fullTimeInfo.nianlingduan=[dic objectForKey:@"nianlingduan"];
    fullTimeInfo.phone=[dic objectForKey:@"phone"];
    fullTimeInfo.qitafuli=[dic objectForKey:@"qitafuli"];
    fullTimeInfo.shehuifuli=[dic objectForKey:@"shehuifuli"];
    fullTimeInfo.shisufuli=[dic objectForKey:@"shisufuli"];
    fullTimeInfo.title=[dic objectForKey:@"title"];
    fullTimeInfo.xueli=[dic objectForKey:@"xueli"];
    fullTimeInfo.zhiwei=[dic objectForKey:@"zhiwei"];

    return fullTimeInfo;
}

@end
