//
//  MainTableViewControllerNew.h
//  PhoneCallBack
//
//  Created by 赵一 on 16/4/23.
//  Copyright © 2016年 com.hjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface MainTableViewControllerNew : UITableViewController<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *LocationItem;
-(void)startLocation;
@end
