//
//  SailShangPuViewController.m
//  temp
//
//  Created by l x on 16/5/25.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "SailShangPuViewController.h"
#import "ResumeTableViewCell.h"
#import "ChooseViewController.h"

@interface SailShangPuViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    NSArray *_addressArr;
    NSArray *_leixingArr;
    NSMutableArray *_imageButtonArr;
    UIView *_view;
    NSMutableArray *_textFieldArr;
    BOOL isHaveDian;
    NSMutableArray *_judgeArr;

}
@property (nonatomic,strong) UITapGestureRecognizer *tap;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImagePickerController *imagePiker;

@end

@implementation SailShangPuViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatNavigationItem];
    [self creatTableView];
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
        [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sailhouseImage5.plist"] error:nil];
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
//    [chooseButton addTarget:self action:@selector(resumeButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [_view addSubview:chooseButton];
//    
//}
-(void)resumeButtonClick{
    NSString *biaozhi;
    NSString *dec_mianji;
    NSString *dec_price;
    NSString *dizhi;
    NSString *dt_datetime;
    NSString *gongxu;
    NSString *leixing;
    NSString *lianxiren;
    NSString *miaoshu;
    NSString *phone;
    NSString *quyu;
    NSString *title;
    NSString *xinxilaiyuan;
    
    biaozhi=@"商铺出售";
    NSDate *currentDate =[NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *fabutime=[formatter stringFromDate:currentDate];
    dt_datetime=fabutime;
    NSUserDefaults *UDF =[NSUserDefaults standardUserDefaults];
    
    if ([UDF objectForKey:@"sailmianji5"]) {
        dec_mianji=[UDF objectForKey:@"sailmianji5"];
    }else{
        dec_mianji=@"";
    }
    if ([UDF objectForKey:@"sailzujin5"]) {
        dec_price=[UDF objectForKey:@"sailzujin5"];
    }else{
        dec_price=@"";
    }
    if ([UDF objectForKey:@"sailhouseAddress5"]) {
        dizhi=[UDF objectForKey:@"sailhouseAddress5"];
    }else{
        dizhi=@"";
    }
    if ([UDF objectForKey:@"sailgongxu5"]) {
        gongxu=[UDF objectForKey:@"sailgongxu5"];
    }else{
        gongxu=@"";
    }
    if ([UDF objectForKey:@"sailleixing5"]) {
        leixing=[UDF objectForKey:@"sailleixing5"];
    }else{
        leixing=@"";
    }
    if ([UDF objectForKey:@"sailperson5"]) {
        lianxiren=[UDF objectForKey:@"sailperson5"];
    }else{
        lianxiren=@"";
    }
    if ([UDF objectForKey:@"sailhouseDescribe5"]) {
        miaoshu=[UDF objectForKey:@"sailhouseDescribe5"];
    }else{
        miaoshu=@"";
    }
    if ([UDF objectForKey:@"sailphone5"]) {
        phone=[UDF objectForKey:@"sailphone5"];
    }else{
        phone=@"";
    }
    if ([UDF objectForKey:@"sailaddress5"]) {
        quyu=[UDF objectForKey:@"sailaddress5"];
    }else{
        quyu=@"";
    }
    if ([UDF objectForKey:@"sailhouseTitle5"]) {
        title=[UDF objectForKey:@"sailhouseTitle5"];
    }else{
        title=@"";
    }
    if ([UDF objectForKey:@"sailneede5"]) {
        xinxilaiyuan=[UDF objectForKey:@"sailneede5"];
    }else{
        xinxilaiyuan=@"";
    }
    
    NSArray *imageArr;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sailhouseImage5.plist"]]) {
        imageArr=[NSArray arrayWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sailhouseImage5.plist"]];
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
            [AFHttpManager sendShangPuChuShouWithbiaozhi:biaozhi withdec_mianji:dec_mianji withdec_price:dec_price withdizhi:dizhi withdt_datetime:dt_datetime wihthgongxu:gongxu withimg1:data1 withimg2:data2 withimg3:data3 withimg4:data4 withimg5:data5 withimg6:data6 withimg7:data7 withleixing:leixing withlianxiren:lianxiren withmiaoshu:miaoshu withphone:phone withquyu:quyu withtitle:title withxinxilaiyuan:xinxilaiyuan withType:^(NSString *string) {
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
        if (textField.text.length > 30) {
            textField.text = [textField.text substringToIndex:30];
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
    }else if(section==1||section==3){
        return 2;
    }else if(section==2){
        return 4;
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
    }else if (indexPath.section==3&&indexPath.row==1) {
        return 60;
    }else{
        return 40;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *section1ListArr=@[@"选择区域",@"商铺地址"];
    NSArray *section1PlaceholderArr=@[@"请选择",@"2-30字，不能填写电话"];
    NSArray *section2ListArr=@[@"供       需",@"售       价",@"面       积",@"商铺类型"];
    NSArray *section2PlaceholderArr=@[@"",@"数字填写，不能是0",@"数字填写，请输入",@"请选择"];
    NSArray *section3ListArr=@[@"标       题",@"描       述（选填）"];
    NSArray *section3PlaceholderArr=@[@"6-30字，不能填写电话",@"最短租期，房屋面积等等"];
    NSArray *section4ListArr=@[@"联系人",@"联系电话",@"信息来源"];
    NSArray *section4PlaceholderArr=@[@"2-4字，只能填汉字或字母",@"只许填写手机号和固定电话",@""];
    
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
                if ([[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sailhouseImage5.plist"]]) {
                    NSArray *arr=[NSArray arrayWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sailhouseImage5.plist"]];
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
            cell.detailTextField.text=[self writeWithKey:@"sailaddress5"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveAddress5:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else {
            cell.detailTextField.text=[self writeWithKey:@"sailhouseAddress5"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveHouseAddress5:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=9;
        }
    }else if (indexPath.section==2) {
        cell.nameLabel.text=section2ListArr[indexPath.row];
        cell.detailTextField.placeholder=section2PlaceholderArr[indexPath.row];
        cell.detailTextField.keyboardType=UIKeyboardTypeNumberPad;
        if (indexPath.row==0) {
            UISegmentedControl *seg =[[UISegmentedControl alloc]initWithItems:@[@"出租",@"求租"]];
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sailgongxu5"] isEqualToString:@"求租"]) {
                seg.selectedSegmentIndex=1;
            }else{
                seg.selectedSegmentIndex=0;
            }
            seg.frame=CGRectMake(WIDTH/3-10, 10, WIDTH/3*2-10, 20);
            [seg addTarget:self action:@selector(changeGongxu:) forControlEvents:UIControlEventValueChanged];
            seg.tintColor=BJCOLOR;
            [cell addSubview:seg];
            cell.detailTextField.text=@"123";
            cell.detailTextField.textColor=[UIColor clearColor];
            cell.detailTextField.enabled=NO;
            
        }else if (indexPath.row==1) {
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/5*4, 10, WIDTH/5-10, 20)];
            label.textColor=BJCOLOR;
            [cell addSubview:label];
            label.text=@"万元";
            label.textAlignment=NSTextAlignmentRight;
            label.font=[UIFont systemFontOfSize:14.0];
            cell.detailTextField.text=[self writeWithKey:@"sailzujin5"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveZujin5:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=7;
        }else if (indexPath.row==2) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/5*4, 10, WIDTH/5-10, 20)];
            label.textColor=BJCOLOR;
            [cell addSubview:label];
            label.text=@"平米";
            label.textAlignment=NSTextAlignmentRight;
            label.font=[UIFont systemFontOfSize:14.0];
            cell.detailTextField.text=[self writeWithKey:@"sailmianji5"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveMianji5:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=8;
        }else {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.text=[self writeWithKey:@"sailleixing5"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveLeixing5:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.enabled=NO;
        }
    }else if (indexPath.section==3){
        cell.nameLabel.text=section3ListArr[indexPath.row];
        cell.detailTextField.placeholder=section3PlaceholderArr[indexPath.row];
        if (indexPath.row==0){
            cell.detailTextField.text=[self writeWithKey:@"sailhouseTitle5"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveHouseTitle5:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=5;
        }else{
            CGSize rect =[cell.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
            cell.nameLabel.frame=CGRectMake(cell.nameLabel.frame.origin.x, cell.nameLabel.frame.origin.y, cell.nameLabel.frame.size.width, rect.height+20);
            cell.nameLabel.numberOfLines=0;
            cell.nameLabel.lineBreakMode=NSLineBreakByWordWrapping;
            
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveHouseDescibe5:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.text=[self writeWithKey:@"sailhouseDescibe5"];
            cell.detailTextField.tag=4;
        }
    }else{
        cell.nameLabel.text=section4ListArr[indexPath.row];
        cell.detailTextField.placeholder=section4PlaceholderArr[indexPath.row];
        if (indexPath.row==0) {
            cell.detailTextField.text=[self writeWithKey:@"sailperson5"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePerson5:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=1;
        }else if (indexPath.row==1){
            cell.detailTextField.keyboardType=UIKeyboardTypeNumberPad;
            cell.detailTextField.text=[self writeWithKey:@"sailphone5"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePhone5:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=2;
        }else{
            UISegmentedControl *seg =[[UISegmentedControl alloc]initWithItems:@[@"个人",@"经纪人"]];
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sailneede5"] isEqualToString:@"经纪人"]) {
                seg.selectedSegmentIndex=1;
            }else{
                seg.selectedSegmentIndex=0;
            }
            seg.frame=CGRectMake(WIDTH/3-10, 10, WIDTH/3*2-10, 20);
            [seg addTarget:self action:@selector(changeNeede5:) forControlEvents:UIControlEventValueChanged];
            seg.tintColor=BJCOLOR;
            [cell addSubview:seg];
            cell.detailTextField.text=@"123";
            cell.detailTextField.textColor=[UIColor clearColor];
            cell.detailTextField.enabled=NO;
        }
    }
    return cell;
}
-(void)changeGongxu:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"出租" forKey:@"sailgongxu5"];
        }
            break;
        case 1:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"求租" forKey:@"sailgongxu5"];
        }
            break;
        default:
            break;
    }
}

-(void)changeNeede5:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"个人" forKey:@"sailneede5"];
        }
            break;
        case 1:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"经纪人" forKey:@"sailneede5"];
        }
            break;
        default:
            break;
    }
}
-(NSString *)writeWithKey:(NSString *)str{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:str]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:str];
    }else{
        return @"";
    }
}

