//
//  JobDetailViewController.h
//  temp
//
//  Created by l x on 16/5/21.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface JobDetailViewController : UIViewController
@property (nonatomic,strong) FullTimeInfo *fullTimeInfo;
@property (nonatomic,strong) PartTimeInfo *partTimeInfo;

@property (nonatomic,copy) NSString *tableViewtagStr;
@end
