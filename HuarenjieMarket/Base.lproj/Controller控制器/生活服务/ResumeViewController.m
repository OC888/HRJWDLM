//
//  ResumeViewController.m
//  temp
//
//  Created by l x on 16/5/17.
//  Copyright (c) 2016年 wangli. All rights reserved.
//
#import "ResumeViewController.h"
#import "ResumeTableViewCell.h"
#import "AllResumeViewViewController.h"
#import "ResumeInfo.h"
#import "PickerView.h"
#import "ChooseViewController.h"
#import "ChooseJobViewController.h"

@interface ResumeViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,AllResumeViewViewControllerDelegate,UITextFieldDelegate>
{
    NSArray *_schoolArr;
    NSArray *_workArr;
    NSArray *_workPlaceArr;
    NSArray *_moneyArr;
    NSArray *_jobArr;
    UIView *_view;
    UIImageView *_heaerImageView;
    NSData *_imageData;
    NSMutableArray *_textFieldArr;
    NSMutableArray *_judgeArr;
    NSArray *section0ListArr;
    NSArray *section0PlaceholderArr;
    NSArray *section1ListArr;
    NSArray *section1PlaceholderArr;
    NSArray *section2ListArr;
    NSArray *section2PlaceholderArr;
}
@property (nonatomic,strong) PickerView *pickerView;
@property (nonatomic,strong) UITapGestureRecognizer *tap;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImagePickerController *imagePiker;

@end

@implementation ResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNavigationItem];
    [self creatTableView];
    [self creatDatePicker];
    _textFieldArr=[NSMutableArray array];

}
//创建导航栏按钮
-(void)creatNavigationItem{
    self.title=@"填写信息";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithTitle:@"确认发布" style:UIBarButtonItemStylePlain target:self action:@selector(resumeButtonClick)];
    [rightItem setTintColor:[UIColor whiteColor]];

    self.navigationItem.rightBarButtonItem=rightItem;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
