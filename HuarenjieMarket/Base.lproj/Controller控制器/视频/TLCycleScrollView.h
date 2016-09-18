//
//  TLCycleScrollView.h
//  WuXianLunBo
//
//  Created by TongLi on 15/12/11.
//  Copyright © 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLCycleScrollView : UIScrollView<UIScrollViewDelegate>

//本地
- (id)initWithImageArr:(NSMutableArray *)imageArr withY:(CGFloat)Y withAspectRatio:(CGFloat)aspect withImageChangeTimeInterval:(NSTimeInterval )imageChangeTime ;
//网络
- (id)initWithImageURLArr:(NSMutableArray *)imageURLArr withY:(CGFloat)Y withAspectRatio:(CGFloat)aspect withImageChangeTimeInterval:(NSTimeInterval )imageChangeTime ;

- (void)removeTime;
@end
