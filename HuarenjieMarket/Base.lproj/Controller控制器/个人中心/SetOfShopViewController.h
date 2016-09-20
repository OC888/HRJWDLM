//
//  SetOfShopViewController.h
//  HuarenjieMarket
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetOfShopViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameOfShop;//店名
@property (weak, nonatomic) IBOutlet UITextField *nameOfBoss;//店主名
@property (weak, nonatomic) IBOutlet UITextField *numOfIDCard;//身份证号
@property (weak, nonatomic) IBOutlet UITextField *numOfMobile;//电话号码
@property (weak, nonatomic) IBOutlet UIScrollView *backGroundScroll;
@property (weak, nonatomic) IBOutlet UITextField *addressOfShop;
@property (weak, nonatomic) IBOutlet UITextField *sectionOfShops;
@property (weak, nonatomic) IBOutlet UIImageView *loacltionImage;
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;

@property (nonatomic,assign) BOOL isAllowed;

@end