//返回按钮绑定方法
-(void)doBack:(id)sender{
    __block typeof(self) otherSelf=self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲，是否要离开？" message:@"内容还没提交" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [otherSelf.navigationController popViewControllerAnimated:YES];
        NSString*appDomain = [[NSBundle mainBundle]bundleIdentifier];
        [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
        [[NSFileManager defaultManager]removeItemAtPath:[self getPath] error:nil];

    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
//导航右栏按钮绑定方法
-(void)notice{
    
}
//创建表
-(void)creatTableView{
    section0ListArr=@[@"姓      名",@"性      别",@"出生年份",@"最高学历",@"工作年限"];
    section0PlaceholderArr=@[@"2-4字，只能填写汉字或者字母",@"",@"请选择您的出生年月",@"请选择",@"请选择"];
    section1ListArr=@[@"手机号码",@"邮箱地址（选填）"];
    section1PlaceholderArr=@[@"只能填写手机号",@"请填写邮箱"];
    section2ListArr=@[@"期望工作区域",@"期望薪资",@"期望职位",@"求职宣言（选填）"];
    section2PlaceholderArr=@[@"请选择",@"请选择",@"请选择",@"添加教育经历，工作经历，自我评价"];
    
    UITableView *tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-50) style:UITableViewStyleGrouped];
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.tableHeaderView=[self creatTableHeaderView];
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-30, WIDTH, 30)];
    tableView.tableFooterView=view;
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:tableView];
    _tableView=tableView;
}
//创建底部确认按钮
//-(void)creatBottomButton{
//    
//    _view =[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-50, WIDTH, 50)];
//    _view.layer.borderWidth=0.5;
//    _view.layer.borderColor=[UIColor blackColor].CGColor;
//    _view.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:_view];
//    UIButton *chooseButton =[[UIButton alloc]initWithFrame:CGRectMake(WIDTH/4, 10, WIDTH/2, 30)];
//    [chooseButton setBackgroundColor:BJCOLOR];
//    chooseButton.layer.cornerRadius=5;
//    chooseButton.layer.masksToBounds=YES;
//    [chooseButton setTitle:@"确认发布" forState:UIControlStateNormal];
//    [chooseButton addTarget:self action:@selector(sendResumeClick) forControlEvents:UIControlEventTouchUpInside];
//    [_view addSubview:chooseButton];
//
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 5;
    }else if (section==1) {
        return 2;
    }else  {
        return 4;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==1) {
        if (indexPath.row==1) {
            return 60;
        }else{
            return 40;
        }
    }else if (indexPath.section==2){
        if (indexPath.row==3) {
            return 60;
        }else{
            return 40;
        }
    }else{
        
        return 40;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cell";
    
    ResumeTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[ResumeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.nameLabel.numberOfLines=0;
    cell.detailTextField.delegate=self;
    [cell.detailTextField addTarget:self action:@selector(textFieldDidChang:) forControlEvents:UIControlEventEditingChanged];
    [_textFieldArr addObject:cell.detailTextField];
    if (indexPath.section==0) {
        cell.nameLabel.text=section0ListArr[indexPath.row];
        cell.detailTextField.placeholder=section0PlaceholderArr[indexPath.row];
        if (indexPath.row==0) {
            cell.detailTextField.text=[self writeWithKey:@"name"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveNmae:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=1;

        }else if (indexPath.row==1) {
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=@"123";
            cell.detailTextField.textColor=[UIColor clearColor];
            UISegmentedControl *seg =[[UISegmentedControl alloc]initWithItems:@[@"男",@"女"]];
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sex"] isEqualToString:@"女"]) {
                seg.selectedSegmentIndex=1;
            }else{
                seg.selectedSegmentIndex=0;
            }
            seg.frame=CGRectMake(WIDTH/3-10, 10, WIDTH/3*2-10, 20);
            [seg addTarget:self action:@selector(changeSax:) forControlEvents:UIControlEventValueChanged];
            seg.tintColor=BJCOLOR;
            [cell addSubview:seg];
            
        }else if (indexPath.row==2){
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"date"];
        }else if (indexPath.row==3){
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"school"];
        }else {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"time"];
        }
    }else if (indexPath.section==1) {
        cell.nameLabel.text=section1ListArr[indexPath.row];
        cell.detailTextField.placeholder=section1PlaceholderArr[indexPath.row];
        if (indexPath.row==0) {
            cell.detailTextField.keyboardType=UIKeyboardTypeNumberPad;
            cell.detailTextField.text=[self writeWithKey:@"phoneNumber"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePhoneNumber:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=2;

        }else {
            CGSize rect =[cell.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
            cell.nameLabel.frame=CGRectMake(cell.nameLabel.frame.origin.x, cell.nameLabel.frame.origin.y, cell.nameLabel.frame.size.width, rect.height+20);
            cell.nameLabel.numberOfLines=0;
            cell.nameLabel.lineBreakMode=NSLineBreakByWordWrapping;
            cell.detailTextField.text=[self writeWithKey:@"email"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveEmail:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=3;
        }
    }else{
        cell.nameLabel.text=section2ListArr[indexPath.row];
        cell.detailTextField.placeholder=section2PlaceholderArr[indexPath.row];
        if (indexPath.row==0) {
            cell.nameLabel.font =[UIFont systemFontOfSize:11.0];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"address"];
        }else if (indexPath.row==1){
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"money"];
        }else if (indexPath.row==2){
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"job"];
        }else{
            CGSize rect =[cell.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
            cell.nameLabel.frame=CGRectMake(cell.nameLabel.frame.origin.x, cell.nameLabel.frame.origin.y, cell.nameLabel.frame.size.width, rect.height+20);
            cell.nameLabel.numberOfLines=0;
            cell.nameLabel.lineBreakMode=NSLineBreakByWordWrapping;
            
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveText:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.text=[self writeWithKey:@"text"];
            cell.detailTextField.tag=4;
        }
    }
    return cell;
}

