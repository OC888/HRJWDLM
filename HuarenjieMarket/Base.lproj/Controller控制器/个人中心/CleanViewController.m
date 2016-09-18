//
//  CleanViewController.m
//  HuarenjieMarket
//
//  Created by l x on 16/8/24.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "CleanViewController.h"

@interface CleanViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIPickerViewDelegate,UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UITableView *TheTableView;
@property (nonatomic,strong)NSMutableArray *datsource1;

@end

@implementation CleanViewController
- (IBAction)backss:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
//头像点击方法
-(void)tapToAction:(UITapGestureRecognizer*)tap {
    [self editPortrait];
    NSLog(@"点击头像了");

}
//背景点击方法
-(void)tapToAction1:(UITapGestureRecognizer*)tap {
    [self editPortrait1];
    NSLog(@"点击背景了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _TheTableView.delegate = self;
    _TheTableView.dataSource = self;
    _datsource1 = [NSMutableArray array];
    
    
    _smallImage.layer.cornerRadius = _smallImage.frame.size.height/2;
    _smallImage.layer.masksToBounds = YES;
    
    [_datsource1 addObjectsFromArray:[NSArray arrayWithObjects:@"用户昵称",@"性别",@"星座",@"出生日期",@"现居住地", nil]];
    
    self.navigationController.navigationBar.barTintColor = BJCOLOR;
    self.navigationController.navigationBar.translucent = YES;
    
    //    头像添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToAction:)];
    [_smallImage addGestureRecognizer:tap];
    
    //    背景添加手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToAction1:)];
    [_bottomImage addGestureRecognizer:tap1];
    
}
#pragma mark 背景的alertSheet
- (void)editPortrait1 {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄背景图片", @"从相册中选取", nil];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"backgroundStatue"];
    
    [choiceSheet showInView:self.view];
}
#pragma mark 拍照的alertSheet
- (void)editPortrait {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄头像", @"从相册中选取", nil];
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"PhotoImageStatue"];
    [choiceSheet showInView:self.view];
}
#pragma mark 拍照的代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 8_3) __TVOS_PROHIBITED {
    //    如果选择拍照
    if(buttonIndex == 0) {
        NSLog(@"选的是拍照");
        
        //创建图片选择器对象
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        // 根据类型返回（照相机、图库、图片列表）
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 选择相机前或后摄像头
        controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        //选择照片之后是否需要编辑
        controller.allowsEditing = YES;
        
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self presentViewController:controller
                           animated:YES
                         completion:^(void){
                             NSLog(@"Picker View Controller is presented");
                         }];
        
    }else if(buttonIndex == 1){  //选择从相册中选取
        NSLog(@"相册选取");
        
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.allowsEditing = YES;
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self presentViewController:controller
                           animated:YES
                         completion:^(void){
                             NSLog(@"Picker View Controller is presented");
                         }];
    }else if(buttonIndex == 2){  //取消
        NSLog(@"取消");
    }
}
#pragma mark照片选择器
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"info = %@", info);
    //    image name
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断获取类型：图片
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
        UIImage *theImage = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
            NSLog(@"获取用户编辑之后的图像");
        } else {
            // 照片的元数据参数
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            NSLog(@"照片的元数据参数");
        }
     NSString *str1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"backgroundStatue"];
      NSString *str2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"PhotoImageStatue"];
//        如果是选择的拍照
        if ([str2 isEqualToString:@"1"]) {
            // 赋值
            _smallImage.image = (UIImage *)theImage;
            // 拍下来的图片保存到相册中
            UIImageWriteToSavedPhotosAlbum(theImage, self,nil, NULL);
            
            // 图片持久化，下次直接读取
            UIImage *ima = (UIImage *)theImage;
            
            NSData *image =UIImagePNGRepresentation(ima);
            
            [[NSUserDefaults standardUserDefaults] setObject:image forKey:@"UP"];
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"PhotoImageStatue"];
            
        }
        else if([str1 isEqualToString:@"1"]) {
            // 赋值
            _bottomImage.image = (UIImage *)theImage;
            // 拍下来的图片保存到相册中
            UIImageWriteToSavedPhotosAlbum(theImage, self,nil, NULL);
            
            // 图片持久化，下次直接读取
            UIImage *ima = (UIImage *)theImage;
            
            NSData *image =UIImagePNGRepresentation(ima);
            
            [[NSUserDefaults standardUserDefaults] setObject:image forKey:@"UP1"];
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"backgroundStatue"];
        }
        
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        //        // 判断获取类型：视频
        //        //获取视频文件的url
        //        NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
        //        //创建ALAssetsLibrary对象并将视频保存到媒体库
        //        // Assets Library 框架包是提供了在应用程序中操作图片和视频的相关功能。相当于一个桥梁，链接了应用程序和多媒体文件。
        //        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        //        // 将视频保存到相册中
        //        [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:mediaURL
        //                                          completionBlock:^(NSURL *assetURL, NSError *error) {
        //                                              if (!error) {
        //                                                  NSLog(@"captured video saved with no error.");
        //                                              }else{
        //                                                  NSLog(@"error occured while saving the video:%@", error);
        //                                              }
        //                                          }];
    }
    
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{[picker dismissModalViewControllerAnimated:YES];}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_TheTableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = _datsource1[indexPath.row];
    if (indexPath.row == 0) {
       NSString *srt = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"];
        cell.detailTextLabel.text = srt;
    }else {
        cell.detailTextLabel.text = @"暂无";
    }
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated {
    dispatch_async(dispatch_get_main_queue(), ^{
        //    查询是否有用户背景图
        NSData *UserPhoto = [[NSUserDefaults standardUserDefaults]objectForKey:@"UP1"];
        
        if (UserPhoto) {
            _bottomImage.image = [UIImage imageWithData:UserPhoto];
            NSLog(@"UserPhotoIsAlready");
        }else {NSLog(@"未发现背景图");}
        
        //    查询是否有用户头像
        NSData *UserPhoto1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"UP"];
        if (UserPhoto1) {
            _smallImage.image = [UIImage imageWithData:UserPhoto1];
            NSLog(@"UserPhotoIsAlready");
        }else {NSLog(@"未发现头像");}

    });
}
@end
