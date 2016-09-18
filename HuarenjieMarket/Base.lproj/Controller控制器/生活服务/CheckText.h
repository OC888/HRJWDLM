//
//  CheckText.h
//  temp
//
//  Created by l x on 16/6/7.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckText : NSObject
//邮箱
+(BOOL)emailWithObject:(NSString *)text;
//电话
+(BOOL)phoneWithObject:(NSString *)text;
//姓名
+(BOOL)nameWithObject:(NSString *)text;
//行驶里程（一位小数）
//+(BOOL)driveWithObject:(NSString *)text;
@end
