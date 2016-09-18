//
//  ChooseShiJianViewController.h
//  temp
//
//  Created by l x on 16/6/3.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoolButton.h"

@interface ChooseShiJianViewController : UIViewController
@property (nonatomic,copy) NSMutableArray *labelArr;
@property (nonatomic,copy) NSMutableArray *buttonArr;
@property (nonatomic,copy) NSMutableArray *selectButtonArr;
@property (nonatomic,copy) NSMutableArray *tagArr;
@property (nonatomic,strong) BoolButton *choosButton;
@property (nonatomic,strong) BoolButton *button;
@property (nonatomic,copy) NSString *key;

-(id)initWithTile:(NSString *)title textArray:(NSArray *)array withKey:(NSString*)key;

@end
