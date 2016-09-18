//
//  ShangPuInfo.m
//  temp
//
//  Created by l x on 16/6/4.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ShangPuInfo.h"

@implementation ShangPuInfo

+(ShangPuInfo *)parseShangPuChuShouInfoWithDic:(NSDictionary *)dic{
    ShangPuInfo *info =[[ShangPuInfo alloc]init];
    info.biaozhi=[dic objectForKey:@"biaozhi"];
    info.dec_mianji=[dic objectForKey:@"dec_mianji"];
    info.dec_price=[dic objectForKey:@"dec_price"];
    info.dizhi=[dic objectForKey:@"dizhi"];
    info.dt_datetime=[dic objectForKey:@"dt_datetime"];
    info.gongxu=[dic objectForKey:@"gongxu"];
    info.img1=[dic objectForKey:@"img1"];
    info.img2=[dic objectForKey:@"img2"];
    info.img3=[dic objectForKey:@"img3"];
    info.img4=[dic objectForKey:@"img4"];
    info.img5=[dic objectForKey:@"img5"];
    info.img6=[dic objectForKey:@"img6"];
    info.img7=[dic objectForKey:@"img7"];
    info.leixing=[dic objectForKey:@"leixing"];
    info.lianxiren=[dic objectForKey:@"lianxiren"];
    info.miaoshu=[dic objectForKey:@"miaoshu"];
    info.phone=[dic objectForKey:@"phone"];
    info.quyu=[dic objectForKey:@"quyu"];
    info.title=[dic objectForKey:@"title"];
    info.xinxilaiyuan=[dic objectForKey:@"xinxilaiyuan"];
    info.xinxilaiyuan=[dic objectForKey:@"zhuangxiu"];

    return info;
}
@end
