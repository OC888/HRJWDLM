//
//  ZhuboModel.h
//  AideoPlayProject
//
//  Created by aaa on 16/5/11.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhuboModel : NSObject
@property (nonatomic) NSInteger viewerNum;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *imgPath;
@property (nonatomic, copy) NSString *songName;
@property (nonatomic) NSInteger roomId;

@end
