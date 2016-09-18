//
//  ViewController.h
//  PhoneCallBack
//
//  Created by Smartios2012 on 15/7/29.
//  Copyright (c) 2015年 com.hjl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *mobileTxtF;
@property (nonatomic, strong) IBOutlet UITextField *pwdTxtF;

- (IBAction)btnAction:(UIButton *)sender;
 
@end

