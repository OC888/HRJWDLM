//
//  ZhuboCollectionViewCell.h
//  AideoPlayProject
//
//  Created by aaa on 16/5/3.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhuboCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@end
