//
//  ViewController.h
//  temp
//
//  Created by aaa on 16/5/9.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UISearchResultsUpdating,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic,strong) UIScrollView *bjScrollView;
@property (nonatomic,strong) UISearchController *search;
@property (nonatomic,strong) UIScrollView *topScrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UITableView *tableView;

@end

