//
//  ViewController.m
//  PayObject
//
//  Created by aaa on 16/8/20.
//  Copyright © 2016年 王泉. All rights reserved.
//

#import "PayViewController.h"
#import "ZWTopSelectButton.h"
#import "ZWTopSelectVcView.h"
#import "CardKeyViewController.h"
#import "PayOnlineController.h"
#import "PayforCellController.h"
@interface PayViewController ()<ZWTopSelectVcViewDelegate>
@property (nonatomic, strong) ZWTopSelectVcView *topSelectVcView;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.view.backgroundColor = [UIColor whiteColor];
//    初始化ZWTopSelectVcView，把其加入当前控制器view中
    ZWTopSelectVcView *topSelectView =[[ZWTopSelectVcView alloc]init];
    topSelectView.frame = CGRectMake(0, 64, WIDTH, HEIGHT);
    [self.view addSubview:topSelectView];
    self.topSelectVcView = topSelectView;
//    设置ZWTopSelectVcView的代理
    self.topSelectVcView.delegate = self;
    
//    开始ZWTopSelectVcViewUI绘制,必须实现！
    [self.topSelectVcView setupZWTopSelectVcViewUI];
    
//    设置上部滑动按钮
    [self setupSingleButton];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupSingleButton {
   self.topSelectVcView.topViewFirstbtn.labName.text = @"卡密支付";
   self.topSelectVcView.topViewSecondbtn.labName.text = @"在线充值";

}


#pragma mark - ZWTopSelectVcViewDelegate
#warning 只要一步且必须实现：传入您的各种控制器，用可变数组封装传入，就会动态的生成，默认最多能传入九个控制器
//初始化设置
-(NSMutableArray *)totalControllerInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    NSMutableArray *controllerMutableArr = [NSMutableArray array];
    CardKeyViewController *cardKey = [[CardKeyViewController alloc]init];
    PayOnlineController *payOnline = [[PayOnlineController alloc]init];
    payOnline.payClick = ^(NSString *money,NSString *userMobile,NSString *mobile,NSString *IP){
        PayforCellController *payCellVC = [[PayforCellController alloc]init];
        payCellVC.moneyNum = money;
        payCellVC.userIp = IP;
        payCellVC.accountMobileNum = mobile;
        payCellVC.userMobileNum = userMobile;
        [self.navigationController pushViewController:payCellVC animated:YES];
    
    };
    [controllerMutableArr addObject:cardKey];
    [controllerMutableArr addObject:payOnline];
    return controllerMutableArr;
}

/////子控制器childVcView宽度
-(CGFloat)childVcViewWidthInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    return WIDTH;
}



///子控制器childVcView高度
-(CGFloat)childVcViewHeightInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    return HEIGHT - 64 - 50;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
