//
//  ChooseViewController.h
//  temp
//
//  Created by l x on 16/5/18.
//  Copyright (c) 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseViewController : UIViewController
@property (nonatomic,strong) NSMutableArray *labelArr;
@property (nonatomic,strong) NSMutableArray *buttonArr;
@property (nonatomic,strong) UIButton *choosButton;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,copy) NSString *key;

-(id)initWithTile:(NSString *)title textArray:(NSArray *)array withKey:(NSString*)key;


@end
