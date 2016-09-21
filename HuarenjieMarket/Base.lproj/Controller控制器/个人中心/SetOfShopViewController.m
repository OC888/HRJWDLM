//
//  SetOfShopViewController.m
//  HuarenjieMarket
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "SetOfShopViewController.h"

@interface SetOfShopViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *sectionTable;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL isSectionList;
@property (nonatomic, strong) NSData *imageDataOfShop;
@end
static NSString *sectionCell = @"sectionIdentifier";
@implementation SetOfShopViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataSource;
}

-(void)viewDidLayoutSubviews{
    self.backGroundScroll.contentSize = CGSizeMake(320,1100);
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
    
//    UITapGestureRecognizer *tapOfIDCard = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(IDcardAction:)];
//    self.IDImage.userInteractionEnabled = YES;
//    [self.IDImage addGestureRecognizer:tapOfIDCard];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchAction:)];
    [self.backGroundScroll addGestureRecognizer:tap];
    
    self.sectionTable = [[UITableView alloc]init];
    self.sectionTable.delegate = self;
    self.sectionTable.dataSource = self;
    [self.sectionTable registerClass:[UITableViewCell class] forCellReuseIdentifier:sectionCell];
    [self.view addSubview:_sectionTable];
    [_sectionTable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sectionOfShops.bottom);
        make.left.equalTo(_sectionOfShops);
        make.width.equalTo(_sectionOfShops.width);
        make.height.equalTo(150);
    }];
    self.sectionTable.hidden = YES;
    self.isSectionList = NO;
//    self.sectionOfShops.inputView = self.sectionTable;
    // Do any additional setup after loading the view from its nib.
}


- (void)preMapAction:(UITapGestureRecognizer *)sender {
//跳转地图定位界面
    PCLog(@"跳转地图定位界面");
    
}

////上传身份证号
//- (void)IDcardAction:(UITapGestureRecognizer *)sender {
//    PCLog(@"上传身份证件照");
//}

//营业执照上传
- (void)shopAction:(UITapGestureRecognizer *)sender {
    PCLog(@"上传营业执照");
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择图片来源" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imageVC = [[UIImagePickerController alloc]init];
            imageVC.delegate = self;
            imageVC.allowsEditing = YES;
            imageVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imageVC animated:YES completion:nil];
        }
        
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    [alertVC addAction:action];
    [alertVC addAction:action1];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerController - 
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    picker.delegate = nil;
    _shopImage.image = image;
    self.imageDataOfShop = UIImageJPEGRepresentation(image, 0.1);
    [_imageDataOfShop writeToFile:[self getPath] atomically:YES];
    
}

//取消图片选择
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^(void){}];
    picker.delegate=nil;
}

-(NSString *)getPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/shopsImage.plist"];
}

- (void)touchAction:(UITapGestureRecognizer *)tap {
    [_numOfMobile resignFirstResponder];
    [_numOfIDCard resignFirstResponder];
    [_nameOfShop resignFirstResponder];
    [_nameOfBoss resignFirstResponder];
    [_addressOfShop resignFirstResponder];
    [_sectionOfShops resignFirstResponder];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionCell forIndexPath:indexPath];
    cell.textLabel.text = @"开店分类";
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    return cell;
}

#pragma mark - UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.sectionOfShops.text = cell.textLabel.text;
    self.sectionTable.hidden = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}


#pragma mark - UITextFieldDelegate -
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.sectionOfShops]) {
        self.sectionTable.hidden = NO;
//  不让弹出键盘
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.sectionOfShops]) {
        self.sectionTable.hidden = NO;
    }
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
