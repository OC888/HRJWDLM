//
//  JianjieCell.h
//  PhoneCallBack
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 com.hjl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JianjieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *text1;
@property (weak, nonatomic) IBOutlet UILabel *text2;
@property (weak, nonatomic) IBOutlet UILabel *text3;
@property (weak, nonatomic) IBOutlet UILabel *text4;
@property (weak, nonatomic) IBOutlet UILabel *text5;

-(void)setCell;
@end
