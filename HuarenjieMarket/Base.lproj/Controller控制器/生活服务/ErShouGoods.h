//
//  ErShouGoods.h
//  temp
//
//  Created by l x on 16/5/31.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErShouGoods : NSObject
@property (nonatomic,copy) NSString *dec_jiage;
@property (nonatomic,copy) NSString *dt_datetime;
@property (nonatomic,copy) NSString *fenlei;
@property (nonatomic,copy) NSString *gongxu;
@property (nonatomic,copy) NSString *img1;
@property (nonatomic,copy) NSString *img2;
@property (nonatomic,copy) NSString *img3;
@property (nonatomic,copy) NSString *img4;
@property (nonatomic,copy) NSString *img5;
@property (nonatomic,copy) NSString *img6;
@property (nonatomic,copy) NSString *img7;
@property (nonatomic,copy) NSString *laiyuan;
@property (nonatomic,copy) NSString *lianxiren;
@property (nonatomic,copy) NSString *miaoshu;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *quyu;
@property (nonatomic,copy) NSString *title;

+(ErShouGoods *)parseErShouGoodsInfoWithDic:(NSDictionary *)dic;

@end
