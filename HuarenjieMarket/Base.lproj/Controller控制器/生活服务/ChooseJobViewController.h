//
//  ChooseJobViewController.h
//  temp
//
//  Created by l x on 16/6/12.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseJobViewController : UIViewController
@property (nonatomic,assign) id delegate;
@end
@protocol AllResumeViewViewControllerDelegate <NSObject>

-(void)chooseZhiWeiWithButtonTitle:(NSString *)title;

@end
