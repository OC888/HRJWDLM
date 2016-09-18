//
//  AllResumeViewViewController.h
//  temp
//
//  Created by l x on 16/5/26.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AllResumeViewViewController : UIViewController
@property (nonatomic,assign) id delegate;
@property (nonatomic,strong) UIButton *sendButton;
@end

@protocol AllResumeViewViewControllerDelegate <NSObject>

-(void)chooseZhiWeiWithButtonTitle:(NSString *)title;

@end
