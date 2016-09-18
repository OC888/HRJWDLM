//
//  AgePicker.m
//  temp
//
//  Created by l x on 16/5/25.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "AgePicker.h"

@implementation AgePicker
{
    NSString *str1;
    NSString *str2;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor lightGrayColor];
        
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH/3, 40)];
        label.text=@"取消";
        label.textColor=BJCOLOR;
        [self addSubview:label];
        
        self.titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/3, 0, WIDTH/3, 40)];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.textColor=[UIColor blackColor];
        [self addSubview:self.titleLabel];
        
        
        UIButton *button =[UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:BJCOLOR forState:UIControlStateNormal];
        button.frame=CGRectMake(WIDTH-10-40, 0, 40, 40);
        [self addSubview:button];
        self.button=button;
        
        _pickerView =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT/2)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = NO;
        _pickerView.backgroundColor=[UIColor whiteColor];
        [self addSubview:_pickerView];
        
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.component;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.row;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component==0) {
        return self.arr1[row];
    }else {
        return self.arr2[row];
    }
}
//设置组件中每行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
//选择器选中方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component==0) {
        str1=self.arr1[row];
    }
    if (component==1) {
        str2=self.arr2[row];
    }
    self.pickerString=[NSString stringWithFormat:@"%@-%@岁",str1,str2];
    
}

@end
