//
//  FullTimeInfo.m
//  temp
//
//  Created by l x on 16/5/31.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "FullTimeInfo.h"

@implementation FullTimeInfo
+(FullTimeInfo *)parseFullTimeInfoWithDic:(NSDictionary *)dic{
    FullTimeInfo *fullTimeInfo =[[FullTimeInfo alloc]init];
    fullTimeInfo.area=[dic objectForKey:@"area"];
    fullTimeInfo.dec_yuexin=[dic objectForKey:@"dec_yuexin"];
    fullTimeInfo.dt_datetime=[dic objectForKey:@"dt_datetime"];
    fullTimeInfo.gongzuodidian=[dic objectForKey:@"gongzuodidian"];
    fullTimeInfo.gongzuonianxian=[dic objectForKey:@"gongzuonianxian"];
    fullTimeInfo.i_zhaopinrenshu=[dic objectForKey:@"i_zhaopinrenshu"];
    fullTimeInfo.lianxiren=[dic objectForKey:@"lianxiren"];
    fullTimeInfo.nianlingduan=[dic objectForKey:@"nianlingduan"];
    fullTimeInfo.phone=[dic objectForKey:@"phone"];
    fullTimeInfo.title=[dic objectForKey:@"title"];
    fullTimeInfo.xueli=[dic objectForKey:@"xueli"];
    fullTimeInfo.zhiweimiaoshu=[dic objectForKey:@"zhiweimiaoshu"];
    fullTimeInfo.zhiwei=[dic objectForKey:@"zhiwei"];
    fullTimeInfo.gongsiname=[dic objectForKey:@"gongsiname"];
    fullTimeInfo.shisufuli=[dic objectForKey:@"shisufuli"];
    fullTimeInfo.shehuifuli=[dic objectForKey:@"shehuifuli"];
    fullTimeInfo.qitafuli=[dic objectForKey:@"qitafuli"];
    fullTimeInfo.guimo=[dic objectForKey:@"guimo"];
    fullTimeInfo.gongsijianjie=[dic objectForKey:@"gongsijianjie"];

    return fullTimeInfo;
}

@end
