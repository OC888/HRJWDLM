//
//  SetOfShopViewController.m
//  HuarenjieMarket
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "SetOfShopViewController.h"

@interface SetOfShopViewController ()<UITextFieldDelegate>
@end

@implementation SetOfShopViewController

-(void)viewDidLayoutSubviews{
    self.backGroundScroll.contentSize = CGSizeMake(320,800);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请开店";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    self.nameOfShop.delegate = self;
    self.nameOfBoss.delegate = self;
    self.numOfIDCard.delegate = self;
    self.numOfMobile.delegate = self;
    self.addressOfShop.delegate = self;
    self.sectionOfShops.delegate = self;
    UITapGestureRecognizer *tapOfImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(preMapAction:)];
    self.loacltionImage.userInteractionEnabled = YES;
    [self.loacltionImage addGestureRecognizer:tapOfImage];
    
    UITapGestureRecognizer *tapOfshop = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shopAction:)];
    self.shopImage.userInteractionEnabled = YES;
    [self.shopImage addGestureRecognizer:tapOfshop];
    
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchAction:)];
    [self.backGroundScroll addGestureRecognizer:tap];
    // Do any additional setup after loading the view from its nib.
}

- (void)preMapAction:(UITapGestureRecognizer *)sender {
//跳转地图定位界面
    PCLog(@"跳转地图定位界面");
    
}

//营业执照上传
- (void)shopAction:(UITapGestureRecognizer *)sender {
    PCLog(@"上传营业执照");
}

- (void)touchAction:(UITapGestureRecognizer *)tap {
    [_numOfMobile resignFirstResponder];
    [_numOfIDCard resignFirstResponder];
    [_nameOfShop resignFirstResponder];
    [_nameOfBoss resignFirstResponder];
    [_addressOfShop resignFirstResponder];
    [_sectionOfShops resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


//协议遵守按钮
- (IBAction)allowButton:(id)sender {
    
}
//立即申请按钮
- (IBAction)applyButton:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
