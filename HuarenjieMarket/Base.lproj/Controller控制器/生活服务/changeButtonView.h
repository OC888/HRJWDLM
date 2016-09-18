//
//  changeButtonView.h
//  temp
//
//  Created by l x on 16/5/21.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface changeButtonView : UIView
@property (nonatomic,strong) NSMutableArray *buttonArr;
@property (nonatomic,strong) UIView *littleView;

-(void)createWithTitleArr:(NSArray *)titleArr;
@end