//textField结束编辑
-(void)saveNmae:(NSNotification *)not{
    [self save:@"name" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)changeSax:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"男" forKey:@"sex"];
        }
            break;
        case 1:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"女" forKey:@"sex"];
        }
            break;
        default:
            break;
    }
}
-(void)saveDate:(NSNotification *)not{
    [self save:@"date" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:2 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveSchool:(NSNotification *)not{
    [self save:@"school" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveTime:(NSNotification *)not{
    [self save:@"time" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:4
         inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)savePhoneNumber:(NSNotification *)not{
    [self save:@"phoneNumber" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveEmail:(NSNotification *)not{
    [self save:@"email" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveText:(NSNotification *)not{
    [self save:@"text" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:3 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)save:(NSString *)str withNot:(NSNotification*)not{
    UITextField *textField =(UITextField*)[not object];
    [[NSUserDefaults standardUserDefaults]setObject:textField.text  forKey:str];
}
-(NSString *)writeWithKey:(NSString *)str{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:str]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:str];
    }else{
    return @"";
    }
}
//创建表头
-(UIView *)creatTableHeaderView{
    UIView *headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 110)];
    _heaerImageView =[[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-80)/2, 5, 80, 80)];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getPath]]) {
        _heaerImageView.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:[self getPath]]];
    }else{
    _heaerImageView.image=[UIImage imageNamed:@"bendi-01"];
    }
    _heaerImageView.layer.masksToBounds=YES;
    _heaerImageView.layer.cornerRadius=40;
    
    [headerView addSubview:_heaerImageView];
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake((WIDTH-80)/2, 90, 80,20);
    [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button setBackgroundColor:BJCOLOR];
    [button addTarget:self action:@selector(headerImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"上传头像" forState:UIControlStateNormal];
    _heaerImageView.layer.masksToBounds=YES;
    _heaerImageView.layer.cornerRadius=5;

    [headerView addSubview:button];

    return headerView;
}
//头像
-(void)headerImageButtonClick:(UIButton *)button{
    _imagePiker=[[UIImagePickerController alloc]init];
    _imagePiker.delegate=self;
    _imagePiker.allowsEditing=YES;
    __weak __typeof(&*self)otherSelf =self;
    //__block typeof(self) otherSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"拍  照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            _imagePiker.sourceType=UIImagePickerControllerSourceTypeCamera;
            [otherSelf presentViewController:_imagePiker animated:YES completion:^{
                
            }];
        }else{
            NSLog(@"模拟器中无法打开相机");
        }
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"用户相册 " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePiker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [otherSelf presentViewController:_imagePiker animated:YES completion:^{
            
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:action];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [otherSelf presentViewController:alertController animated:YES completion:^{
        
    }];
}
//获取头像
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image =[info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^(void){}];
    picker.delegate=nil;
    _heaerImageView.image=image;
    _imageData = UIImageJPEGRepresentation(image, 0.1);

    [_imageData writeToFile:[self getPath] atomically:YES];
    
}
//取消图片选择
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^(void){}];
    picker.delegate=nil;
}
-(NSString *)getPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/headerImage.plist"];
}
//点击cell触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==2) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            _pickerView.frame=CGRectMake(0, HEIGHT/5*3, WIDTH, HEIGHT/5*2);
            [UIView commitAnimations];
            [_pickerView.button addTarget:self action:@selector(chooseDate) forControlEvents:UIControlEventTouchUpInside];
            _tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(datePickerDown)];
            [self.view addGestureRecognizer:_tap];
            _view.hidden=YES;

        }else if (indexPath.row==3) {
            _schoolArr=@[@"初中及以下",@"高中",@"中专/技校",@"大专",@"本科",@"硕士及以上",@"<##>"];
            ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择最高学历" textArray:_schoolArr withKey:@"job"];
            [vc.choosButton addTarget:self action:@selector(chooseSchoolClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];

        }else if(indexPath.row==4) {
            _workArr=@[@"无经验",@"在读学生",@"应届毕业生",@"1年以内",@"1~2年",@"2~3年",@"3~5年",@"5~8年",@"8~10年",@"10年以上"];
            ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择工作年限" textArray:_workArr withKey:@"time"];
            [vc.choosButton addTarget:self action:@selector(chooseWorkClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];

        }else{
            
        }
    }
    if (indexPath.section==1){
        if (indexPath.row==0) {
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
            ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextField.keyboardType=UIKeyboardTypeNumberPad;
        }
    }
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            _workPlaceArr=@[@"二七区",@"中原区",@"回族管城区",@"惠济区",@"金水区",@"上街区",@"巩义市",@"新密市",@"新郑市",@"登封市",@"荥阳市",@"中牟县",@"经济技术开发区",@"高新技术开发区"];
            ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择工作区域" textArray:_workPlaceArr withKey:@"job"];
            [vc.choosButton addTarget:self action:@selector(chooseWorkPlaceClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1) {
            _moneyArr=@[@"面议",@"1000元以下",@"1000-2000元",@"2000-3000元",@"3000-5000元",@"5000-8000元",@"8000-12000元",@"12000-20000元",@"20000元以上"];
            ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"期望薪资" textArray:_moneyArr withKey:@"job"];
            [vc.choosButton addTarget:self action:@selector(chooseMoneyClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==2) {
            ChooseJobViewController *vc =[[ChooseJobViewController alloc]init];
            vc.delegate=self;
            [self.navigationController pushViewController:vc animated:YES];

        }else{
            
        }
    }
}
//选择职位
-(void)chooseZhiWeiWithButtonTitle:(NSString *)title{
    NSString *text=title;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:2];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"job"];
    
    [self.navigationController popViewControllerAnimated:YES];
}
//选择学历
-(void)chooseSchoolClick:(UIButton *)button{
    NSString *text=_schoolArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"school"];

    [self.navigationController popViewControllerAnimated:YES];
    
}
//选择工作年限
-(void)chooseWorkClick:(UIButton *)button{
    NSString *text=_workArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:4 inSection:0];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"time"];
    [self.navigationController popViewControllerAnimated:YES];
}
//选择工作区域
-(void)chooseWorkPlaceClick:(UIButton *)button{
    NSString *text=_workPlaceArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"address"];
    [self.navigationController popViewControllerAnimated:YES];
}
//选择薪资
-(void)chooseMoneyClick:(UIButton *)button{
    NSString *text=_moneyArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:2];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"money"];
    [self.navigationController popViewControllerAnimated:YES];
}
//选择职位
-(void)chooseJobClick:(UIButton *)button{
    NSString *text=_jobArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:2];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"job"];
    [self.navigationController popViewControllerAnimated:YES];
}
//创建时间选择器
-(void)creatDatePicker{
    _pickerView =[[PickerView alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, WIDTH/2)];
    [_pickerView.button addTarget:self action:@selector(chooseDate) forControlEvents:UIControlEventTouchUpInside];
    _pickerView.titleLabel.text=@"出生日期";
    [self.view addSubview:_pickerView];
}
//选择时间
-(void)chooseDate{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=_pickerView.dateString;
    [[NSUserDefaults standardUserDefaults]setObject:_pickerView.dateString  forKey:@"date"];
    [self datePickerDown];
}
//时间选择器下降
-(void)datePickerDown{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _pickerView.frame=CGRectMake(0, HEIGHT, WIDTH, HEIGHT/3);
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
    _view.hidden=NO;
}

