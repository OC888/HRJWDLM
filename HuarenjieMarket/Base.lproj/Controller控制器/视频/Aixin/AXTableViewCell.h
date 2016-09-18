//
//  AXTableViewCell.h
//  AideoPlayProject
//
//  Created by aaa on 16/6/20.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AixinModel.h"
@interface AXTableViewCell : UITableViewCell
@property (strong, nonatomic)AixinModel *model;
@property (strong, nonatomic)UIImageView *imgView;
@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic)UIButton *playBtn;

@property (strong, nonatomic)UIView *backView;
@end
