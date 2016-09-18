//
//  PartListViewController.h
//  temp
//
//  Created by l x on 16/6/3.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartListViewController : UIViewController<UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) NSString *placeholder;


@end
