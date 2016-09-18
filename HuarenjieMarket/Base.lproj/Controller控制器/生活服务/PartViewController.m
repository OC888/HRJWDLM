//
//  PartViewController.m
//  temp
//
//  Created by l x on 16/6/3.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "PartViewController.h"
#import "ResumeTableViewCell.h"
#import "ChooseViewController.h"
#import "AgePicker.h"
#import "ZhaoPinCompanyInfoViewController.h"
#import "ChooseShiJianViewController.h"
#import "PartNeedeViewController.h"

@interface PartViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    UILabel *_placeholderLabel;
    NSArray *_workTimeArr;
    NSArray *_moneyArr;
    NSArray *_schoolArr;
    NSArray *_workPlaceArr;
    NSArray *_workShiJianArr;
    UIView *_view;
    UITextField *_field;
    NSMutableArray *_tagArr;
    NSMutableArray *_textFieldArr;
    BOOL isHaveDian;
    NSMutableArray *_judgeArr;
}
@property (nonatomic,strong) AgePicker *pickerView;
@property (nonatomic,strong) UITapGestureRecognizer *tap;
@property (nonatomic,copy) NSMutableArray *tagArr;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation PartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNavigationItem];
    [self creatTableView];
    [self creatPickerView];

    self.title=_zhiwei;
    _tagArr=[NSMutableArray array];
    _textFieldArr=[NSMutableArray array];

}
//创建导航栏按钮
-(void)creatNavigationItem{
    
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
//    _view =[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-50, WIDTH, 50)];
//    _view.layer.borderWidth=0.5;
//    _view.layer.borderColor=[UIColor blackColor].CGColor;
//    _view.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:_view];
//    UIButton *chooseButton =[[UIButton alloc]initWithFrame:CGRectMake(WIDTH/4, 10, WIDTH/2, 30)];
//    [chooseButton addTarget:self action:@selector(partTimeButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [chooseButton setBackgroundColor:BJCOLOR];
//    chooseButton.layer.cornerRadius=5;
//    chooseButton.layer.masksToBounds=YES;
//    [chooseButton setTitle:@"下一步" forState:UIControlStateNormal];
//    [_view addSubview:chooseButton];
//}
-(void)resumeButtonClick{
    NSUserDefaults *UDF =[NSUserDefaults standardUserDefaults];
    NSString *area;
    NSString *dec_yuexin;
    NSString *dt_datetime;
    NSString *gongzuodidian;
    NSString *gongzuonianxian;
    NSString *i_zhaopinrenshu;
    NSString *lianxiren;
    NSString *nianlingduan;
    NSString *phone;
    NSString *title;
    NSString *xueli;
    NSString *zhiweimiaoshu;
    NSString *gongzuoshijian;
    
    if ([UDF objectForKey:@"workshijian"]) {
        gongzuoshijian=[UDF objectForKey:@"workshijian"];
    }else{
        gongzuoshijian=@"";
    }
    if ([UDF objectForKey:@"jobTitle"]) {
        title=[UDF objectForKey:@"jobTitle"];
    }else{
        title=@"";
    }
    if ([UDF objectForKey:@"worktime"]) {
        gongzuonianxian=[UDF objectForKey:@"worktime"];
    }else{
        gongzuonianxian=@"";
    }
    if ([UDF objectForKey:@"workmoney"]) {
        dec_yuexin=[UDF objectForKey:@"workmoney"];
    }else{
        dec_yuexin=@"";
    }
    if ([UDF objectForKey:@"school"]) {
        xueli=[UDF objectForKey:@"school"];
    }else{
        xueli=@"";
    }
    if ([UDF objectForKey:@"number"]) {
        i_zhaopinrenshu=[UDF objectForKey:@"number"];
    }else{
        i_zhaopinrenshu=@"";
    }
    if ([UDF objectForKey:@"age"]) {
        nianlingduan=[UDF objectForKey:@"age"];
    }else{
        nianlingduan=@"";
    }
    if ([UDF objectForKey:@"workplace"]) {
        area=[UDF objectForKey:@"workplace"];
    }else{
        area=@"";
    }
    if ([UDF objectForKey:@"workaddress"]) {
        gongzuodidian=[UDF objectForKey:@"workaddress"];
    }else{
        gongzuodidian=@"";
    }
    if ([UDF objectForKey:@"workdescribe"]) {
        zhiweimiaoshu=[UDF objectForKey:@"workdescribe"];
    }else{
        zhiweimiaoshu=@"";
    }
    if ([UDF objectForKey:@"workperson"]) {
        lianxiren=[UDF objectForKey:@"workperson"];
    }else{
        lianxiren=@"";
    }
    if ([UDF objectForKey:@"workphone"]) {
        phone=[UDF objectForKey:@"workphone"];
    }else{
        phone=@"";
    }
    
    NSDate *currentDate =[NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *fabutime=[formatter stringFromDate:currentDate];
    dt_datetime=fabutime;
    PartNeedeViewController *vc =[[PartNeedeViewController alloc]init];
    vc.area = area;
    vc.dec_yuexin = dec_yuexin;
    vc.dt_datetime = dt_datetime;
    vc.gongzuodidian = gongzuodidian;
    vc.gongzuonianxian = gongzuonianxian;
    vc.i_zhaopinrenshu = i_zhaopinrenshu;
    vc.lianxiren = lianxiren;
    vc.nianlingduan = nianlingduan;
    vc.phone = phone;
    vc.jobtitle = title;
    vc.xueli = xueli;
    vc.zhiweimiaoshu = zhiweimiaoshu;
    vc.zhiwei=self.title;
    vc.gongzuoshijian=gongzuoshijian;
    
    _judgeArr=[NSMutableArray array];
    for (UITextField *field in _textFieldArr) {
        NSLog(@"%@",_textFieldArr);
        if (field.text.length<=0) {
            [_judgeArr addObject:field];
        }
    }
    if (_judgeArr.count==0) {
        if ([CheckText nameWithObject:lianxiren]==YES&&[CheckText phoneWithObject:phone]==YES) {
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            SHOW_ALERT(@"亲，信息格式填写错误");
        }
    }else{
        SHOW_ALERT(@"亲，信息填写不完整");
    }
    NSString*appDomain = [[NSBundle mainBundle]bundleIdentifier];
    [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
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
        if (textField.text.length > 20) {
            SHOW_MESSAGE(@"亲，输入超出长度范围");
            textField.text = [textField.text substringToIndex:20];
        }
    }else if (textField.tag==4) {
        if (textField.text.length > 800) {
            textField.text = [textField.text substringToIndex:800];
            SHOW_MESSAGE(@"亲，输入超出长度范围");
        }
    }else if (textField.tag==11) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
            SHOW_MESSAGE(@"亲，输入超出长度范围");
        }
    }else if (textField.tag==12) {
        if (textField.text.length > 40) {
            textField.text = [textField.text substringToIndex:40];
            SHOW_MESSAGE(@"亲，输入超出长度范围");
        }
    }else{
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0||section==4) {
        return 1;
    }else if (section==1||section==3) {
        return 3;
    }else  {
        return 2;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 9;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==4) {
        return 80;
    }else{
        return 40;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *section0ListArr=@[@"标       题"];
    NSArray *section0PlaceholderArr=@[@"4-18字，不能包含电话或特殊字符"];
    NSArray *section1ListArr=@[@"工作年限",@"薪       资",@"学       历"];
    NSArray *section1PlaceholderArr=@[@"不限",@"只能填写数字",@"不限"];
    NSArray *section2ListArr=@[@"招聘人数",@"年龄段"];
    NSArray *section2PlaceholderArr=@[@"数字填写，不能是0和负数",@"不限"];
    NSArray *section3ListArr=@[@"工作区域",@"工作地点",@"工作时间"];
    NSArray *section3PlaceholderArr=@[@"请选择",@"7-40字的详细地址",@"请选择"];
    NSArray *section4ListArr=@[@"职位描述"];
    NSArray *section4PlaceholderArr=@[@"800字以内，不能填写电话号、QQ号和特殊字符"];
    NSArray *section5ListArr=@[@"联  系  人",@"联系电话"];
    NSArray *section5PlaceholderArr=@[@"2-6字，汉字或字母",@"11位手机号码"];
    
    static NSString *cellID=@"cell";
    
    ResumeTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[ResumeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.detailTextField.delegate=self;
    [cell.detailTextField addTarget:self action:@selector(textFieldDidChang:) forControlEvents:UIControlEventEditingChanged];
    [_textFieldArr addObject:cell.detailTextField];
    cell.detailTextField.indexpath=indexPath;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.nameLabel.numberOfLines=0;
    if (indexPath.section==0) {
        cell.nameLabel.text=section0ListArr[indexPath.row];
        cell.detailTextField.placeholder=section0PlaceholderArr[indexPath.row];
        cell.detailTextField.text=[self writeWithKey:@"jobTitle"];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveTitle:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
        
    }
    else if (indexPath.section==1) {
        cell.nameLabel.text=section1ListArr[indexPath.row];
        if (indexPath.row==0) {
            cell.detailTextField.text=section1PlaceholderArr[indexPath.row];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"worktime"]) {
                cell.detailTextField.text=section1PlaceholderArr[indexPath.row];
            }else{
                cell.detailTextField.text=[self writeWithKey:@"worktime"];
            }
            
        }else if (indexPath.row==1) {

            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"workmoney"]) {
                cell.detailTextField.placeholder=section1PlaceholderArr[indexPath.row];
                UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/5*4, 10, WIDTH/5-10, 20)];
                label.textColor=BJCOLOR;
                [cell addSubview:label];
                label.text=@"元/天";
                label.textAlignment=NSTextAlignmentRight;
                label.font=[UIFont systemFontOfSize:14.0];
                [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveMoney:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
                
            }else{
                
                cell.detailTextField.text=[self writeWithKey:@"workmoney"];
            }
        }else {
            cell.detailTextField.text=section1PlaceholderArr[indexPath.row];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;

            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"school"]) {
                cell.detailTextField.text=section1PlaceholderArr[indexPath.row];
            }else{
                cell.detailTextField.text=[self writeWithKey:@"school"];
            }
        }
    }else if (indexPath.section==2){
        cell.nameLabel.text=section2ListArr[indexPath.row];
        if (indexPath.row==0) {
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/5*4, 10, WIDTH/5-10, 20)];
            label.textColor=BJCOLOR;
            [cell addSubview:label];
            label.text=@"人";
            label.textAlignment=NSTextAlignmentRight;
            label.font=[UIFont systemFontOfSize:14.0];
            cell.detailTextField.placeholder=section2PlaceholderArr[indexPath.row];
            cell.detailTextField.text=[self writeWithKey:@"number"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveNumber:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            
        }else {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.text=section2PlaceholderArr[indexPath.row];
            cell.detailTextField.enabled=NO;
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"age"]) {
                cell.detailTextField.text=section2PlaceholderArr[indexPath.row];
            }else{
                cell.detailTextField.text=[self writeWithKey:@"age"];
            }
        }
    }else if (indexPath.section==3) {
        cell.nameLabel.text=section3ListArr[indexPath.row];
        cell.detailTextField.placeholder=section3PlaceholderArr[indexPath.row];
        if (indexPath.row==0) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"workplace"];
        }else if(indexPath.row==1){
            cell.detailTextField.text=[self writeWithKey:@"workaddress"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveAddress:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
        }else{
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.font=[UIFont systemFontOfSize:12.0];
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"workshijian"];
        }
    }else if (indexPath.section==4) {
        cell.nameLabel.text=section4ListArr[indexPath.row];
        cell.detailTextField.placeholder=section4PlaceholderArr[indexPath.row];
        cell.detailTextField.text=[self writeWithKey:@"workdescribe"];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveWorkDescribe:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
        
    }else{
        cell.nameLabel.text=section5ListArr[indexPath.row];
        cell.detailTextField.placeholder=section5PlaceholderArr[indexPath.row];
        if (indexPath.row==0) {
            cell.detailTextField.text=[self writeWithKey:@"workperson"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePerson:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
        }else {
            cell.detailTextField.text=[self writeWithKey:@"workphone"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePhone:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
        }
    }
    return cell;
}
//textField结束编辑
-(void)saveTitle:(NSNotification *)not{
    [self save:@"jobTitle" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveMoney:(NSNotification *)not{
    [self save:@"workmoney" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveNumber:(NSNotification *)not{
    [self save:@"number" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveAddress:(NSNotification *)not{
    [self save:@"workaddress" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:3];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveWorkDescribe:(NSNotification *)not{
    [self save:@"workdescribe" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:4];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePerson:(NSNotification *)not{
    [self save:@"workperson" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:5];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePhone:(NSNotification *)not{
    [self save:@"workphone" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:5];
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
//点击cell触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            _workTimeArr=@[@"不限",@"1年以内",@"1~2年",@"2~3年",@"3~5年",@"5~8年",@"8~10年",@"10年以上"];
            ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"工作年限" textArray:_workTimeArr withKey:@"worktime"];
            [vc.choosButton addTarget:self action:@selector(chooseWorkTimeClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==2){
            _schoolArr=@[@"初中及以下",@"高中",@"中专/技校",@"大专",@"本科",@"硕士及以上"];
            ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"学      历" textArray:_schoolArr withKey:@"school"];
            [vc.choosButton addTarget:self action:@selector(chooseSchoolClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
    if (indexPath.section==2){
        if (indexPath.row==1) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            _pickerView.frame=CGRectMake(0, HEIGHT/5*2, WIDTH, HEIGHT/5*3);
            [UIView commitAnimations];
            _tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(datePickerDown)];
            [self.view addGestureRecognizer:_tap];
            _view.hidden=YES;
        }
    }
    if (indexPath.section==3) {
        if (indexPath.row==0) {
            _workPlaceArr=@[@"二七区",@"中原区",@"回族管城区",@"惠济区",@"金水区",@"上街区",@"巩义市",@"新密市",@"新郑市",@"登封市",@"荥阳市",@"中牟县",@"经济技术开发区",@"高新技术开发区"];
            ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择工作区域" textArray:_workPlaceArr withKey:@"workplace"];
            [vc.choosButton addTarget:self action:@selector(chooseWorkPlaceClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==2) {
            _workShiJianArr=@[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日",@"周一至周日"];
             ChooseShiJianViewController*vc=[[ChooseShiJianViewController alloc]initWithTile:@"选择工作时间" textArray:_workShiJianArr withKey:@"workshijian"];
            [vc.choosButton addTarget:self action:@selector(chooseWorkShijianClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
//选择工作时间
-(void)chooseWorkShijianClick:(BoolButton *)button{
    _tagArr=button.tagArr;
    NSString *string;
    NSString *text=@"";
    if (button.tag==8) {
        text=_workShiJianArr[button.tag-1];
    }else{
        for (NSNumber *number in _tagArr) {
            int i =[number intValue];
            string=_workShiJianArr[i-1];
            text=[text stringByAppendingString:string];
        }
    }
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:3];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"workshijian"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//选择学历
-(void)chooseSchoolClick:(UIButton *)button{
    NSString *text=_schoolArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:1];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"school"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//选择工作年限
-(void)chooseWorkTimeClick:(UIButton *)button{
    NSString *text=_workTimeArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"worktime"];
    
    [self.navigationController popViewControllerAnimated:YES];
}
//选择工作区域
-(void)chooseWorkPlaceClick:(UIButton *)button{
    NSString *text=_workPlaceArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:3];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"workplace"];
    [self.navigationController popViewControllerAnimated:YES];
}

//创建选择器
-(void)creatPickerView{
    _pickerView =[[AgePicker alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, HEIGHT/5*3)];
    NSArray *arr=@[@"不限",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",@"60",@"61",@"62",@"63",@"64",@"65",@"66",@"67",@"68",@"69",@"70",@"71",@"72",@"73",@"74",@"75",@"76",@"77",@"78",@"79",@"80",@"81",@"82",@"83",@"84",@"85",@"86",@"87",@"88",@"89",@"90",@"91",@"92",@"93",@"94",@"95",@"96",@"97",@"98",@"99"];
    _pickerView.arr1=arr;
    _pickerView.arr2=arr;
    _pickerView.component=2;
    _pickerView.row=_pickerView.arr1.count;
    _pickerView.titleLabel.text=@"年龄段";
    [_pickerView.button addTarget:self action:@selector(chooseAge) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pickerView];
}
//选择年龄段
-(void)chooseAge{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:2];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=_pickerView.pickerString;
    [[NSUserDefaults standardUserDefaults]setObject:_pickerView.pickerString  forKey:@"age"];
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
//-(void)textViewDidChange:(UITextView *)textView
//{
//    NSString *string = _textView.text;
//    if (string.length == 0) {
//        _placeholderLabel.text = @"800字以内，不能填写电话号、QQ号和特殊字符";
//    }else{
//        _placeholderLabel.text = @"";
//    }
//}

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
