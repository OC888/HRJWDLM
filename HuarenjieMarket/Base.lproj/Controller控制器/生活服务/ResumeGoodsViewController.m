//
//  ResumeGoodsViewController.m
//  temp
//
//  Created by l x on 16/5/22.
//  Copyright © 2016年 wangli. All rights reserved.
//
#import "ResumeTableViewCell.h"
#import "PickerView.h"
#import "ChooseViewController.h"

#import "ResumeGoodsViewController.h"

@interface ResumeGoodsViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *_imageButtonArr;
    NSArray *_placeArr;
    NSArray *_classArr;
    UIView *_resumView;
    NSMutableArray *_textFieldArr;
    BOOL isHaveDian;
    NSMutableArray *_judgeArr;

}
@property (nonatomic,strong) UITapGestureRecognizer *tap;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) PickerView *pickerView;
@property (nonatomic,strong) UIImagePickerController *imagePiker;

@end

@implementation ResumeGoodsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"goodsNeede"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"goodsTitle"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"goodsPrice"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"goodsDescribe"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"goodsPerson"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"goodsPhone"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"goodsAddress"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"goodsWhere"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"goodsClass"];
        [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/goodsImage.plist"] error:nil];
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
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-30, WIDTH, 30)];
    tableView.tableFooterView=view;
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:tableView];
    _tableView=tableView;
}
-(void)resumeButtonClick{
    NSString *dec_jiage;
    NSString *dt_datetime;
    NSString *fenlei;
    NSString *gongxu;
    NSString *laiyuan;
    NSString *lianxiren;
    NSString *miaoshu;
    NSString *phone;
    NSString *quyu;
    NSString *title;

    NSDate *currentDate =[NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *fabutime=[formatter stringFromDate:currentDate];
    dt_datetime=fabutime;
    NSUserDefaults *UDF =[NSUserDefaults standardUserDefaults];

    if ([UDF objectForKey:@"goodsNeede"]) {
        gongxu=[UDF objectForKey:@"goodsNeede"];
    }else{
        gongxu=@"";
    }
    if ([UDF objectForKey:@"goodsTitle"]) {
        title=[UDF objectForKey:@"goodsTitle"];
    }else{
        title=@"";
    }
    if ([UDF objectForKey:@"goodsPrice"]) {
        dec_jiage=[UDF objectForKey:@"goodsPrice"];
    }else{
        dec_jiage=@"";
    }
    if ([UDF objectForKey:@"goodsDescribe"]) {
        miaoshu=[UDF objectForKey:@"goodsDescribe"];
    }else{
        miaoshu=@"";
    }
    if ([UDF objectForKey:@"goodsPerson"]) {
        lianxiren=[UDF objectForKey:@"goodsPerson"];
    }else{
        lianxiren=@"";
    }
    if ([UDF objectForKey:@"goodsPhone"]) {
        phone=[UDF objectForKey:@"goodsPhone"];
    }else{
        phone=@"";
    }
    if ([UDF objectForKey:@"goodsAddress"]) {
        quyu=[UDF objectForKey:@"goodsAddress"];
    }else{
        quyu=@"";
    }
    if ([UDF objectForKey:@"goodsWhere"]) {
        laiyuan=[UDF objectForKey:@"goodsWhere"];
    }else{
        laiyuan=@"";
    }
    if ([UDF objectForKey:@"goodsClass"]) {
        fenlei=[UDF objectForKey:@"goodsClass"];
    }else{
        fenlei=@"";
    }
    
    NSArray *imageArr;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/goodsImage.plist"]]) {
        imageArr=[NSArray arrayWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/goodsImage.plist"]];
    }
    NSData *data1;
    NSData *data2;
    NSData *data3;
    NSData *data4;
    NSData *data5;
    NSData *data6;
    NSData *data7;
    UIImage *image =[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"tu" ofType:@"png"]];
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
            [AFHttpManager sendErShouGoodsWithdec_jiage:dec_jiage withdt_datetime:dt_datetime withfenlei:fenlei withgongxu:gongxu withimagedata1:data1 withimagedata2:data2 withimagedata3:data3 withimagedata4:data4 withimagedata5:data5 withimagedata6:data6 withimagedata7:data7 withlaiyuan:laiyuan withlianxiren:lianxiren withmiaoshu:miaoshu withphone:phone withquyu:quyu withtitle:title withType:^(NSString *string) {
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
            SHOW_MESSAGE(@"超出长度范围");
        }
    }else if (textField.tag==4) {
        if (textField.text.length > 800) {
            textField.text = [textField.text substringToIndex:800];
            SHOW_MESSAGE(@"超出长度范围");
        }
    }else if (textField.tag==7) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
            SHOW_MESSAGE(@"超出长度范围");
        }
    }else{
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag==7) {
        
        NSCharacterSet*cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest) {
            
            return NO;
        }
        return YES;
    }else{
        return YES;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0||section==1||section==4||section==5) {
        return 1;
    }else  {
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
    }else if (indexPath.section==2&&indexPath.row==2) {
        return 60;
    }
    else{
        return 40;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *section1ListArr=@[@"供       需"];
    NSArray *section2ListArr=@[@"标       题",@"价       格",@"描       述（选填）"];
    NSArray *section2PlaceholderArr=@[@"6-30字，建议填写商品品牌和名称",@"数字填写，不能为负",@"10-800字，介绍一下具体情况"];
    NSArray *section3ListArr=@[@"联  系  人",@"联系电话",@"选择区域"];
    NSArray *section3PlaceholderArr=@[@"2-4字，只能填写汉字或字母",@"",@"请选择"];
    NSArray *section4ListArr=@[@"来       源"];
    NSArray *section5ListArr=@[@"分       类"];
    NSArray *section5PlaceholderArr=@[@"请选择"];

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
                if ([[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/goodsImage.plist"]]) {
                    NSArray *arr=[NSArray arrayWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/goodsImage.plist"]];
                    if (button.tag<arr.count+2) {
                        [button setBackgroundImage:[UIImage imageWithData:arr[button.tag-2]] forState:UIControlStateNormal];
                    }
                }
            }
        }
    }else if (indexPath.section==1) {
        UISegmentedControl *seg =[[UISegmentedControl alloc]initWithItems:@[@"转让",@"求购"]];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"goodsNeede"] isEqualToString:@"求购"]) {
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
        cell.nameLabel.text=section1ListArr[indexPath.row];
    }else if (indexPath.section==2) {
        cell.nameLabel.text=section2ListArr[indexPath.row];
        cell.detailTextField.placeholder=section2PlaceholderArr[indexPath.row];
        
        if (indexPath.row==0) {
            cell.detailTextField.text=[self writeWithKey:@"goodsTitle"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savetitle:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=5;
        }else if (indexPath.row==1){
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/5*4, 10, WIDTH/5-10, 20)];
            label.textColor=BJCOLOR;
            [cell addSubview:label];
            label.text=@"元";
            label.textAlignment=NSTextAlignmentRight;
            label.font=[UIFont systemFontOfSize:14.0];
            cell.detailTextField.keyboardType=UIKeyboardTypeNumberPad;
            cell.detailTextField.text=[self writeWithKey:@"goodsPrice"];
            cell.detailTextField.tag=7;
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePrice:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
        }else{
            CGSize rect =[cell.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
            cell.nameLabel.frame=CGRectMake(cell.nameLabel.frame.origin.x, cell.nameLabel.frame.origin.y, cell.nameLabel.frame.size.width, rect.height+20);
            cell.nameLabel.numberOfLines=0;
            cell.nameLabel.lineBreakMode=NSLineBreakByWordWrapping;
            
            cell.detailTextField.text=[self writeWithKey:@"goodsDescribe"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveDescribe:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
        }
    }else if (indexPath.section==3) {
        cell.nameLabel.text=section3ListArr[indexPath.row];
        cell.detailTextField.placeholder=section3PlaceholderArr[indexPath.row];
        if (indexPath.row==0) {
            cell.detailTextField.text=[self writeWithKey:@"goodsPerson"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePerson:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=1;
        }else if (indexPath.row==1) {
            cell.detailTextField.keyboardType=UIKeyboardTypeNumberPad;
            cell.detailTextField.text=[self writeWithKey:@"goodsPhone"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePhone:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=2;
        }else {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"goodsAddress"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveAddress:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            
        }
    }else if (indexPath.section==4) {
        UISegmentedControl *seg =[[UISegmentedControl alloc]initWithItems:@[@"个人",@"商家"]];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"goodsWhere"] isEqualToString:@"商家"]) {
            seg.selectedSegmentIndex=1;
        }else{
            seg.selectedSegmentIndex=0;
        }
        seg.frame=CGRectMake(WIDTH/3-10, 10, WIDTH/3*2-10, 20);
        [seg addTarget:self action:@selector(changeWhere:) forControlEvents:UIControlEventValueChanged];
        seg.tintColor=BJCOLOR;
        [cell addSubview:seg];
        cell.detailTextField.text=@"123";
        cell.detailTextField.textColor=[UIColor clearColor];
        cell.detailTextField.enabled=NO;
        cell.nameLabel.text=section4ListArr[indexPath.row];
        
    }else{
        cell.nameLabel.text=section5ListArr[indexPath.row];
        cell.detailTextField.placeholder=section5PlaceholderArr[indexPath.row];

        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextField.enabled=NO;
        cell.detailTextField.text=[self writeWithKey:@"goodsClass"];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveGoodsClass:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
    }
    return cell;
}
//供需
-(void)changeNeede:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"转让" forKey:@"goodsNeede"];
        }
            break;
        case 1:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"求购" forKey:@"goodsNeede"];
        }
            break;
        default:
            break;
    }
}
//来源
-(void)changeWhere:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"个人" forKey:@"goodsWhere"];
        }
            break;
        case 1:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"商家" forKey:@"goodsWhere"];
        }
            break;
        default:
            break;
    }
}

