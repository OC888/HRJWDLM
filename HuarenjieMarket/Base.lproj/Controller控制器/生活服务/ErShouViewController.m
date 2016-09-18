//
//  ErShouViewController.m
//  temp
//
//  Created by l x on 16/5/20.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "ErShouViewController.h"
#import "ResumeTableViewCell.h"
#import "PickerView.h"
#import "ChooseViewController.h"

@interface ErShouViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *_imageButtonArr;
    NSArray *_placeArr;
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

@implementation ErShouViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNavigationItem];
    [self creatTableView];
    
    _imageArr=[NSMutableArray array];
    _textFieldArr=[NSMutableArray array];
}
//创建导航栏按钮
-(void)creatNavigationItem{
    self.title=@"填写信息";
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
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:[NSString stringWithFormat:@"title%@",_indentifyID]];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:[NSString stringWithFormat:@"price%@",_indentifyID]];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:[NSString stringWithFormat:@"describe%@",_indentifyID]];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:[NSString stringWithFormat:@"person%@",_indentifyID]];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:[NSString stringWithFormat:@"phone%@",_indentifyID]];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:[NSString stringWithFormat:@"address%@",_indentifyID]];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:[NSString stringWithFormat:@"neede%@",_indentifyID]];
        [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/carImage%@.plist",_indentifyID]] error:nil];
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
-(void)resumeButtonClick{
    NSUserDefaults *UDF =[NSUserDefaults standardUserDefaults];
    NSString *zhonglei=[NSString stringWithFormat:@"%@",_indentifyID];
    NSString *biaoti;
    NSString *gongxubiaozhi;
    NSString *lianxiren;
    NSString *miaoshu;
    NSString *phone;
    NSString *price;
    NSString *quyu;
    if ([UDF objectForKey:[NSString stringWithFormat:@"title%@",_indentifyID]]) {
        biaoti=[UDF objectForKey:[NSString stringWithFormat:@"title%@",_indentifyID]];
    }else{
        biaoti=@"";
    }
    if ([UDF objectForKey:[NSString stringWithFormat:@"neede%@",_indentifyID]]) {
        gongxubiaozhi=[UDF objectForKey:[NSString stringWithFormat:@"neede%@",_indentifyID]];
    }else{
        gongxubiaozhi=@"";
    }
    if ([UDF objectForKey:[NSString stringWithFormat:@"person%@",_indentifyID]]) {
        lianxiren=[UDF objectForKey:[NSString stringWithFormat:@"person%@",_indentifyID]];
    }else{
        lianxiren=@"";
    }
    if ([UDF objectForKey:[NSString stringWithFormat:@"describe%@",_indentifyID]]) {
        miaoshu=[UDF objectForKey:[NSString stringWithFormat:@"describe%@",_indentifyID]];
    }else{
        miaoshu=@"";
    }
    if ([UDF objectForKey:[NSString stringWithFormat:@"phone%@",_indentifyID]]) {
        phone=[UDF objectForKey:[NSString stringWithFormat:@"phone%@",_indentifyID]];
    }else{
        phone=@"";
    }
    if ([UDF objectForKey:[NSString stringWithFormat:@"price%@",_indentifyID]]) {
        price=[UDF objectForKey:[NSString stringWithFormat:@"price%@",_indentifyID]];
    }else{
        price=@"";
    }
    if ([UDF objectForKey:[NSString stringWithFormat:@"address%@",_indentifyID]]) {
        quyu=[UDF objectForKey:[NSString stringWithFormat:@"address%@",_indentifyID]];
    }else{
        quyu=@"";
    }
    NSArray *imageArr;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/carImage%@.plist",_indentifyID]]]) {
        imageArr=[NSArray arrayWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/carImage%@.plist",_indentifyID]]];
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
            [AFHttpManager sendBikeResumeWithbiaoti:biaoti withgongxubiaozhi:gongxubiaozhi withimage1:data1 withimage2:data2 withimage3:data3 withimage4:data4 withimage5:data5 withimage6:data6 withimage7:data7 withlianxiren:lianxiren withmiaoshu:miaoshu withphone:phone withprice:price withquyu:quyu withzhonglei:zhonglei withType:^(NSString *string) {
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
    }else if (textField.tag==7) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
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
    if (textField.tag==7||textField.tag==2) {
        
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
    if (section==0||section==3) {
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
    }else if (indexPath.section==1&&indexPath.row==2) {
        return 60;
    }
    else{
        return 40;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *section1ListArr=@[@"标       题",@"价       格",@"描       述（选填）"];
    NSArray *section1PlaceholderArr=@[@"6-30字，不能填写电话",@"6位以内的整数",@"不能填写电话"];
    NSArray *section2ListArr=@[@"联  系  人",@"联系电话",@"选择区域"];
    NSArray *section2PlaceholderArr=@[@"2-4字，只能填写汉字或字母",@"",@"请选择"];
    NSArray *section3ListArr=@[@"供       需"];
    
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
                if ([[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/carImage%@.plist",_indentifyID]]]) {
                    NSMutableArray *arr=[NSMutableArray arrayWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/carImage%@.plist",_indentifyID]]];
                    if (button.tag<arr.count+2) {
                        [button setBackgroundImage:[UIImage imageWithData:arr[button.tag-2]] forState:UIControlStateNormal];
                    }else{
                        
                    }
                }
            }
        }
    }else if (indexPath.section==1) {
        cell.nameLabel.text=section1ListArr[indexPath.row];
        cell.detailTextField.placeholder=section1PlaceholderArr[indexPath.row];
        
        if (indexPath.row==0) {
            cell.detailTextField.text=[self writeWithKey:@"title"];
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
            cell.detailTextField.text=[self writeWithKey:@"price"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePrice:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=7;
        }else{
            CGSize rect =[cell.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
            cell.nameLabel.frame=CGRectMake(cell.nameLabel.frame.origin.x, cell.nameLabel.frame.origin.y, cell.nameLabel.frame.size.width, rect.height+20);
            cell.nameLabel.numberOfLines=0;
            cell.nameLabel.lineBreakMode=NSLineBreakByWordWrapping;

            cell.detailTextField.text=[self writeWithKey:@"describe"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveDescribe:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=4;
        }
    }else if (indexPath.section==2) {
        cell.nameLabel.text=section2ListArr[indexPath.row];
        cell.detailTextField.placeholder=section2PlaceholderArr[indexPath.row];
        if (indexPath.row==0) {
            cell.detailTextField.text=[self writeWithKey:@"person"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePerson:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=1;
        }else if (indexPath.row==1) {
            cell.detailTextField.keyboardType=UIKeyboardTypeNumberPad;
            cell.detailTextField.text=[self writeWithKey:@"phone"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(savePhone:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            cell.detailTextField.tag=2;
        }else {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextField.enabled=NO;
            cell.detailTextField.text=[self writeWithKey:@"address"];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveAddress:) name:UITextFieldTextDidEndEditingNotification object:cell.detailTextField];
            
        }
    }else {
        cell.detailTextField.text=@"123";
        cell.detailTextField.textColor=[UIColor clearColor];
        UISegmentedControl *seg =[[UISegmentedControl alloc]initWithItems:@[@"转让",@"求购"]];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"neede%@",_indentifyID]] isEqualToString:@"求购"]) {
            seg.selectedSegmentIndex=1;
        }else{
            seg.selectedSegmentIndex=0;
        }
        seg.frame=CGRectMake(WIDTH/3-10, 10, WIDTH/3*2-10, 20);
        [seg addTarget:self action:@selector(changeNeede:) forControlEvents:UIControlEventValueChanged];
        seg.tintColor=BJCOLOR;
        [cell addSubview:seg];

        cell.detailTextField.enabled=NO;
        cell.nameLabel.text=section3ListArr[indexPath.row];

    }
    return cell;
}
-(void)changeNeede:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"转让" forKey:[NSString stringWithFormat:@"neede%@",_indentifyID]];
        }
            break;
        case 1:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"求购" forKey:[NSString stringWithFormat:@"neede%@",_indentifyID]];
        }
            break;
        default:
            break;
    }
}

