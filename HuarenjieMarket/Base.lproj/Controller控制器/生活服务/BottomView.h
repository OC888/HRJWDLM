//
//  BottomView.h
//  temp
//
//  Created by l x on 16/5/22.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "JobButton.h"
#import <UIKit/UIKit.h>

@interface BottomView : UIView
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong)  JobButton*resumeButton;
@property (nonatomic,strong) JobButton *phoneButton;
@end
