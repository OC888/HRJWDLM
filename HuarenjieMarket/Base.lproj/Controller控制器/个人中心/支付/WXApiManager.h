//
//  WXApiManager.h
//  PayObject
//
//  Created by aaa on 16/8/23.
//  Copyright © 2016年 王泉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXApiManager : NSObject<WXApiDelegate>
+ (instancetype)sharedManager;
@end
