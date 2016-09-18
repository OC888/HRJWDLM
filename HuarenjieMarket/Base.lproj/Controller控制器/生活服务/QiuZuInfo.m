//
//  QiuZuInfo.m
//  temp
//
//  Created by l x on 16/6/5.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "QiuZuInfo.h"

@implementation QiuZuInfo
+(QiuZuInfo *)parseQiuZhiInfoWithDic:(NSDictionary *)dic{
    QiuZuInfo *info =[[QiuZuInfo alloc]init];
    
    info.biaoti=[dic objectForKey:@"biaoti"];
    info.dec_qiwangzujin=[dic objectForKey:@"dec_qiwangzujin"];
    info.dt_datetime=[dic objectForKey:@"dt_datetime"];
    info.huxing=[dic objectForKey:@"huxing"];
    info.lianxiren=[dic objectForKey:@"lianxiren"];
    info.miaoshu=[dic objectForKey:@"miaoshu"];
    info.phone=[dic objectForKey:@"phone"];
    info.quyu=[dic objectForKey:@"quyu"];
    info.xinxilaiyuan=[dic objectForKey:@"xinxilaiyuan"];
    
    return info;
}
@end
