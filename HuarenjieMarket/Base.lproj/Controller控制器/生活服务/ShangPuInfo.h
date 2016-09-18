//
//  ShangPuInfo.h
//  temp
//
//  Created by l x on 16/6/4.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShangPuInfo : NSObject
@property (nonatomic,copy) NSString *biaozhi;
@property (nonatomic,copy) NSString *dec_mianji;
@property (nonatomic,copy) NSString *dec_price;
@property (nonatomic,copy) NSString *dizhi;
@property (nonatomic,copy) NSString *dt_datetime;
@property (nonatomic,copy) NSString *gongxu;
@property (nonatomic,copy) NSString *img1;
@property (nonatomic,copy) NSString *img2;
@property (nonatomic,copy) NSString *img3;
@property (nonatomic,copy) NSString *img4;
@property (nonatomic,copy) NSString *img5;
@property (nonatomic,copy) NSString *img6;
@property (nonatomic,copy) NSString *img7;
@property (nonatomic,copy) NSString *leixing;
@property (nonatomic,copy) NSString *lianxiren;
@property (nonatomic,copy) NSString *miaoshu;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *quyu;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *xinxilaiyuan;
@property (nonatomic,copy) NSString *zhuangxiu;

+(ShangPuInfo *)parseShangPuChuShouInfoWithDic:(NSDictionary *)dic;

@end
