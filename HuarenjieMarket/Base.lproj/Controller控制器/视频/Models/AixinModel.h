//
//  AixinModel.h
//  AideoPlayProject
//
//  Created by aaa on 16/5/5.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AixinModel : NSObject
@property (nonatomic, copy) NSString *category;//类别
@property (nonatomic, assign) int shareCount;//分享量
@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *detail;//图片
@property (nonatomic, copy) NSString *playUrl;//视频链接
@property (nonatomic, copy) NSString *blurred;//背景图片
@property (nonatomic, copy) NSString *Description;
//+ (AixinModel *)shareInstance;

@end
