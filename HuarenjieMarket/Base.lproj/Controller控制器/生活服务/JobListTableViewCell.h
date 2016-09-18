//
//  JobListTableViewCell.h
//  
//
//  Created by l x on 16/5/18.
//
//

#import <UIKit/UIKit.h>
#import "BoolButton.h"

@interface JobListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet BoolButton *checkButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UIImageView *hotImageView;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *starImageView;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyLabel;
@end
