//
//  PhoneViewController.m
//  PhoneCallBack
//
//  Created by Smartios2012 on 15/7/29.
//  Copyright (c) 2015年 com.hjl. All rights reserved.
//

#import "PhoneViewController.h"
#import "UIView+Constraints.h"
#import "UIView+Toast.h"
#import "RequestManager.h"
#import "PhoningViewController.h"
#import "BooksViewController.h"
@interface PhoneViewController () <UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *array;
}

@end

@implementation PhoneViewController
- (IBAction)clears:(id)sender {
    self.phoneLbl.text = @" ";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = BJCOLOR;
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)){
        self.navigationController.navigationBar.translucent = NO;
        
        self.tabBarController.tabBar.translucent = YES;
        
    }
    array = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.phone&&self.phone.length > 0) {
        self.phoneLbl.text = self.phone;
        if (![array containsObject:self.phoneLbl.text]) {
            [array addObject:self.phoneLbl.text];
        }
    }
    [self.recordTableV reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"RecordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.textLabel.text = array[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.phoneLbl.text = array[indexPath.row];
}

- (void)btnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1001: {
            self.keyboardView.heightConstraint.constant = (self.keyboardView.heightConstraint.constant == 44) ? 292 : 44;
        }
            break;
        case 1002: {
            if ([self.phoneLbl.text isEqualToString:@"请输入联系人号码"]) {
                self.phoneLbl.text = @"1";
            } else {
                self.phoneLbl.text = [self.phoneLbl.text stringByAppendingString:@"1"];
            }
            self.name = @"";
        }
            break;
        case 1003: {
            if ([self.phoneLbl.text isEqualToString:@"请输入联系人号码"]) {
                self.phoneLbl.text = @"2";
            } else {
                self.phoneLbl.text = [self.phoneLbl.text stringByAppendingString:@"2"];
            }
            self.name = @"";
        }
            break;
        case 1004: {
            if ([self.phoneLbl.text isEqualToString:@"请输入联系人号码"]) {
                self.phoneLbl.text = @"3";
            } else {
                self.phoneLbl.text = [self.phoneLbl.text stringByAppendingString:@"3"];
            }
            self.name = @"";
        }
            break;
        case 1005: {
            if ([self.phoneLbl.text isEqualToString:@"请输入联系人号码"]) {
                self.phoneLbl.text = @"4";
            } else {
                self.phoneLbl.text = [self.phoneLbl.text stringByAppendingString:@"4"];
            }
            self.name = @"";
        }
            break;
        case 1006: {
            if ([self.phoneLbl.text isEqualToString:@"请输入联系人号码"]) {
            self.phoneLbl.text = @"5";
            } else {
            self.phoneLbl.text = [self.phoneLbl.text stringByAppendingString:@"5"];
            }
            self.name = @"";
         }
            break;
        case 1007: {
            if ([self.phoneLbl.text isEqualToString:@"请输入联系人号码"]) {
            self.phoneLbl.text = @"6";
            
            } else {
                self.phoneLbl.text = [self.phoneLbl.text stringByAppendingString:@"6"];
             }
            self.name = @"";
        }
            break;
        case 1008: {
            if ([self.phoneLbl.text isEqualToString:@"请输入联系人号码"]) {
                self.phoneLbl.text = @"7";
                
            } else {
                self.phoneLbl.text = [self.phoneLbl.text stringByAppendingString:@"7"];
            }
            self.name = @"";
        }
            break;
        case 1009: {
            if ([self.phoneLbl.text isEqualToString:@"请输入联系人号码"]) {
                self.phoneLbl.text = @"8";
            } else {
                self.phoneLbl.text = [self.phoneLbl.text stringByAppendingString:@"8"];
            }
            self.name = @"";
        }
            break;
        case 1010: {
            if ([self.phoneLbl.text isEqualToString:@"请输入联系人号码"]) {
            
    
                self.phoneLbl.text = @"9";
            } else {
                self.phoneLbl.text = [self.phoneLbl.text stringByAppendingString:@"9"];

            }
            self.name = @"";
        }
            break;
        case 1011: {
            BooksViewController *bookV = [self.storyboard instantiateViewControllerWithIdentifier:@"bookS"];
            [self.navigationController pushViewController:bookV animated:YES];
            
        }
            break;
        case 1012: {
            if ([self.phoneLbl.text isEqualToString:@"请输入联系人号码"]) {
            self.phoneLbl.text = @"0";
            
            } else {
            
            self.phoneLbl.text = [self.phoneLbl.text stringByAppendingString:@"0"];
            }
            self.name = @"";
        }
            break;
        case 1013: {
            if (![self.phoneLbl.text isEqualToString:@"请输入联系人号码"]&& self.phoneLbl.text.length > 0) {
            self.phoneLbl.text = [self.phoneLbl.text stringByReplacingCharactersInRange:NSMakeRange(self.phoneLbl.text.length - 1, 1) withString:@""];
            } else {
            self.phoneLbl.text = @"请输入联系人号码";

        }
        }
            break;
        case 1014: {
             NSString *strPhone = nil;
            if ([self.phoneLbl.text hasPrefix:@"+86"]) {
            strPhone  = [self.phoneLbl.text stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@""];
                
            } else {
              
            strPhone = self.phoneLbl.text;

            }
        
            if (strPhone.length == 0 || [strPhone isEqualToString:@"请输入联系人号码"]) {
            [self.view.window makeToast:@"请拨电话号码" duration:2.0 position:@"center"];
                
            return;
            }
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *dict = [userDefaults objectForKey:@"UserInfo"];
            [[RequestManager shareInstance] getUser:@"1" user_id:[dict objectForKey:@"member_id"] completion:^(NSDictionary *jsonData) {
                if (jsonData) {
                
                if ([[jsonData objectForKey:@"type"] isEqualToString:@"success"]) {
                    
                    NSDictionary *dict = [jsonData objectForKey:@"data"];
                    if ([[dict objectForKey:@"max_calltime"] integerValue] == 0) {
                [self.view.window makeToast:@"余额不足" duration:2.0 position:@"center"];
                        } else {
                 [self performSegueWithIdentifier:@"ToDialing" sender:[jsonData objectForKey:@"data"]];
                            
                            if (![array containsObject:self.phoneLbl.text]) {
                                [array addObject:self.phoneLbl.text];
                            }
                        }
                    }
                }
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    PhoningViewController *phoningVC = segue.destinationViewController;
    phoningVC.userInfo = sender;
    NSString *strPhone = nil;
    if ([self.phoneLbl.text hasPrefix:@"+86"]) {
        strPhone  = [self.phoneLbl.text stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@""];
    } else {
        strPhone = self.phoneLbl.text;
    }
    phoningVC.phone = [strPhone stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (self.name && ![self.name isEqualToString:@""]) {
     
       phoningVC.name = self.name;
    }
}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [array removeObject:array[indexPath.row]];
        [_recordTableV reloadData];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除记录";
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(void)viewWillDisappear:(BOOL)animated {
    _phoneLbl.text = @"请输入联系人号码";
}

- (IBAction)deleteAllPlist:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"清空通话记录" message:@"是否清空通话记录？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        清空聊天纪录
        [array removeAllObjects];
        [_recordTableV reloadData];
    }];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
}

@end
