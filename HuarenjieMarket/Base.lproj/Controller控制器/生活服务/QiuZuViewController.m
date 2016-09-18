//
//  QiuZuViewController.m
//  temp
//
//  Created by l x on 16/5/23.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "QiuZuViewController.h"
#import "ResumeTableViewCell.h"
#import "ChooseViewController.h"
#import "picker.h"

@interface QiuZuViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    NSArray *_addressArr;
    NSArray *_zujinArr;
    NSMutableArray *_imageButtonArr;
    UIView *_view;
    NSMutableArray *_textFieldArr;
    BOOL isHaveDian;
    NSMutableArray *_judgeArr;

}
@property (nonatomic,strong) UITapGestureRecognizer *tap;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) picker *huxingPickerView;

@end

@implementation QiuZuViewController

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
        [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/houseImage1.plist"] error:nil];
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
//发布
-(void)resumeButtonClick{
    NSDate *currentDate =[NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *fabutime=[formatter stringFromDate:currentDate];
    NSUserDefaults *UDF =[NSUserDefaults standardUserDefaults];
    NSString *biaoti;
    NSString *dec_qiwangzujin;
    NSString *dt_datetime;
    NSString *huxing;
    NSString *lianxiren;
    NSString *miaoshu;
    NSString *phone;
    NSString *quyu;
    NSString *xinxilaiyuan;
    dt_datetime=fabutime;

    if ([UDF objectForKey:@"houseTitle4"]) {
        biaoti=[UDF objectForKey:@"houseTitle4"];
    }else{
        biaoti=@"";
    }
    if ([UDF objectForKey:@"zujin4"]) {
        dec_qiwangzujin=[UDF objectForKey:@"zujin4"];
    }else{
        dec_qiwangzujin=@"";
    }
    if ([UDF objectForKey:@"huxing4"]) {
        huxing=[UDF objectForKey:@"huxing4"];
    }else{
        huxing=@"";
    }
    if ([UDF objectForKey:@"person4"]) {
        lianxiren=[UDF objectForKey:@"person4"];
    }else{
        lianxiren=@"";
    }
    if ([UDF objectForKey:@"houseDescribe4"]) {
        miaoshu=[UDF objectForKey:@"houseDescribe4"];
    }else{
        miaoshu=@"";
    }
    if ([UDF objectForKey:@"phone4"]) {
        phone=[UDF objectForKey:@"phone4"];
    }else{
        phone=@"";
    }
    if ([UDF objectForKey:@"address4"]) {
        quyu=[UDF objectForKey:@"address4"];
    }else{
        quyu=@"";
    }
    if ([UDF objectForKey:@"neede4"]) {
        xinxilaiyuan=[UDF objectForKey:@"neede4"];
    }else{
        xinxilaiyuan=@"";
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
            [AFHttpManager sendQiuZuWithbiaoti:biaoti withdec_qiwangzujin:dec_qiwangzujin withdt_datetime:dt_datetime withhuxing:huxing withlianxiren:lianxiren withmiaoshu:miaoshu withphone:phone withquyu:quyu withxinxilaiyuan:xinxilaiyuan withType:^(NSString *string) {
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
    }else if (textField.tag==7) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
            SHOW_MESSAGE(@"亲，输入超出长度范围");
        }
    }else{
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag==2||textField.tag==7) {
        
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
    
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if(section==3){
        return 3;
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
    
    if (indexPath.section==2&&indexPath.row==1) {
        return 60;
    }else{
        return 40;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *section0ListArr=@[@"选择区域"];
    NSArray *section0PlaceholderArr=@[@"请选择"];
    NSArray *section1ListArr=@[@"户       型",@"期望租金"];
    NSArray *section1PlaceholderArr=@[@"请选择户型",@"请选择"];
    NSArray *section2ListArr=@[@"标       题",@"描       述（选填）"];
    NSArray *section2PlaceholderArr=@[@"6-30字，不能填写电话",@"期望面积，房屋类型等等"];
    NSArray *section3ListArr=@[@"联系人",@"联系电话",@"信息来源"];
    NSArray *section3PlaceholderArr=@[@"2-4字，只能填汉字或字母",@"只许填写手机号和固定电话",@""];
    
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
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"address4"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveAddress4:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }else if (indexPath.section==1) {
        cell.nameLabel.text=section1ListArr[indexPath.row];
        cell.detailTextField.placeholder=section1PlaceholderArr[indexPath.row];
        cell.detailTextField.keyboardType=UIKeyboardTypeNumberPad;
        if (indexPath.row==0) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"huxing4"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveHuXing4:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            
        }else{
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.text=[self writeWithKey:@"zujin4"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveZujin4:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.enabled=NO;
        }
    }else if (indexPath.section==2){
        cell.nameLabel.text=section2ListArr[indexPath.row];
        cell.detailTextField.placeholder=section2PlaceholderArr[indexPath.row];
        if (indexPath.row==0){
            cell.detailTextField.text=[self writeWithKey:@"houseTitle4"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveHouseTitle4:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=5;
        }else{
            CGSize rect =[cell.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
            cell.nameLabel.frame=CGRectMake(cell.nameLabel.frame.origin.x, cell.nameLabel.frame.origin.y, cell.nameLabel.frame.size.width, rect.height+20);
            cell.nameLabel.numberOfLines=0;
            cell.nameLabel.lineBreakMode=NSLineBreakByWordWrapping;
            
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveHouseDescibe4:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.text=[self writeWithKey:@"houseDescribe4"];
            cell.detailTextField.tag=4;
        }
    }else{
        cell.nameLabel.text=section3ListArr[indexPath.row];
        cell.detailTextField.placeholder=section3PlaceholderArr[indexPath.row];
        if (indexPath.row==0) {
            cell.detailTextField.text=[self writeWithKey:@"person4"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePerson4:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=1;
        }else if (indexPath.row==1){
            cell.detailTextField.keyboardType=UIKeyboardTypeNumberPad;
            cell.detailTextField.text=[self writeWithKey:@"phone4"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePhone4:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=2;
        }else{
            UISegmentedControl *seg =[[UISegmentedControl alloc]initWithItems:@[@"个人",@"经纪人"]];
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"neede4"] isEqualToString:@"经纪人"]) {
                seg.selectedSegmentIndex=1;
            }else{
                seg.selectedSegmentIndex=0;
            }
            seg.frame=CGRectMake(WIDTH/3-10, 10, WIDTH/3*2-10, 20);
            [seg addTarget:self action:@selector(changeNeede:) forControlEvents:UIControlEventValueChanged];
            seg.tintColor=BJCOLOR;
            [cell addSubview:seg];
            cell.detailTextField.text=@"123";
            cell.detailTextField.textColor=[UIColor clearColor];
            cell.detailTextField.enabled=NO;
        }
    }
    return cell;
}
-(void)changeNeede:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"个人" forKey:@"neede4"];
        }
            break;
        case 1:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"经纪人" forKey:@"neede4"];
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

-(void)saveAddress4:(NSNotification *)not{
    [self save:@"address4" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveHuXing4:(NSNotification *)not{
    [self save:@"huxing4" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveZujin4:(NSNotification *)not{
    [self save:@"zujin4" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveHouseTitle4:(NSNotification *)not{
    [self save:@"houseTitle4" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveHouseDescibe4:(NSNotification *)not{
    [self save:@"houseDescribe4" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePerson4:(NSNotification *)not{
    [self save:@"person4" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:3];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePhone4:(NSNotification *)not{
    [self save:@"phone4" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:3];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)save:(NSString *)str withNot:(NSNotification*)not{
    UITextField *textField =(UITextField*)[not object];
    [[NSUserDefaults standardUserDefaults]setObject:textField.text  forKey:str];
}
//点击cell触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            _addressArr=@[@"二七区",@"中原区",@"回族管城区",@"惠济区",@"金水区",@"上街区",@"巩义市",@"新密市",@"新郑市",@"登封市",@"荥阳市",@"中牟县",@"经济技术开发区",@"高新技术开发区"];
            ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择区域" textArray:_addressArr withKey:@"address4"];
            [vc.choosButton addTarget:self action:@selector(chooseAddressClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section==1&&indexPath.row==0){
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        _huxingPickerView.frame=CGRectMake(0, HEIGHT/5*2, WIDTH, HEIGHT/5*3);
        [UIView commitAnimations];
        _tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(datePickerDown)];
        [self.view addGestureRecognizer:_tap];
        _view.hidden=YES;
    }
    if (indexPath.section==1&&indexPath.row==1) {
        _zujinArr=@[@"500元以下",@"500-1000元",@"1000-1500元",@"1500-3000元",@"3000元以上"];
        ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"期望租金" textArray:_zujinArr withKey:@"zujin4"];
        [vc.choosButton addTarget:self action:@selector(choosePeizhiClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
//选择区域
-(void)chooseAddressClick:(UIButton *)button{
    NSString *text=_addressArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"address4"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//选择租金
-(void)choosePeizhiClick:(UIButton *)button{
    NSString *text=_zujinArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:1];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"zujin4"];
    
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
-(void)chooseHuxing{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=_huxingPickerView.pickerString;
    [[NSUserDefaults standardUserDefaults]setObject:_huxingPickerView.pickerString  forKey:@"huxing4"];
    [self datePickerDown];
}
//选择器下降
-(void)datePickerDown{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
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
