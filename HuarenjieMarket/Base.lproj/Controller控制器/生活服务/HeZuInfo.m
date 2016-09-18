//
//  HeZuInfo.m
//  temp
//
//  Created by l x on 16/6/5.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "HeZuInfo.h"

@implementation HeZuInfo
+(HeZuInfo *)parseHeZuInfoWithDic:(NSDictionary *)dic{
    HeZuInfo *info =[[HeZuInfo alloc]init];
    info.biaoti=[dic objectForKey:@"biaoti"];
    info.dec_mianji=[dic objectForKey:@"dec_mianji"];
    info.dec_zujin=[dic objectForKey:@"dec_zujin"];
    info.hezuleixing=[dic objectForKey:@"hezuleixing"];
    info.dt_datetime=[dic objectForKey:@"dt_datetime"];
    info.huxing=[dic objectForKey:@"huxing"];
    info.img1=[dic objectForKey:@"img1"];
    info.img2=[dic objectForKey:@"img2"];
    info.img3=[dic objectForKey:@"img3"];
    info.img4=[dic objectForKey:@"img4"];
    info.img5=[dic objectForKey:@"img5"];
    info.img6=[dic objectForKey:@"img6"];
    info.img7=[dic objectForKey:@"img7"];
    info.lianxiren=[dic objectForKey:@"lianxiren"];
    info.louceng=[dic objectForKey:@"louceng"];
    info.miaoshu=[dic objectForKey:@"miaoshu"];
    info.peizhi=[dic objectForKey:@"peizhi"];
    info.phone=[dic objectForKey:@"phone"];
    info.quyu=[dic objectForKey:@"quyu"];
    info.xiaoquname=[dic objectForKey:@"xiaoquname"];
    info.xinxilaiyuan=[dic objectForKey:@"xinxilaiyuan"];
    info.gongxu=[dic objectForKey:@"gongxu"];
    info.shangpuleixing=[dic objectForKey:@"shangpuleixing"];
    info.dizhi=[dic objectForKey:@"dizhi"];
    info.name=[dic objectForKey:@"name"];
    info.leixing=[dic objectForKey:@"leixing"];
    info.biaozhi=[dic objectForKey:@"biaozhi"];

    return info;

}
@end
