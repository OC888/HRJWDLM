//
//  PhoneViewController.h
//  PhoneCallBack
//
//  Created by Smartios2012 on 15/7/29.
//  Copyright (c) 2015年 com.hjl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIView *keyboardView;
@property (nonatomic, strong) IBOutlet UITableView *recordTableV;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) IBOutlet UILabel *phoneLbl;

- (IBAction)btnAction:(UIButton *)sender;

@end


