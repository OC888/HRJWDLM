//
//  AgePicker.h
//  temp
//
//  Created by l x on 16/5/25.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgePicker : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,copy) NSString *pickerString;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,assign) NSInteger component;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,copy) NSArray *arr1;
@property (nonatomic,copy) NSArray *arr2;


@end
