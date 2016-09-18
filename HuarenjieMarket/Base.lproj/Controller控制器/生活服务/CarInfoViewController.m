//
//  CarInfoViewController.m
//  temp
//
//  Created by l x on 16/5/19.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "CarInfoViewController.h"
#import "ResumeTableViewCell.h"
#import "ChooseViewController.h"

@interface CarInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    NSArray *_brandArr;
    NSMutableArray *_imageButtonArr;
    NSArray *_colorArr;
    NSArray *_carPlaceArr;
    UIView *_view;
    NSMutableArray *_textFieldArr;
    BOOL isHaveDian;
    NSMutableArray *_judgeArr;

}
@property (nonatomic,strong) UITapGestureRecognizer *tap;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) PickerView *pickerView;
@property (nonatomic,strong) UIImagePickerController *imagePiker;

@end

@implementation CarInfoViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatNavigationItem];
    [self creatTableView];
    [self creatDatePicker];
    
    _imageArr=[NSMutableArray arrayWithCapacity:0];
    _textFieldArr=[NSMutableArray array];
}
//创建导航栏按钮
-(void)creatNavigationItem{
    self.title=@"填写信息";
    
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithTitle:@"确认发布" style:UIBarButtonItemStylePlain target:self action:@selector(sendResumeClick)];
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
        [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/carImage.plist"] error:nil];
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
    
    UITableView *tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-50) style:UITableViewStyleGrouped];
    tableView.dataSource=self;
    tableView.delegate=self;
    self.tableView.tableFooterView=[[UIView alloc]init];
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-30, WIDTH, 30)];
    tableView.tableFooterView=view;
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
-(void)sendResumeClick{
    NSUserDefaults *UDF =[NSUserDefaults standardUserDefaults];
    NSString *biaoti;
    NSString *brand;
    NSString *color;
    NSString *lianxiren;
    NSString *miaoshu;
    NSString *phone;
    NSString *place;
    NSString *price;
    NSString *shangpaidate;
    NSString *xingshilicheng;

    if ([UDF objectForKey:@"title"]) {
        biaoti=[UDF objectForKey:@"title"];
    }else{
        biaoti=@"";
    }
    if ([UDF objectForKey:@"brand"]) {
        brand=[UDF objectForKey:@"brand"];
    }else{
        brand=@"";
    }
    if ([UDF objectForKey:@"color"]) {
        color=[UDF objectForKey:@"color"];
    }else{
        color=@"";
    }
    if ([UDF objectForKey:@"carTime"]) {
        shangpaidate=[UDF objectForKey:@"carTime"];
    }else{
        shangpaidate=@"";
    }
    if ([UDF objectForKey:@"driveNumber"]) {
        xingshilicheng=[UDF objectForKey:@"driveNumber"];
    }else{
        xingshilicheng=@"";
    }
    if ([UDF objectForKey:@"carPrice"]) {
        price=[UDF objectForKey:@"carPrice"];
    }else{
        price=@"";
    }
    if ([UDF objectForKey:@"person"]) {
        lianxiren=[UDF objectForKey:@"person"];
    }else{
        lianxiren=@"";
    }
    if ([UDF objectForKey:@"phone"]) {
        phone=[UDF objectForKey:@"phone"];
    }else{
        phone=@"";
    }
    if ([UDF objectForKey:@"carAddress"]) {
        place=[UDF objectForKey:@"carAddress"];
    }else{
        place=@"";
    }
    if ([UDF objectForKey:@"describe"]) {
        miaoshu=[UDF objectForKey:@"describe"];
    }else{
        miaoshu=@"";
    }

    NSArray *imageArr;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/carImage.plist"]]) {
        imageArr=[NSArray arrayWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/carImage.plist"]];
    }
    NSData *data1;
    NSData *data2;
    NSData *data3;
    NSData *data4;
    NSData *data5;
    NSData *data6;
    NSData *data7;
    UIImage *image =[UIImage imageNamed:@"datu.png"];
    NSData *imagedata =UIImageJPEGRepresentation(image, 0.1);
    if (imageArr.count<=0) {
        data1=imagedata;
        data2=imagedata;
        data3=imagedata;
        data4=imagedata;
        data5=imagedata;
        data6=imagedata;
        data7=imagedata;
    }else if (0<imageArr.count&&imageArr.count<=1) {
        data1=imageArr[0];
        data2=imagedata;
        data3=imagedata;
        data4=imagedata;
        data5=imagedata;
        data6=imagedata;
        data7=imagedata;
    }else if (1<imageArr.count&&imageArr.count<=2) {
        data1=imageArr[0];
        data2=imageArr[1];
        data3=imagedata;
        data4=imagedata;
        data5=imagedata;
        data6=imagedata;
        data7=imagedata;
    }else if (2<imageArr.count&&imageArr.count<=3) {
        data1=imageArr[0];
        data2=imageArr[1];
        data3=imageArr[2];
        data4=imagedata;
        data5=imagedata;
        data6=imagedata;
        data7=imagedata;
    }else if (3<imageArr.count&&imageArr.count<=4) {
        data1=imageArr[0];
        data2=imageArr[1];
        data3=imageArr[2];
        data4=imageArr[3];
        data5=imagedata;
        data6=imagedata;
        data7=imagedata;
    }else if (4<imageArr.count&&imageArr.count<=5) {
        data1=imageArr[0];
        data2=imageArr[1];
        data3=imageArr[2];
        data4=imageArr[3];
        data5=imageArr[4];
        data6=imagedata;
        data7=imagedata;
    }else if (5<imageArr.count&&imageArr.count<=6) {
        data1=imageArr[0];
        data2=imageArr[1];
        data3=imageArr[2];
        data4=imageArr[3];
        data5=imageArr[4];
        data6=imageArr[5];
        data7=imagedata;
    }else {
        data1=imageArr[0];
        data2=imageArr[1];
        data3=imageArr[2];
        data4=imageArr[3];
        data5=imageArr[4];
        data6=imageArr[5];
        data7=imageArr[6];
    }
    
    _judgeArr=[NSMutableArray array];
    for (UITextField *field in _textFieldArr) {
        NSLog(@"%@",_textFieldArr);
        if (field.text.length<=0) {
            [_judgeArr addObject:field];
        }
    }
    if (_judgeArr.count==0) {
        if ([CheckText nameWithObject:lianxiren]==YES&&[CheckText phoneWithObject:phone]==YES) {
            [AFHttpManager sendCarResumeWithbiaoti:biaoti withbrand:brand withcolor:color withimage1:data1 withimage2:data2 withimage3:data3 withimage4:data4 withimage5:data5 withimage6:data6 withimage7:data7 withlianxiren:lianxiren withmiaoshu:miaoshu withphone:phone withplace:place withprice:price withshangpaidate:shangpaidate withxingshilicheng:xingshilicheng withType:^(NSString *string) {
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
    }else{
        
    }
}
-(void)textFieldDidChang:(UITextField *)textField{
    if (textField.tag==5) {
        if (textField.text.length > 30) {
            textField.text = [textField.text substringToIndex:30];
            SHOW_MESSAGE(@"亲，输入超出长度范围");
        }
    }else if (textField.tag==4) {
        if (textField.text.length > 800) {
            textField.text = [textField.text substringToIndex:800];
            SHOW_MESSAGE(@"亲，输入超出长度范围");
        }
    }else{
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag==6||textField.tag==7||textField.tag==2) {
        
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            
            unichar single = [string characterAtIndex:0];//当前输入的字符
            if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
                
                //首字母不能为0和小数点
                if([textField.text length] == 0){
                    if(single == '.') {
                        SHOW_MESSAGE(@"亲，第一个数字不能为小数点");
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                    if (single == '0') {
                        SHOW_MESSAGE(@"亲，第一个数字不能为0");
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                
                //输入的字符是否是小数点
                if (single == '.') {
                    if(!isHaveDian)//text中还没有小数点
                    {
                        isHaveDian = YES;
                        return YES;
                        
                    }else{
                        SHOW_MESSAGE(@"亲，您已经输入过小数点了");
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    if (isHaveDian) {//存在小数点
                        
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 1) {
                            return YES;
                        }else{
                            SHOW_MESSAGE(@"亲，您最多输入一位小数");
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{//输入的数据格式不正确
                SHOW_MESSAGE(@"亲，您输入的格式不正确");
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
    }else{
        return YES;
    }
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if (textField.tag==1) {
//        int  remainTextNum=4;
//        if(range.location>=4)
//        {
//            remainTextNum=0;
//            return NO;
//        }
//        else{
//            int existTextNum=(int)textField.text.length;
//            remainTextNum=4-existTextNum;
//            return YES;
//        }
//    }else if (textField.tag==2) {
//        int  remainTextNum=11;
//        if(textField.text.length-range.length+string.length>=11)
//        {
//            remainTextNum=0;
//            return NO;
//        }
//        else{
//            int existTextNum=(int)textField.text.length;
//            remainTextNum=11-existTextNum;
//            return YES;
//        }
//    }else if (textField.tag==3) {
//        return YES;
//    }else{
//        int  remainTextNum=1000;
//        if(range.location>=1000)
//        {
//            remainTextNum=0;
//            return NO;
//        }
//        else{
//            int existTextNum=(int)textField.text.length;
//            remainTextNum=1000-existTextNum;
//            return YES;
//        }
//    }
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1||section==4) {
        return 2;
    }else if(section==0){
        return 1;
    }else{
        return 3;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return (WIDTH-50)/4+20;
    }
    else if (indexPath.section==4&&indexPath.row==1) {
        return 60;
    }else{
        return 40;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *section1ListArr=@[@"品牌系列",@"车辆颜色"];
    NSArray *section1PlaceholderArr=@[@"请选择",@"请选择"];
    NSArray *section2ListArr=@[@"首次上牌时间",@"行驶里程",@"价       格"];
    NSArray *section2PlaceholderArr=@[@"请选择",@"最多一位小数",@"数字填写，不能是0"];
    NSArray *section3ListArr=@[@"联  系  人",@"联系电话",@"看车地点"];
    NSArray *section3PlaceholderArr=@[@"2-4字，只能填写汉字或字母",@"",@"请选择"];
    NSArray *section4ListArr=@[@"标       题",@"描       述（选填）"];
    NSArray *section4PlaceholderArr=@[@"6-30字，不能填写电话",@"不能填写电话"];
    static NSString *cellID=@"cell";
    
    ResumeTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[ResumeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.detailTextField.delegate=self;
    [cell.detailTextField addTarget:self action:@selector(textFieldDidChang:) forControlEvents:UIControlEventEditingChanged];
    [_textFieldArr addObject:cell.detailTextField];
    cell.nameLabel.numberOfLines=0;
    if (indexPath.section==0) {
        cell.backgroundColor=LINECOLOR;
        _imageButtonArr =[NSMutableArray arrayWithCapacity:0];
        UIScrollView *view =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, (WIDTH-50)/4+20)];
        view.contentSize=CGSizeMake(WIDTH*2, (WIDTH-50)/4+20);
        [cell.contentView addSubview:view];
        for (int i=0; i<8; i++) {
            int col =i%8;
            UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(10+(10+(WIDTH*2-90)/8)*col, 10, (WIDTH*2-90)/8, (WIDTH*2-90)/8);
            button.layer.borderColor=[UIColor blackColor].CGColor;
            button.layer.borderWidth=0.5;
            button.tag=i+1;
            [view addSubview:button];
            [_imageButtonArr addObject:button];
        }
        for (UIButton *button in _imageButtonArr) {
            if (button.tag==1) {
                [button setTitle:@"添加照片" forState: UIControlStateNormal];
                button.titleLabel.font=[UIFont systemFontOfSize:14.0];
                [button addTarget:self action:@selector(headerImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundColor:BJCOLOR];
            }else{
                if ([[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/carImage.plist"]]) {
                    NSMutableArray *arr=[NSMutableArray arrayWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/carImage.plist"]];
                    if (button.tag<arr.count+2) {
                        [button setBackgroundImage:[UIImage imageWithData:arr[button.tag-2]] forState:UIControlStateNormal];
                    }
                }
            }
        }
    }else if (indexPath.section==1) {
        cell.nameLabel.text=section1ListArr[indexPath.row];
        cell.detailTextField.placeholder=section1PlaceholderArr[indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextField.enabled=NO;

        if (indexPath.row==0) {
            cell.detailTextField.text=[self writeWithKey:@"brand"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveBrand:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            
        }else {
            cell.detailTextField.text=[self writeWithKey:@"color"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveColor:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
        }
    }else if (indexPath.section==2) {
        cell.nameLabel.text=section2ListArr[indexPath.row];
        cell.detailTextField.placeholder=section2PlaceholderArr[indexPath.row];
        if (indexPath.row==0) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            cell.nameLabel.font=[UIFont systemFontOfSize:10.0];
            cell.detailTextField.text=[self writeWithKey:@"carTime"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveCardTime:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            
        }else if (indexPath.row==1) {
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/5*4, 10, WIDTH/5-10, 20)];
            label.textColor=BJCOLOR;
            [cell addSubview:label];
            label.text=@"万公里";
            label.textAlignment=NSTextAlignmentRight;
            label.font=[UIFont systemFontOfSize:14.0];
            cell.detailTextField.text=[self writeWithKey:@"driveNumber"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveDriveNumbe:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.keyboardType=UIKeyboardTypeDecimalPad;
            cell.detailTextField.tag=6;
        }else {
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/5*4, 10, WIDTH/5-10, 20)];
            label.textColor=BJCOLOR;
            [cell addSubview:label];
            label.text=@"万元";
            label.textAlignment=NSTextAlignmentRight;
            label.font=[UIFont systemFontOfSize:14.0];
            cell.detailTextField.text=[self writeWithKey:@"carPrice"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveCarPrice:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.keyboardType=UIKeyboardTypeNumberPad;
            cell.detailTextField.tag=7;
        }
    }else if (indexPath.section==3){
        cell.nameLabel.text=section3ListArr[indexPath.row];
        cell.detailTextField.placeholder=section3PlaceholderArr[indexPath.row];
        if (indexPath.row==0) {
            cell.detailTextField.text=[self writeWithKey:@"person"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePerson:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=1;
        }else if (indexPath.row==1){
            cell.detailTextField.keyboardType=UIKeyboardTypeNumberPad;
            cell.detailTextField.text=[self writeWithKey:@"phone"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePhone:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=2;
        }else{
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveCarAddress:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.text=[self writeWithKey:@"carAddress"];
        }
    }else{
        cell.nameLabel.text=section4ListArr[indexPath.row];
        cell.detailTextField.placeholder=section4PlaceholderArr[indexPath.row];
        if (indexPath.row==0) {
            cell.detailTextField.text=[self writeWithKey:@"title"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveTitle:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=5;
            
        }else{
            CGSize rect =[cell.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
            cell.nameLabel.frame=CGRectMake(cell.nameLabel.frame.origin.x, cell.nameLabel.frame.origin.y, cell.nameLabel.frame.size.width, rect.height+20);
            cell.nameLabel.numberOfLines=0;
            cell.nameLabel.lineBreakMode=NSLineBreakByWordWrapping;
            cell.detailTextField.text=[self writeWithKey:@"describe"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveDescribe:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=4;
        }
    }
    return cell;
}
-(NSString *)writeWithKey:(NSString *)str{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:str]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:str];
    }else{
        return @"";
    }
}

-(void)saveBrand:(NSNotification *)not{
    [self save:@"brand" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePhone:(NSNotification *)not{
    [self save:@"phone" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:3];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveColor:(NSNotification *)not{
    [self save:@"color" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveCardTime:(NSNotification *)not{
    [self save:@"cardTime" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveDriveNumbe:(NSNotification *)not{
    [self save:@"driveNumber" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveCarPrice:(NSNotification *)not{
    [self save:@"carPrice" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:2 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePerson:(NSNotification *)not{
    [self save:@"person" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:3];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveCarAddress:(NSNotification *)not{
    [self save:@"carAddress" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:2 inSection:3];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveTitle:(NSNotification *)not{
    [self save:@"title" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0
        inSection:4];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveDescribe:(NSNotification *)not{
    [self save:@"describe" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1
                                               inSection:4];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)save:(NSString *)str withNot:(NSNotification*)not{
    UITextField *textField =(UITextField*)[not object];
    [[NSUserDefaults standardUserDefaults]setObject:textField.text  forKey:str];
}

//头像
-(void)headerImageButtonClick:(UIButton *)button{
    __block typeof(self) otherSelf = self;
    _imagePiker=[[UIImagePickerController alloc]init];
    _imagePiker.delegate=self;
    _imagePiker.allowsEditing=YES;
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
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image =[info objectForKey:UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    [picker dismissViewControllerAnimated:YES completion:^{}];
    picker.delegate=nil;
    [_imageArr addObject:imageData];
    [_imageArr writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/carImage.plist"] atomically:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
//点击cell触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            _brandArr=@[@"宝马",@"奔驰",@"奥迪",@"路虎",@"本田",@"福特"];
            ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择品牌" textArray:_brandArr withKey:@"brabd"];
            [vc.choosButton addTarget:self action:@selector(chooseBrandClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];
        }else  {
            _colorArr=@[@"黑色",@"白色",@"银灰色",@"深灰色",@"咖啡色",@"红色",@"蓝色",@"绿色",@"黄色",@"橙色",@"香槟色",@"紫色",@"多彩色",@"其它"];
            ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择车辆颜色" textArray:_colorArr withKey:@"color"];
            [vc.choosButton addTarget:self action:@selector(chooseColorClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];
        }
        }
    if (indexPath.section==2){
        if (indexPath.row==0) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            _pickerView.frame=CGRectMake(0, HEIGHT/5*3, WIDTH, HEIGHT/5*2);
            [UIView commitAnimations];
            [_pickerView.button addTarget:self action:@selector(chooseDate) forControlEvents:UIControlEventTouchUpInside];
            _tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(datePickerDown)];
            [self.view addGestureRecognizer:_tap];
            _view.hidden=YES;
        }
    }
    if (indexPath.section==3) {
        if (indexPath.row==2) {
            _carPlaceArr=@[@"二七区",@"中原区",@"回族管城区",@"惠济区",@"金水区",@"上街区",@"巩义市",@"新密市",@"新郑市",@"登封市",@"荥阳市",@"中牟县",@"经济技术开发区",@"高新技术开发区"];
            ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择看车地点" textArray:_carPlaceArr withKey:@"carAddress"];
            [vc.choosButton addTarget:self action:@selector(chooseCarAddressClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];
    }
  }
}

//选择品牌
-(void)chooseBrandClick:(UIButton *)button{
    NSString *text=_brandArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"brand"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//选择颜色
-(void)chooseColorClick:(UIButton *)button{
    NSString *text=_colorArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:1];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"color"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

//选择看车区域
-(void)chooseCarAddressClick:(UIButton *)button{
    NSString *text=_carPlaceArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:3];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"carAddress"];
    [self.navigationController popViewControllerAnimated:YES];
}

//创建时间选择器
-(void)creatDatePicker{
    _pickerView =[[PickerView alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, WIDTH/2)];
    [_pickerView.button addTarget:self action:@selector(chooseDate) forControlEvents:UIControlEventTouchUpInside];
    _pickerView.titleLabel.text=@"上牌时间";
    [self.view addSubview:_pickerView];
}
//选择时间
-(void)chooseDate{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=_pickerView.dateString;
    [[NSUserDefaults standardUserDefaults]setObject:_pickerView.dateString  forKey:@"carTime"];
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
