//
//  CheckText.m
//  temp
//
//  Created by l x on 16/6/7.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "CheckText.h"

@implementation CheckText
//邮箱格式检索
+(BOOL)emailWithObject:(NSString *)text{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if ([emailTest evaluateWithObject:text])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//电话格式
+(BOOL)phoneWithObject:(NSString *)text{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:text] == YES)
        || ([regextestcm evaluateWithObject:text] == YES)
        || ([regextestct evaluateWithObject:text] == YES)
        || ([regextestcu evaluateWithObject:text] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//姓名
+(BOOL)nameWithObject:(NSString *)text{
    NSString *NAME =@"^(?:[A-Za-z]{2,4}|[\u4E00-\u9FA5\uF900-\uFA2D]{2,4})$";
    NSPredicate *regextestname = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", NAME];
    if ([regextestname evaluateWithObject:text]==YES) {
        return YES;
    }else{
        return NO;
    }
}
//行驶里程（一位小数）
//+(BOOL)driveWithObject:(NSString *)text{
//    NSString *regex = @"^\d+(\.\d{2})?$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//}
@end
