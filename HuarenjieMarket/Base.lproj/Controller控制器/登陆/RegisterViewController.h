//
//  RegisterViewController.h
//  PhoneCallBack
//
//  Created by exlm-apple on 15/8/4.
//  Copyright (c) 2015年 com.hjl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *mobileTxtF;
@property (nonatomic, strong) IBOutlet UITextField *pwdTxtF;
@property (nonatomic, strong) IBOutlet UITextField *pwd2TxtF;

- (IBAction)btnAction:(UIButton *)sender;

@end
