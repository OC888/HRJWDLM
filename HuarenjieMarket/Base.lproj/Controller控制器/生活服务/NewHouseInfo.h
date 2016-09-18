//
//  NewHouseInfo.h
//  temp
//
//  Created by l x on 16/6/5.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewHouseInfo : NSObject
@property (nonatomic,copy) NSString *chaoxiang;
@property (nonatomic,copy) NSString *dec_fangling;
@property (nonatomic,copy) NSString *dec_jianzhumianji;
@property (nonatomic,copy) NSString *dec_shoujia;
@property (nonatomic,copy) NSString *dt_datetime;
@property (nonatomic,copy) NSString *huxing;
@property (nonatomic,copy) NSString *img1;
@property (nonatomic,copy) NSString *img2;
@property (nonatomic,copy) NSString *img3;
@property (nonatomic,copy) NSString *img4;
@property (nonatomic,copy) NSString *img5;
@property (nonatomic,copy) NSString *img6;
@property (nonatomic,copy) NSString *img7;
@property (nonatomic,copy) NSString *lianxiren;
@property (nonatomic,copy) NSString *louceng;
@property (nonatomic,copy) NSString *miaoshu;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *quyu;
@property (nonatomic,copy) NSString *xiaoquname;
@property (nonatomic,copy) NSString *xinxilaiyuan;
@property (nonatomic,copy) NSString *zhuangxiu;

+(NewHouseInfo *)parseNewHouseChuShouInfoWithDic:(NSDictionary *)dic;

@end
