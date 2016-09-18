//
//  PickerView.m
//  temp
//
//  Created by l x on 16/5/18.
//  Copyright (c) 2016年 wangli. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "PickerView.h"

@implementation PickerView
{
    NSDate *_date;
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
        
        UIDatePicker *datepicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT/2)];
        datepicker.datePickerMode=UIDatePickerModeDate;
        datepicker.backgroundColor=[UIColor whiteColor];
        self.datePicker=datepicker;
        [self addSubview:datepicker];
        _date=self.datePicker.date;
        NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr =[formatter stringFromDate:_date];
        self.dateString=dateStr;
        [[NSUserDefaults standardUserDefaults]setObject:dateStr  forKey:@"date"];
        [datepicker addTarget:self action:@selector(datePickerClick:) forControlEvents:UIControlEventValueChanged];
        
    }
    return self;
}
-(void)datePickerClick:(UIDatePicker *)picker{
    
    _date =picker.date;
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr =[formatter stringFromDate:_date];
    self.dateString=dateStr;
    [[NSUserDefaults standardUserDefaults]setObject:dateStr  forKey:@"date"];

}

@end
