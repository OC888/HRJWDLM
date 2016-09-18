//
//  RiZuDuanZu.m
//  temp
//
//  Created by l x on 16/6/6.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "RiZuDuanZu.h"

@implementation RiZuDuanZu
+(RiZuDuanZu *)parseRiZuInfoWithDic:(NSDictionary *)dic{
    RiZuDuanZu *info =[[RiZuDuanZu alloc]init];
    
    info.biaoti=[dic objectForKey:@"biaoti"];
    info.dec_zujin=[dic objectForKey:@"dec_zujin"];
    info.dizhi=[dic objectForKey:@"dizhi"];
    info.dt_datetime=[dic objectForKey:@"dt_datetime"];
    info.img1=[dic objectForKey:@"img1"];
    info.img2=[dic objectForKey:@"img2"];
    info.img3=[dic objectForKey:@"img3"];
    info.img4=[dic objectForKey:@"img4"];
    info.img5=[dic objectForKey:@"img5"];
    info.img6=[dic objectForKey:@"img6"];
    info.img7=[dic objectForKey:@"img7"];
    info.duanzuleixing=[dic objectForKey:@"duanzuleixing"];
    info.fangwuleixing=[dic objectForKey:@"fangwuleixing"];
    info.lianxiren=[dic objectForKey:@"lianxiren"];
    info.miaoshu=[dic objectForKey:@"miaoshu"];
    info.phone=[dic objectForKey:@"phone"];
    info.quyu=[dic objectForKey:@"quyu"];
    info.xinxilaiyuan=[dic objectForKey:@"xinxilaiyuan"];
    return info;
}

@end
