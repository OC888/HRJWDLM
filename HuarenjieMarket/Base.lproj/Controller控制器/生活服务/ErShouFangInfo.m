//
//  ErShouFangInfo.m
//  temp
//
//  Created by l x on 16/6/2.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ErShouFangInfo.h"

@implementation ErShouFangInfo
+(ErShouFangInfo *)parseErShouFangChuShouInfoWithDic:(NSDictionary *)dic{
    ErShouFangInfo *info =[[ErShouFangInfo alloc]init];
    
    info.chaoxiang=[dic objectForKey:@"chaoxiang"];
    info.dec_fangling=[dic objectForKey:@"dec_fangling"];
    info.dec_mianji=[dic objectForKey:@"dec_mianji"];
    info.dec_price=[dic objectForKey:@"dec_price"];
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
    info.phone=[dic objectForKey:@"phone"];
    info.quyu=[dic objectForKey:@"quyu"];
    info.title=[dic objectForKey:@"title"];
    info.xiaoqu=[dic objectForKey:@"xiaoqu"];
    info.xinxilaiyuan=[dic objectForKey:@"xinxilaiyuan"];
    
    return info;

}
@end