-(void)saveAddress5:(NSNotification *)not{
    [self save:@"sailaddress5" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveHouseAddress5:(NSNotification *)not{
    [self save:@"sailhouseAddress5" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveZujin5:(NSNotification *)not{
    [self save:@"sailzujin5" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveMianji5:(NSNotification *)not{
    [self save:@"sailmianji5" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:2 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveLeixing5:(NSNotification *)not{
    [self save:@"sailleixing5" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:3 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveHouseTitle5:(NSNotification *)not{
    [self save:@"sailhouseTitle5" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:3];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveHouseDescibe5:(NSNotification *)not{
    [self save:@"sailhouseDescibe5" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:3];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePerson5:(NSNotification *)not{
    [self save:@"sailperson5" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:4];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePhone5:(NSNotification *)not{
    [self save:@"sailphone5" withNot:not];
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
    [_imageArr writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sailhouseImage5.plist"] atomically:YES];
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
            ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择区域" textArray:_addressArr withKey:@"sailaddress5"];
            [vc.choosButton addTarget:self action:@selector(chooseAddressClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section==2&&indexPath.row==3){
        
        _leixingArr=@[@"商业街商铺",@"社区住宅底商",@"写字楼配套",@"宾馆酒店",@"旅游点店铺",@"主题卖场",@"百货/购物中心",@"其他"];
        ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择区域" textArray:_leixingArr withKey:@"sailleixing5"];
        [vc.choosButton addTarget:self action:@selector(chooseLeixingClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
//选择区域
-(void)chooseAddressClick:(UIButton *)button{
    NSString *text=_addressArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"sailaddress5"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//选择商铺类型
-(void)chooseLeixingClick:(UIButton *)button{
    NSString *text=_leixingArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:2];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"sailleixing5"];
    
    [self.navigationController popViewControllerAnimated:YES];
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
