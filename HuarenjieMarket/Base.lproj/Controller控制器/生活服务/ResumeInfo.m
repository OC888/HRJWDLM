//
//  ResumeInfo.m
//  temp
//
//  Created by l x on 16/5/26.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ResumeInfo.h"

@implementation ResumeInfo

+(ResumeInfo *)parseResumeInfoWithDic:(NSDictionary *)dic{
    ResumeInfo *resumeInfo =[[ResumeInfo alloc]init];
    resumeInfo.biaozhi=[dic objectForKey:@"biaozhi"];
    resumeInfo.birthday=[dic objectForKey:@"birthday"];
    resumeInfo.email=[dic objectForKey:@"email"];
    resumeInfo.fabutime=[dic objectForKey:@"fabutime"];
    resumeInfo.gongzuonianxian=[dic objectForKey:@"gongzuonianxian"];
    resumeInfo.gongzuoquyu=[dic objectForKey:@"gongzuoquyu"];
    resumeInfo.gongzuoshijian=[dic objectForKey:@"gongzuoshijian"];
    resumeInfo.jiaxiang=[dic objectForKey:@"jiaxiang"];
    resumeInfo.name=[dic objectForKey:@"name"];
    resumeInfo.phone=[dic objectForKey:@"phone"];
    resumeInfo.qiuzhixuanyan=[dic objectForKey:@"qiuzhixuanyan"];
    resumeInfo.qiwangrixin=[dic objectForKey:@"qiwangrixin"];
    resumeInfo.salary=[dic objectForKey:@"salary"];
    resumeInfo.sex=[dic objectForKey:@"sex"];
    resumeInfo.touxiang=[dic objectForKey:@"touxiang"];
    resumeInfo.xueli=[dic objectForKey:@"xueli"];
    resumeInfo.zhiwei=[dic objectForKey:@"zhiwei"];
    
    return resumeInfo;
}
@end
