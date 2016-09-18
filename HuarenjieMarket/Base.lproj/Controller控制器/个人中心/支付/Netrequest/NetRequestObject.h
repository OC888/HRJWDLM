//
//  NetRequestObject.h
//  PayObject
//
//  Created by aaa on 16/8/22.
//  Copyright © 2016年 王泉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequestObject : NSObject

#pragma GET请求
+ (void) NetRequestGETWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                WithReturnValeuBlock: (ReturnValueBlock) block
                  WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                    WithFailureBlock: (FailureBlock) failureBlock;
@end
