//
//  SailNewHouseViewController.m
//  temp
//
//  Created by l x on 16/5/25.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "SailNewHouseViewController.h"
#import "ResumeTableViewCell.h"
#import "ChooseViewController.h"
#import "picker.h"

@interface SailNewHouseViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    NSArray *_addressArr;
    NSArray *_peizhiArr;
    NSArray *_zhuangxiuArr;
    NSMutableArray *_imageButtonArr;
    UIView *_view;
    NSMutableArray *_textFieldArr;
    BOOL isHaveDian;
    NSMutableArray *_judgeArr;

}
@property (nonatomic,strong) UITapGestureRecognizer *tap;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) picker *huxingPickerView;
@property (nonatomic,strong) picker *loucengPickerView;
@property (nonatomic,strong) UIImagePickerController *imagePiker;

@end

@implementation SailNewHouseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatNavigationItem];
    [self creatTableView];
    [self creatHuXingPickerView];
    [self creatLouCengPickerView];
    _imageArr=[NSMutableArray arrayWithCapacity:0];
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
        [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sailnewhouseImage.plist"] error:nil];
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
//    [chooseButton addTarget:self action:@selector(resumeButtonClcik) forControlEvents:UIControlEventTouchUpInside];
//    [_view addSubview:chooseButton];
//    
//}
-(void)resumeButtonClick{
    NSString *chaoxiang;
    NSString *zhuangxiu;
    NSString *dec_mianji;
    NSString *dec_price;
    NSString *dt_datetime;
    NSString *huxing;
    NSString *lianxiren;
    NSString *louceng;
    NSString *miaoshu;
    NSString *phone;
    NSString *quyu;
    NSString *title;
    NSString *xiaoqu;
    NSString *xinxilaiyuan;
    
    NSDate *currentDate =[NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *fabutime=[formatter stringFromDate:currentDate];
    dt_datetime=fabutime;
    NSUserDefaults *UDF =[NSUserDefaults standardUserDefaults];
    
    if ([UDF objectForKey:@"sailchaoxiang3"]) {
        chaoxiang=[UDF objectForKey:@"sailchaoxiang3"];
    }else{
        chaoxiang=@"";
    }
    if ([UDF objectForKey:@"sailzhuangxiu3"]) {
        zhuangxiu=[UDF objectForKey:@"sailzhuangxiu3"];
    }else{
        zhuangxiu=@"";
    }
    if ([UDF objectForKey:@"sailmianji3"]) {
        dec_mianji=[UDF objectForKey:@"sailmianji3"];
    }else{
        dec_mianji=@"";
    }
    if ([UDF objectForKey:@"sailshoujia3"]) {
        dec_price=[UDF objectForKey:@"sailshoujia3"];
    }else{
        dec_price=@"";
    }
    if ([UDF objectForKey:@"sailhuxing3"]) {
        huxing=[UDF objectForKey:@"sailhuxing3"];
    }else{
        huxing=@"";
    }
    if ([UDF objectForKey:@"sailperson3"]) {
        lianxiren=[UDF objectForKey:@"sailperson3"];
    }else{
        lianxiren=@"";
    }
    if ([UDF objectForKey:@"saillouceng3"]) {
        louceng=[UDF objectForKey:@"saillouceng3"];
    }else{
        louceng=@"";
    }
    if ([UDF objectForKey:@"sailhouseDescribe3"]) {
        miaoshu=[UDF objectForKey:@"sailhouseDescribe3"];
    }else{
        miaoshu=@"";
    }
    if ([UDF objectForKey:@"sailphone3"]) {
        phone=[UDF objectForKey:@"sailphone3"];
    }else{
        phone=@"";
    }
    if ([UDF objectForKey:@"sailhouseName3"]) {
        quyu=[UDF objectForKey:@"sailhouseName3"];
    }else{
        quyu=@"";
    }
    if ([UDF objectForKey:@"sailhouseTitle3"]) {
        title=[UDF objectForKey:@"sailhouseTitle3"];
    }else{
        title=@"";
    }
    if ([UDF objectForKey:@"sailaddress3"]) {
        xiaoqu=[UDF objectForKey:@"sailaddress3"];
    }else{
        xiaoqu=@"";
    }
    if ([UDF objectForKey:@"sailneede3"]) {
        xinxilaiyuan=[UDF objectForKey:@"sailneede3"];
    }else{
        xinxilaiyuan=@"精品";
    }
    
    NSArray *imageArr;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sailnewhouseImage.plist"]]) {
        imageArr=[NSArray arrayWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sailnewhouseImage.plist"]];
    }
    NSData *data1;
    NSData *data2;
    NSData *data3;
    NSData *data4;
    NSData *data5;
    NSData *data6;
    NSData *data7;
    UIImage *image =[UIImage imageNamed:@"tu.png"];
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
            [AFHttpManager sendNewHouseChuShouWithchaoxiang:chaoxiang withzhuangxiu:zhuangxiu withdec_mianji:dec_mianji withdec_price:dec_price withdt_datetime:dt_datetime wihthhuxing:huxing withimg1:data1 withimg2:data2 withimg3:data3 withimg4:data4 withimg5:data5 withimg6:data6 withimg7:data7 withlianxiren:lianxiren withlouceng:louceng withmiaoshu:miaoshu withphone:phone withquyu:quyu withtitle:title withxiaoqu:xiaoqu withxinxilaiyuan:xinxilaiyuan withType:^(NSString *string) {
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
            SHOW_MESSAGE(@"亲，输入超出长度范围");
            textField.text = [textField.text substringToIndex:30];
        }
    }else if (textField.tag==4) {
        if (textField.text.length > 800) {
            textField.text = [textField.text substringToIndex:800];
            SHOW_MESSAGE(@"亲，输入超出长度范围");
        }
    }else if (textField.tag==7||textField.tag==8) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
            SHOW_MESSAGE(@"亲，输入超出长度范围");
        }
    }else if (textField.tag==9) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
            SHOW_MESSAGE(@"亲，输入超出长度范围");
        }
    }else{
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag==2||textField.tag==7||textField.tag==8) {
        
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if(section==2){
        return 6;
    }else{
        return 2;
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
    }else if (indexPath.section==3&&indexPath.row==1) {
        return 60;
    }else{
        return 40;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *section1ListArr=@[@"选择区域",@"小区名称"];
    NSArray *section1PlaceholderArr=@[@"请选择",@"2-20字,不能填写手机号"];
    NSArray *section2ListArr=@[@"售       价",@"户       型",@"建筑面积",@"楼       层",@"朝       向",@"装      修"];
    NSArray *section2PlaceholderArr=@[@"数字填写，不能是0",@"请选择户型",@"数字填写，请输入",@"请选择楼层",@"请选择",@"请选择"];
    NSArray *section3ListArr=@[@"标       题",@"描       述（选填）"];
    NSArray *section3PlaceholderArr=@[@"6-30字，不能填写电话",@"装修情况，房屋类型，周边设施等等"];
    NSArray *section4ListArr=@[@"联系人",@"联系电话"];
    NSArray *section4PlaceholderArr=@[@"2-4字，只能填汉字或字母",@"只许填写手机号和固定电话",];
    
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
                if ([[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sailnewhouseImage.plist"]]) {
                    NSArray *arr=[NSArray arrayWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sailnewhouseImage.plist"]];
                    if (button.tag<arr.count+2) {
                        [button setBackgroundImage:[UIImage imageWithData:arr[button.tag-2]] forState:UIControlStateNormal];
                    }
                }
            }
        }
    }else if (indexPath.section==1) {
        cell.nameLabel.text=section1ListArr[indexPath.row];
        cell.detailTextField.placeholder=section1PlaceholderArr[indexPath.row];
        if (indexPath.row==0) {
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"sailaddress3"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveAddress1:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else {
            cell.detailTextField.text=[self writeWithKey:@"sailhouseName3"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveHouseName1:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=9;
        }
    }else if (indexPath.section==2) {
        cell.nameLabel.text=section2ListArr[indexPath.row];
        cell.detailTextField.placeholder=section2PlaceholderArr[indexPath.row];
        if (indexPath.row==0) {
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/5*4, 10, WIDTH/5-10, 20)];
            label.textColor=BJCOLOR;
            [cell addSubview:label];
            label.text=@"万元";
            label.textAlignment=NSTextAlignmentRight;
            label.font=[UIFont systemFontOfSize:14.0];
            cell.detailTextField.text=[self writeWithKey:@"sailshoujia3"];
            cell.detailTextField.keyboardType=UIKeyboardTypeNumberPad;
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveShoujia3:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=7;
        }else if (indexPath.row==1) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"sailhuxing3"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveHuXing1:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
        }else if (indexPath.row==2) {
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/5*4, 10, WIDTH/5-10, 20)];
            label.textColor=BJCOLOR;
            [cell addSubview:label];
            label.text=@"平米";
            label.textAlignment=NSTextAlignmentRight;
            label.font=[UIFont systemFontOfSize:14.0];
            cell.detailTextField.text=[self writeWithKey:@"sailmianji3"];
            cell.detailTextField.keyboardType=UIKeyboardTypeNumberPad;
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveMianji3:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=8;
        }else if (indexPath.row==3){
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.text=[self writeWithKey:@"saillouceng3"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveLouceng1:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.enabled=NO;
        }else if (indexPath.row==4){
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.text=[self writeWithKey:@"sailchaoxiang3"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveChaoxiang1:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.enabled=NO;
        }else{
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"sailzhuangxiu3"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveFangling1:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
        }
    }else if (indexPath.section==3){
        cell.nameLabel.text=section3ListArr[indexPath.row];
        cell.detailTextField.placeholder=section3PlaceholderArr[indexPath.row];
        if (indexPath.row==0){
            cell.detailTextField.text=[self writeWithKey:@"sailhouseTitle3"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveHouseTitle1:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=5;
        }else{
            CGSize rect =[cell.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
            cell.nameLabel.frame=CGRectMake(cell.nameLabel.frame.origin.x, cell.nameLabel.frame.origin.y, cell.nameLabel.frame.size.width, rect.height+20);
            cell.nameLabel.numberOfLines=0;
            cell.nameLabel.lineBreakMode=NSLineBreakByWordWrapping;
            
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveHouseDescibe1:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.text=[self writeWithKey:@"sailhouseDescibe3"];
            cell.detailTextField.tag=4;
        }
    }else{
        cell.nameLabel.text=section4ListArr[indexPath.row];
        cell.detailTextField.placeholder=section4PlaceholderArr[indexPath.row];
        if (indexPath.row==0) {
            cell.detailTextField.text=[self writeWithKey:@"sailperson3"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePerson1:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=1;
        }else {
            cell.detailTextField.keyboardType=UIKeyboardTypeNumberPad;
            cell.detailTextField.text=[self writeWithKey:@"sailphone3"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePhone1:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=2;
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

-(void)saveAddress1:(NSNotification *)not{
    [self save:@"sailaddress3" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveHouseName1:(NSNotification *)not{
    [self save:@"sailhouseName3" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveShoujia3:(NSNotification *)not{
    [self save:@"sailshoujia3" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveHuXing1:(NSNotification *)not{
    [self save:@"sailhuxing3" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveMianji3:(NSNotification *)not{
    [self save:@"sailmianji3" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:2 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveLouceng1:(NSNotification *)not{
    [self save:@"saillouceng3" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:3 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveChaoxiang1:(NSNotification *)not{
    [self save:@"sailchaoxiang3" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:4 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveFangling1:(NSNotification *)not{
    [self save:@"sailzhuangxiu3" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:5 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveHouseTitle1:(NSNotification *)not{
    [self save:@"sailhouseTitle3" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:3];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveHouseDescibe1:(NSNotification *)not{
    [self save:@"sailhouseDescibe3" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:3];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePerson1:(NSNotification *)not{
    [self save:@"sailperson3" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:4];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePhone1:(NSNotification *)not{
    [self save:@"sailphone3" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:4];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)save:(NSString *)str withNot:(NSNotification*)not{
    UITextField *textField =(UITextField*)[not object];
    [[NSUserDefaults standardUserDefaults]setObject:textField.text  forKey:str];
}
//图片
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
    [_imageArr writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sailhouseImage.plist"] atomically:YES];
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
            _addressArr=@[@"二七区",@"中原区",@"回族管城区",@"惠济区",@"金水区",@"上街区",@"巩义市",@"新密市",@"新郑市",@"登封市",@"荥阳市",@"中牟县",@"经济技术开发区",@"高新技术开发区"];
            ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择区域" textArray:_addressArr withKey:@"sailaddress3"];
            [vc.choosButton addTarget:self action:@selector(chooseAddressClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section==2&&indexPath.row==1){
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        _huxingPickerView.frame=CGRectMake(0, HEIGHT/5*2, WIDTH, HEIGHT/5*3);
        [UIView commitAnimations];
        _tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(datePickerDown)];
        [self.view addGestureRecognizer:_tap];
        _view.hidden=YES;
    }
    if (indexPath.section==2&&indexPath.row==3) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        _loucengPickerView.frame=CGRectMake(0, HEIGHT/5*2, WIDTH, HEIGHT/5*3);
        [UIView commitAnimations];
        _tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(datePickerDown)];
        [self.view addGestureRecognizer:_tap];
        _view.hidden=YES;
    }
    if (indexPath.section==2&&indexPath.row==4) {
        _peizhiArr=@[@"东",@"西",@"南",@"北",@"东西",@"南北",@"东南",@"东北",@"西南",@"西北"];
        ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择朝向" textArray:_peizhiArr withKey:@"sailchaoxinag3"];
        [vc.choosButton addTarget:self action:@selector(choosePeizhiClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section==2&&indexPath.row==5) {
        _zhuangxiuArr=@[@"豪华装修",@"精装修",@"中等装修",@"简单装修",@"毛坯"];
        ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"装修" textArray:_zhuangxiuArr withKey:@"sailzhuangxiu3"];
        [vc.choosButton addTarget:self action:@selector(chooseZhuangxiuClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController pushViewController:vc animated:YES];
    }

}
//选择区域
-(void)chooseAddressClick:(UIButton *)button{
    NSString *text=_addressArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"sailaddress3"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//选择朝向
-(void)choosePeizhiClick:(UIButton *)button{
    NSString *text=_peizhiArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:4 inSection:2];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"sailchaoxiang3"];
    
    [self.navigationController popViewControllerAnimated:YES];
}
//选择装修
-(void)chooseZhuangxiuClick:(UIButton *)button{
    NSString *text=_zhuangxiuArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:5 inSection:2];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"sailzhuangxiu3"];
    
    [self.navigationController popViewControllerAnimated:YES];
}
//创建选择器
-(void)creatHuXingPickerView{
    _huxingPickerView =[[picker alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, HEIGHT/5*3)];
    _huxingPickerView.arr1=@[@"1室",@"2室",@"3室",@"4室",@"5室",@"6室",@"7室",@"8室",@"9室",@"10室"];
    _huxingPickerView.arr2=@[@"0厅",@"1厅",@"2厅",@"3厅",@"4厅",@"5厅",@"6厅",@"7厅",@"8厅",@"9厅"];
    _huxingPickerView.arr3=@[@"0卫",@"1卫",@"2卫",@"3卫",@"4卫",@"5卫",@"6卫",@"7卫",@"8卫",@"9卫"];
    _huxingPickerView.component=3;
    _huxingPickerView.row=10;
    _huxingPickerView.titleLabel.text=@"户型";
    [_huxingPickerView.button addTarget:self action:@selector(chooseHuxing) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_huxingPickerView];
}
-(void)creatLouCengPickerView{
    _loucengPickerView =[[picker alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, HEIGHT/5*3)];
    _loucengPickerView.arr1=@[@"第1层",@"第2层",@"第3层",@"第4层",@"第5层",@"第6层",@"第7层",@"第8层",@"第9层",@"第10层",@"第11层",@"第12层",@"第13层",@"第14层",@"第15层",@"第16层",@"第17层",@"第18层",@"第19层",@"第20层",@"第21层",@"第22层",@"第23层",@"第24层",@"第25层",@"第26层",@"第27层",@"第28层",@"第29层",@"第30层",@"第31层",@"第32层",@"第33层",@"第34层",@"第35层",@"第36层",@"第37层",@"第38层",@"第39层",@"第40层",@"第412层",@"第42层",@"第43层",@"第44层",@"第45层",@"第46层",@"第47层",@"第48层",@"第49层",@"第50层"];
    _loucengPickerView.arr2=@[@"共1层",@"共2层",@"共3层",@"共4层",@"共5层",@"共6层",@"共7层",@"共8层",@"共9层",@"共10层",@"共11层",@"共12层",@"共13层",@"共14层",@"共15层",@"共16层",@"共17层",@"共18层",@"共19层",@"共20层",@"共21层",@"共22层",@"共23层",@"共24层",@"共25层",@"共26层",@"共27层",@"共28层",@"共29层",@"共30层",@"共31层",@"共32层",@"共33层",@"共34层",@"共35层",@"共36层",@"共37层",@"共38层",@"共39层",@"共40层",@"共41层",@"共42层",@"共43层",@"共44层",@"共45层",@"共46层",@"共47层",@"共48层",@"共49层",@"共50层"];
    _loucengPickerView.component=2;
    _loucengPickerView.row=_loucengPickerView.arr1.count;
    _loucengPickerView.titleLabel.text=@"楼层";
    [_loucengPickerView.button addTarget:self action:@selector(chooseLouceng) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loucengPickerView];
}
-(void)chooseHuxing{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:2];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=_huxingPickerView.pickerString;
    [[NSUserDefaults standardUserDefaults]setObject:_huxingPickerView.pickerString  forKey:@"sailhuxing3"];
    [self datePickerDown];
}
-(void)chooseLouceng{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:2];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=_loucengPickerView.pickerString;
    [[NSUserDefaults standardUserDefaults]setObject:_loucengPickerView.pickerString  forKey:@"saillouceng3"];
    [self datePickerDown];
}

//选择器下降
-(void)datePickerDown{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _loucengPickerView.frame=CGRectMake(0, HEIGHT, WIDTH, HEIGHT/5*2);
    _huxingPickerView.frame=CGRectMake(0, HEIGHT, WIDTH, HEIGHT/5*2);
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
