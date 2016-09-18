//
//  ZhaoPinCompanyInfoViewController.m
//  temp
//
//  Created by l x on 16/6/1.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ZhaoPinCompanyInfoViewController.h"
#import "ResumeTableViewCell.h"
#import "ChooseViewController.h"
#import "ZhaoPinViewController.h"

@interface ZhaoPinCompanyInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    UIView *_view;
    NSArray *_hangyeArr;
    NSArray *_guimoArr;
    NSMutableArray *_textFieldArr;
    BOOL isHaveDian;
    NSMutableArray *_judgeArr;

}
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ZhaoPinCompanyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNavigationItem];
    [self creatTableView];
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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否离开？" message:@"内容还没提交" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSString*appDomain = [[NSBundle mainBundle]bundleIdentifier];
        [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
        [otherSelf.navigationController popViewControllerAnimated:YES];
        
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
    self.title=@"填写公司信息";
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
//    [chooseButton addTarget:self action:@selector(fullTimeButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [chooseButton setBackgroundColor:BJCOLOR];
//    chooseButton.layer.cornerRadius=5;
//    chooseButton.layer.masksToBounds=YES;
//    [chooseButton setTitle:@"确认发布" forState:UIControlStateNormal];
//    [_view addSubview:chooseButton];
//    
//}
//确认发布按钮
-(void)resumeButtonClick{
    NSString *gongsiname;
    NSString *shisufuli;
    NSString *guimo;
    NSString *shehuifuli;
    NSString *qitamiaoshu;
    NSString *gongsijianjie;
    NSUserDefaults *UDF =[NSUserDefaults standardUserDefaults];

    if ([UDF objectForKey:@"gongsimingcheng"]) {
        gongsiname=[UDF objectForKey:@"gongsimingcheng"];
    }else{
        gongsiname=@"";
    }
    if ([UDF objectForKey:@"hangye"]) {
        shisufuli=[UDF objectForKey:@"hangye"];
    }else{
        shisufuli=@"";
    }
    if ([UDF objectForKey:@"guimo"]) {
        guimo=[UDF objectForKey:@"guimo"];
    }else{
        guimo=@"";
    }
    if ([UDF objectForKey:@"fuli"]) {
        shehuifuli=[UDF objectForKey:@"fuli"];
    }else{
        shehuifuli=@"";
    }
    if ([UDF objectForKey:@"xiangxidizhi"]) {
        qitamiaoshu=[UDF objectForKey:@"xiangxidizhi"];
    }else{
        qitamiaoshu=@"";
    }
    if ([UDF objectForKey:@"gongsijianjie"]) {
        gongsijianjie=[UDF objectForKey:@"gongsijianjie"];
    }else{
        gongsijianjie=@"";
    }
    _judgeArr=[NSMutableArray array];
    for (UITextField *field in _textFieldArr) {
        NSLog(@"%@",_textFieldArr);
        if (field.text.length<=0) {
            [_judgeArr addObject:field];
        }
    }
    if (_judgeArr.count==0) {
        if ([CheckText nameWithObject:_lianxiren]==YES&&[CheckText phoneWithObject:_phone]==YES) {
            [AFHttpManager sendFullTimeWitharea:self.area withdec_yuexin:self.dec_yuexin withdt_datetime:self.dt_datetime withgongzuodidian:self.gongzuodidian withgongzuonianxian:self.gongzuonianxian withi_zhaopinrenshu:self.i_zhaopinrenshu withlianxiren:self.lianxiren withnianlingduan:self.nianlingduan withphone:self.phone withtitle:self.jobtitle withxueli:self.xueli withzhiweimiaoshu:self.zhiweimiaoshu withzhiwei:self.zhiwei withgongsiname:gongsiname withshisufuli:shisufuli  withshehuifuli:shehuifuli  withqitafuli:qitamiaoshu  withguimo:guimo  withgongsijianjie:gongsijianjie withType:^(NSString *string) {
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

    NSString*appDomain = [[NSBundle mainBundle]bundleIdentifier];
    [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];

    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[ZhaoPinViewController class]]) {
            [self.navigationController popToViewController:temp animated: YES];
        }
    }
}
-(void)textFieldDidChang:(UITextField *)textField{
    if (textField.tag==13) {
        if (textField.text.length > 30) {
            SHOW_MESSAGE(@"亲，输入超出长度范围");
            textField.text = [textField.text substringToIndex:30];
        }
    }else if (textField.tag==12) {
        if (textField.text.length > 40) {
            textField.text = [textField.text substringToIndex:40];
            SHOW_MESSAGE(@"亲，输入超出长度范围");
        }
    }else if (textField.tag==14) {
        if (textField.text.length > 800) {
            textField.text = [textField.text substringToIndex:800];
            SHOW_MESSAGE(@"亲，输入超出长度范围");
        }
    }else{
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1) {
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
    if (indexPath.section==2&&indexPath.row==1) {
        return 80;
    }else{
        return 40;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *section0ListArr=@[@"公司名称"];
    NSArray *section0PlaceholderArr=@[@"2-30字，不能包含职位信息"];
    NSArray *section1ListArr=@[@"行       业",@"规       模",@"福       利"];
    NSArray *section1PlaceholderArr=@[@"请选择",@"请选择",@"请先写公司提供福利待遇"];
    NSArray *section2ListArr=@[@"详细地址",@"公司简介"];
    NSArray *section2PlaceholderArr=@[@"不能填写职位信息",@"20-800字不能填写职位信息"];

    //NSArray *leixingArr=@[@"民营",@"外商独资",@"国企",@"合资",@"股份制企业",@"上市公司",@"代表处",@"国家机关",@"事业单位",@"其他"];
    
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
    if (indexPath.section==0) {
        cell.nameLabel.text=section0ListArr[indexPath.row];
        cell.detailTextField.placeholder=section0PlaceholderArr[indexPath.row];
        cell.detailTextField.text=[self writeWithKey:@"gongsimingcheng"];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveCompanyName:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
        cell.detailTextField.tag=13;
    }else if (indexPath.section==1) {
        cell.nameLabel.text=section1ListArr[indexPath.row];
        cell.detailTextField.placeholder=section1PlaceholderArr[indexPath.row];

        if (indexPath.row==0) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"hangye"];
        }else if (indexPath.row==1) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"guomo"];
        }else{
            cell.detailTextField.text=[self writeWithKey:@"fuli"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveFuli:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
        }
    }else{
        cell.nameLabel.text=section2ListArr[indexPath.row];

        if (indexPath.row==0) {
            cell.detailTextField.placeholder=section2PlaceholderArr[indexPath.row];
            cell.detailTextField.text=[self writeWithKey:@"xiangxidizhi"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savexiangxidizhi:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=12;
        }else{
            cell.detailTextField.placeholder=@"800字以内，不能填写电话号、QQ号和特殊字符";
            cell.detailTextField.text=[self writeWithKey:@"gongsijianjie"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savegongsijianjie:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=14;
        }
    }
    return cell;
}
-(void)saveCompanyName:(NSNotification *)not{
    [self save:@"gongsimingcheng" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveFuli:(NSNotification *)not{
    [self save:@"fuli" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:2 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savexiangxidizhi:(NSNotification *)not{
    [self save:@"xiangxidizhi" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savegongsijianjie:(NSNotification *)not{
    [self save:@"gongsijianjie" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:2];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1&&indexPath.row==0) {
        _hangyeArr=@[@"酒店/餐饮",@"生产/制造",@"计算机/网络/通信",@"美容美发",@"按摩保健",@"媒体/影视/文化",@"超市/百货/零售",@"家政",@"旅游",@"运动健身",@"教育/培训",@"建筑/装修",@"广告/会展",@"贸易/交通/运输/物流",@"其他"];

        ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择行业" textArray:_hangyeArr withKey:@"hangye"];
        [vc.choosButton addTarget:self action:@selector(chooseHangYeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section==1&&indexPath.row==1) {
        _guimoArr=@[@"20人以下",@"20-99人",@"100-499人",@"500-999人",@"1000-9999人",@"10000人以上"];

        ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"公司规模" textArray:_guimoArr withKey:@"guimo"];
        [vc.choosButton addTarget:self action:@selector(chooseGuiMoClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController pushViewController:vc animated:YES];
    }

}
//选择行业
-(void)chooseHangYeClick:(UIButton *)button{
    NSString *text=_hangyeArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"hangye"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//选择规模
-(void)chooseGuiMoClick:(UIButton *)button{
    NSString *text=_guimoArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:1];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"guimo"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