-(NSString *)writeWithKey:(NSString *)str{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",str,_indentifyID]]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",str,_indentifyID]];
    }else{
        return @"";
    }
}

-(void)savetitle:(NSNotification *)not{
    [self save:@"title" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePrice:(NSNotification *)not{
    [self save:@"price" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveDescribe:(NSNotification *)not{
    [self save:@"describe" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:2 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePerson:(NSNotification *)not{
    [self save:@"person" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)savePhone:(NSNotification *)not{
    [self save:@"phone" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)saveAddress:(NSNotification *)not{
    [self save:@"address" withNot:not];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:2 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)save:(NSString *)str withNot:(NSNotification*)not{
    UITextField *textField =(UITextField*)[not object];
    [[NSUserDefaults standardUserDefaults]setObject:textField.text  forKey:[NSString stringWithFormat:@"%@%@",str,_indentifyID]];
}

//照片
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
    if (indexPath.section==2) {
        if (indexPath.row==2) {
            _placeArr=@[@"二七区",@"中原区",@"回族管城区",@"惠济区",@"金水区",@"上街区",@"巩义市",@"新密市",@"新郑市",@"登封市",@"荥阳市",@"中牟县",@"经济技术开发区",@"高新技术开发区"];
            ChooseViewController *vc=[[ChooseViewController alloc]initWithTile:@"选择品牌" textArray:_placeArr withKey:@"address"];
            [vc.choosButton addTarget:self action:@selector(chooseAdressClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

//选择区域
-(void)chooseAdressClick:(UIButton *)button{
    NSString *text=_placeArr[button.tag-1];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:1];
    ResumeTableViewCell *cell=(ResumeTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextField.text=text;
    [[NSUserDefaults standardUserDefaults]setObject:text  forKey:[NSString stringWithFormat:@"address%@",_indentifyID]];
    
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
