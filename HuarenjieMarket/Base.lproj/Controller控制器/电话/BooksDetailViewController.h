//
//  BooksDetailViewController.h
//  PhoneCallBack
//
//  Created by Smartios2012 on 15/8/1.
//  Copyright (c) 2015年 com.hjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactInfoModel.h"

@interface BooksDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITableView *detailTableView;
@property (nonatomic, strong) ContactInfoModel *model;

@end
