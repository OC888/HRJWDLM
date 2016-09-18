//
//  ErShouFangQiuGouInfo.h
//  temp
//
//  Created by l x on 16/6/1.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErShouFangQiuGouInfo : NSObject

@property (nonatomic,copy) NSString *dec_qiwangprice;
@property (nonatomic,copy) NSString *dt_datetime;
@property (nonatomic,copy) NSString *huxing;
@property (nonatomic,copy) NSString *gongxu;
@property (nonatomic,copy) NSString *lianxiren;
@property (nonatomic,copy) NSString *miaoshu;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *qiwangxiaoqu;
@property (nonatomic,copy) NSString *quyu;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *xinxilaiyuan;

+(ErShouFangQiuGouInfo *)parseErShouFangQiuGouInfoWithDic:(NSDictionary *)dic;
@end
