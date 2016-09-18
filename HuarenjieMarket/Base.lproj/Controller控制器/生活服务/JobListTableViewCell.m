//
//  JobListTableViewCell.m
//  
//
//  Created by l x on 16/5/18.
//
//
#define CELL_WIDTH self.contentView.bounds.size.width
#define CELL_HEIGHT self.contentView.bounds.size.height

#import "JobListTableViewCell.h"

@implementation JobListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
//-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
//
//    if (self) {
//    
//        _checkButton =[[BoolButton alloc]initWithFrame:CGRectMake(0, 30, 40, 40)];
//        [self.contentView addSubview:_checkButton];
//        
//        _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(CELL_HEIGHT, 10, CELL_WIDTH-CELL_HEIGHT/5-40, 20)];
//        _titleLabel.font=[UIFont systemFontOfSize:14.0];
//        _titleLabel.textColor=[UIColor blackColor];
//        [self.contentView addSubview:_titleLabel];
//        
//        _moneyLabel =[[UILabel alloc]initWithFrame:CGRectMake(CELL_HEIGHT, 35, CELL_WIDTH-CELL_HEIGHT/5-60, 20)];
//        _moneyLabel.font=[UIFont systemFontOfSize:14.0];
//        _moneyLabel.textColor=[UIColor orangeColor];
//        [self.contentView addSubview:_moneyLabel];
//        
//        _hotImageView =[[UIImageView alloc]initWithFrame:CGRectMake(CELL_WIDTH-40, 10, 20, 20)];
//        [self.contentView addSubview:_hotImageView];
//        
//        _addressLabel =[[UILabel alloc]initWithFrame:CGRectMake(CELL_WIDTH-60, 35, 60, 20)];
//        _addressLabel.font=[UIFont systemFontOfSize:14.0];
//        _addressLabel.textColor=[UIColor lightGrayColor];
//        _addressLabel.textAlignment=NSTextAlignmentRight;
//        [self.contentView addSubview:_addressLabel];
//        
//        _detailLabel =[[UILabel alloc]initWithFrame:CGRectMake(CELL_HEIGHT, 60, CELL_WIDTH-60, 15)];
//        _detailLabel.font=[UIFont systemFontOfSize:14.0];
//        _detailLabel.textColor=[UIColor lightGrayColor];
//        [self.contentView addSubview:_detailLabel];
//        
//        _timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(CELL_WIDTH-60, 60, 60, 15)];
//        _timeLabel.font=[UIFont systemFontOfSize:14.0];
//        _timeLabel.textColor=[UIColor lightGrayColor];
//        _addressLabel.textAlignment=NSTextAlignmentRight;
//        [self.contentView addSubview:_timeLabel];
//        
//        _companyLabel =[[UILabel alloc]initWithFrame:CGRectMake(CELL_HEIGHT, 80, CELL_WIDTH-60, 15)];
//        _companyLabel.font=[UIFont systemFontOfSize:14.0];
//        _companyLabel.textColor=[UIColor lightGrayColor];
//        [self.contentView addSubview:_companyLabel];
//        
//        _starImageView =[[UIImageView alloc]initWithFrame:CGRectMake(CELL_WIDTH-60, 80, 60, 15)];
//        [self.contentView addSubview:_starImageView];
//
//    }
//    return self;
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
