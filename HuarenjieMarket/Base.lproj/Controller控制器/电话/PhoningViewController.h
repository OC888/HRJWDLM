//
//  PhoningViewController.h
//  PhoneCallBack
//
//  Created by Smartios2012 on 15/8/6.
//  Copyright (c) 2015年 com.hjl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoningViewController : UIViewController

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *userInfo;


@property (nonatomic, strong) IBOutlet UILabel *timeLbl;

- (IBAction)btnAction:(UIButton *)sender;

@end
