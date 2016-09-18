//
//  BooksDetailViewController.m
//  PhoneCallBack
//
//  Created by Smartios2012 on 15/8/1.
//  Copyright (c) 2015年 com.hjl. All rights reserved.
//

#import "BooksDetailViewController.h"
#import "PhoneViewController.h"

@interface BooksDetailViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation BooksDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpMenuButton];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)){
        self.navigationController.navigationBar.translucent = NO;
        self.tabBarController.tabBar.translucent = NO;
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.view.frame), 44)];
    UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(self.view.frame) - 30, 44)];
    nameLbl.text = [NSString stringWithFormat:@"%@%@",self.model.lastName?:@"",self.model.firstName?:@""];
    nameLbl.textAlignment = NSTextAlignmentLeft;
    nameLbl.font = [UIFont systemFontOfSize:20];
    [headerView addSubview:nameLbl];
    self.detailTableView.tableHeaderView = headerView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ContactDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.detailTextLabel.text = self.model.phone?:@"";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PhoneViewController *phoneVC = ((UINavigationController *)self.tabBarController.viewControllers[1]).viewControllers[0];
    phoneVC.phone = [self.model.phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneVC.name = [NSString stringWithFormat:@"%@%@",self.model.lastName?:@"",self.model.firstName?:@""];
    self.tabBarController.selectedIndex = 1;
}

- (void)setUpMenuButton {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 40, 32);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_button_normal"] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_button_normal"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftBackAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBar;
}

- (void)leftBackAction:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
