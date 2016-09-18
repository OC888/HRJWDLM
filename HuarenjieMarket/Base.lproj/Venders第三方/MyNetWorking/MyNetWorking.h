//
//  MyNetWorking.h
//  MyGCDs
//
//  Created by 赵一 on 16/5/17.
//  Copyright © 2016年 赵一. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^netWorkingBlock)(id data);
@interface MyNetWorking : UIViewController

+(id)CreatObject;

-(void)CreatNetWorkingWithURL:(NSString *)urls Parameter:(NSString *)body ParserData:(netWorkingBlock)passValue;
@end
