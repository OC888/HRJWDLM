//
//  AixinModel.m
//  AideoPlayProject
//
//  Created by aaa on 16/5/5.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "AixinModel.h"

@implementation AixinModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.Description = value;
    }
}

@end
