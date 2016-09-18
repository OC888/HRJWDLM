//
//  ErShouFangQiuGouInfo.m
//  temp
//
//  Created by l x on 16/6/1.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ErShouFangQiuGouInfo.h"

@implementation ErShouFangQiuGouInfo
+(ErShouFangQiuGouInfo *)parseErShouFangQiuGouInfoWithDic:(NSDictionary *)dic{
    ErShouFangQiuGouInfo *info =[[ErShouFangQiuGouInfo alloc]init];
    
    info.dec_qiwangprice=[dic objectForKey:@"dec_qiwangprice"];
    info.dt_datetime=[dic objectForKey:@"dt_datetime"];
    info.huxing=[dic objectForKey:@"huxing"];
    info.lianxiren=[dic objectForKey:@"lianxiren"];
    info.miaoshu=[dic objectForKey:@"miaoshu"];
    info.phone=[dic objectForKey:@"phone"];
    info.qiwangxiaoqu=[dic objectForKey:@"qiwangxiaoqu"];
    info.quyu=[dic objectForKey:@"quyu"];
    info.title=[dic objectForKey:@"title"];
    info.xinxilaiyuan=[dic objectForKey:@"xinxilaiyuan"];
    
    return info;
}
@end
