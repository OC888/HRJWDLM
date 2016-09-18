//
//  JobListViewController.h
//  
//
//  Created by l x on 16/5/18.
//
//

#import <UIKit/UIKit.h>

@interface JobListViewController : UIViewController<UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) NSString *placeholder;

@end