//解除手势
-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    
    [self.view removeGestureRecognizer:_tap];
}
//发布按钮
-(void)resumeButtonClick{
    NSDate *currentDate =[NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSUserDefaults *UDF =[NSUserDefaults standardUserDefaults];
    NSString *biaozhi=@"全职";
    NSString *fabutime=[formatter stringFromDate:currentDate];
    NSString *birthday;
    NSString *gongzuonianxian;
    NSString *gongzuoquyu;
    NSString *name;
    NSString *phone;
    NSString *qiuzhixuanyan;
    NSString *salary;
    NSString *sex;
    NSString *xueli;
    NSString *zhiwei;
    NSString *email;
    NSData *imagedata;
    
    if ([UDF objectForKey:@"name"]) {
        name=[UDF objectForKey:@"name"];
    }else{
        name=@"";
    }
    if ([UDF objectForKey:@"sex"]) {
        sex=[UDF objectForKey:@"sex"];
    }else{
        sex=@"";
    }
    if ([UDF objectForKey:@"date"]) {
        birthday=[UDF objectForKey:@"date"];
    }else{
        birthday=@"0000-00-00";
    }
    if ([UDF objectForKey:@"school"]) {
        xueli=[UDF objectForKey:@"school"];
    }else{
        xueli=@"";
    }
    if ([UDF objectForKey:@"time"]) {
        gongzuonianxian=[UDF objectForKey:@"time"];
    }else{
        gongzuonianxian=@"";
    }
    if ([UDF objectForKey:@"phoneNumber"]) {
        phone=[UDF objectForKey:@"phoneNumber"];
    }else{
        phone=@"";
    }
    if ([UDF objectForKey:@"email"]) {
        email=[UDF objectForKey:@"email"];
    }else{
        email=@"";
    }
    if ([UDF objectForKey:@"address"]) {
        gongzuoquyu=[UDF objectForKey:@"address"];
    }else{
        gongzuoquyu=@"";
    }
    if ([UDF objectForKey:@"money"]) {
        salary=[UDF objectForKey:@"money"];
    }else{
        salary=@"";
    }
    if ([UDF objectForKey:@"job"]) {
        zhiwei=[UDF objectForKey:@"job"];
    }else{
        zhiwei=@"";
    }
    if ([UDF objectForKey:@"text"]) {
        qiuzhixuanyan=[UDF objectForKey:@"text"];
    }else{
        qiuzhixuanyan=@"";
    }

    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getPath]]) {
        imagedata =[NSData dataWithContentsOfFile:[self getPath]];
    }else{
        UIImage *image =[UIImage imageNamed:@"1.jpg"];
        NSData *imageData =UIImageJPEGRepresentation(image, 0.1);
        imagedata=imageData;
    }
    
    _judgeArr=[NSMutableArray array];
    for (UITextField *field in _textFieldArr) {
        if (field.text.length<=0) {
            [_judgeArr addObject:field];
        }
    }
    if (_judgeArr.count==0) {
        if ([CheckText nameWithObject:name]==YES&&[CheckText phoneWithObject:phone]==YES) {
            [AFHttpManager sendResumeWithBiaoZhi:biaozhi withBirthday:birthday withEmail:email withFabutime:fabutime withgongzuonianxian:gongzuonianxian withgongzuoquyu:gongzuoquyu withgongzuoshijian:@"" withjiaxiang:@"" withname:name withphone:phone withqiuzhixuanyan:qiuzhixuanyan withqiwangrixin:@"" withsalary:salary withsex:sex withtouxiang:imagedata withxueli:xueli withzhiwei:zhiwei withType:^(NSString *string) {
                if ([string isEqualToString:@"success"]) {
                    SHOW_NOALERT(@"发布成功");
                }else{
                    SHOW_ALERT(@"发布失败");
                }
            }];
        }else{
            SHOW_ALERT(@"亲，信息格式填写错误");
        }
    }else{
        SHOW_ALERT(@"亲，信息填写不完整");
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==1) {
        if (textField.text.length>0) {
            if ([CheckText nameWithObject:textField.text]==YES) {
            }else{
                SHOW_MESSAGE(@"亲，输入姓名格式不正确");
            }
        }
    }
    else if (textField.tag==2) {
        if (textField.text.length>0) {
            if ([CheckText phoneWithObject:textField.text]==YES) {
            }else{
                SHOW_MESSAGE(@"亲，输入电话格式不正确");
            }
        }
    }else if (textField.tag==3) {
        if (textField.text.length>0) {
            if ([CheckText emailWithObject:textField.text]==YES) {
            }else{
                SHOW_MESSAGE(@"亲，输入邮箱格式不正确");
            }
        }
    }else{
        
    }
}
-(void)textFieldDidChang:(UITextField *)textField{
    if (textField.tag==4) {
        if (textField.text.length > 800) {
            textField.text = [textField.text substringToIndex:800];
            SHOW_MESSAGE(@"亲，输入超出长度范围");
        }
    }else{
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag==2) {
        
        NSCharacterSet*cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest) {
            SHOW_MESSAGE(@"亲，您输入的格式不正确");
            return NO;
        }
        return YES;
    }else{
        return YES;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
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
