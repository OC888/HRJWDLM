//
//  PickerView.h
//  temp
//
//  Created by l x on 16/5/18.
//  Copyright (c) 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerView : UIView
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,copy) NSString *dateString;
@property (nonatomic,strong) UILabel *titleLabel;
@end
