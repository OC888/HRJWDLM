//
//  ErShouGoods.m
//  temp
//
//  Created by l x on 16/5/31.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ErShouGoods.h"

@implementation ErShouGoods
+(ErShouGoods *)parseErShouGoodsInfoWithDic:(NSDictionary *)dic{
    ErShouGoods *erShouGoodsInfo =[[ErShouGoods alloc]init];
    erShouGoodsInfo.dec_jiage=[dic objectForKey:@"dec_jiage"];
    erShouGoodsInfo.dt_datetime=[dic objectForKey:@"dt_datetime"];
    erShouGoodsInfo.fenlei=[dic objectForKey:@"fenlei"];
    erShouGoodsInfo.gongxu=[dic objectForKey:@"gongxu"];
    erShouGoodsInfo.img1=[dic objectForKey:@"img1"];
    erShouGoodsInfo.img2=[dic objectForKey:@"img2"];
    erShouGoodsInfo.img3=[dic objectForKey:@"img3"];
    erShouGoodsInfo.img4=[dic objectForKey:@"img4"];
    erShouGoodsInfo.img5=[dic objectForKey:@"img5"];
    erShouGoodsInfo.img6=[dic objectForKey:@"img6"];
    erShouGoodsInfo.img7=[dic objectForKey:@"img7"];

    erShouGoodsInfo.laiyuan=[dic objectForKey:@"laiyuan"];
    erShouGoodsInfo.lianxiren=[dic objectForKey:@"lianxiren"];
    erShouGoodsInfo.miaoshu=[dic objectForKey:@"miaoshu"];
    erShouGoodsInfo.phone=[dic objectForKey:@"phone"];
    erShouGoodsInfo.quyu=[dic objectForKey:@"quyu"];
    erShouGoodsInfo.title=[dic objectForKey:@"title"];

    return erShouGoodsInfo;
}
@end
