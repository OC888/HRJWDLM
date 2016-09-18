//
//  ResumeInfo.h
//  temp
//
//  Created by l x on 16/5/26.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResumeInfo : NSObject
@property (nonatomic,copy) NSString *biaozhi;
@property (nonatomic,copy) NSString *fabutime;
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *gongzuonianxian;
@property (nonatomic,copy) NSString *gongzuoquyu;
@property (nonatomic,copy) NSString *gongzuoshijian;
@property (nonatomic,copy) NSString *jiaxiang;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *qiuzhixuanyan;
@property (nonatomic,copy) NSString *qiwangrixin;
@property (nonatomic,copy) NSString *salary;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *touxiang;
@property (nonatomic,copy) NSString *xueli;
@property (nonatomic,copy) NSString *zhiwei;
@property (nonatomic,copy) NSString *email;


+(ResumeInfo *)parseResumeInfoWithDic:(NSDictionary *)dic;

@end
