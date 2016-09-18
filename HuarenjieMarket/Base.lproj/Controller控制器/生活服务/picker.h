//
//  picker.h
//  temp
//
//  Created by l x on 16/5/23.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface picker : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,copy) NSString *pickerString;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,assign) NSInteger component;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,strong) NSArray *arr1;
@property (nonatomic,strong) NSArray *arr2;
@property (nonatomic,strong) NSArray *arr3;

@end
