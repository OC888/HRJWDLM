//
//  QiuZuInfo.h
//  temp
//
//  Created by l x on 16/6/5.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QiuZuInfo : NSObject
@property (nonatomic,copy) NSString *dec_qiwangzujin;
@property (nonatomic,copy) NSString *dt_datetime;
@property (nonatomic,copy) NSString *huxing;
@property (nonatomic,copy) NSString *gongxu;
@property (nonatomic,copy) NSString *lianxiren;
@property (nonatomic,copy) NSString *miaoshu;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *qiwangxiaoqu;
@property (nonatomic,copy) NSString *quyu;
@property (nonatomic,copy) NSString *biaoti;
@property (nonatomic,copy) NSString *xinxilaiyuan;

+(QiuZuInfo *)parseQiuZhiInfoWithDic:(NSDictionary *)dic;

@end
