//
//  FullTimeInfo.h
//  temp
//
//  Created by l x on 16/5/31.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FullTimeInfo : NSObject
@property (nonatomic,copy) NSString *area;
@property (nonatomic,copy) NSString *dec_yuexin;
@property (nonatomic,copy) NSString *dt_datetime;
@property (nonatomic,copy) NSString *gongzuodidian;
@property (nonatomic,copy) NSString *gongzuonianxian;
@property (nonatomic,copy) NSString *i_zhaopinrenshu;
@property (nonatomic,copy) NSString *lianxiren;
@property (nonatomic,copy) NSString *nianlingduan;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *xueli;
@property (nonatomic,copy) NSString *zhiweimiaoshu;
@property (nonatomic,copy) NSString *zhiwei;
@property (nonatomic,copy) NSString *gongsiname;
@property (nonatomic,copy) NSString *shisufuli;
@property (nonatomic,copy) NSString *shehuifuli;
@property (nonatomic,copy) NSString *qitafuli;
@property (nonatomic,copy) NSString *guimo;
@property (nonatomic,copy) NSString *gongsijianjie;

+(FullTimeInfo *)parseFullTimeInfoWithDic:(NSDictionary *)dic;

@end