-(NSString *)writeWithKey:(NSString *)str{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@",str]]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@",str]];
    }else{
        return @"";
    }
}

-(void)savetitle:(NSNotification *)not{
    [self save:@"goodsTitle" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePrice:(NSNotification *)not{
    [self save:@"goodsPrice" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveDescribe:(NSNotification *)not{
    [self save:@"goodsDescribe" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:2 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePerson:(NSNotification *)not{
    [self save:@"goodsPerson" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:3];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePhone:(NSNotification *)not{
    [self save:@"goodsPhone" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:3];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveAddress:(NSNotification *)not{
    [self save:@"goodsAddress" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:2 inSection:3];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveGoodsClass:(NSNotification *)not{
    [self save:@"goodsClass" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:5];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)save:(NSString *)str withNot:(NSNotification*)not{
    UITextField *textField =(UITextField*)[not object];
    [[NSUserDefaults standardUserDefaults]setObject:textField.text  forKey:[NSString stringWithFormat:@"%@",str]];
}

//照片
-(void)headerImageButtonClick:(UIButton *)button{
    __weak typeof(self) otherSelf = self;
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
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image =[info objectForKey:UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    picker.delegate=nil;
    [_imageArr addObject:imageData];
    [_imageArr writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/goodsImage.plist"] atomically:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
//点击cell触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    if (indexPath.section==3) {
        if (indexPath.row==2) {
            _placeArr=@[@"二七区",@"中原区",@"回族管城区",@"惠济区",@"金水区",@"上街区",@"巩义市",@"新密市",@"新郑市",@"登封市",@"荥阳市",@"中牟县",@"经济技术开发区",@"高新技术开发区"];
            ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择品牌" textArray:_placeArr withKey:@"goodsAddress"];
            [vc.choosButton addTarget:self action:@selector(chooseAdressClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section==5) {
        _classArr=@[@"手机/配件",@"笔记本",@"平板电脑",@"电脑/配件",@"摩托车",@"自行车",@"母婴儿童",@"家具",@"闲置礼品",@"家居百货"];
        ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择分类" textArray:_classArr withKey:@"goodsClass"];
        [vc.choosButton addTarget:self action:@selector(chooseClassClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//选择区域
-(void)chooseAdressClick:(UIButton *)button{
    NSString *text=_placeArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:3];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"goodsAddress"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//选择分类
-(void)chooseClassClick:(UIButton *)button{
    NSString *text=_classArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:5];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:@"goodsClass"];
    
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
