//
//  JianjieViewController.m
//  PhoneCallBack
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 com.hjl. All rights reserved.
//

#import "JianjieViewController.h"
#import "JianjieCell.h"

@interface JianjieViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tableView;
}

@end

@implementation JianjieViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *Identifier=@"JianjieCell";
    JianjieCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
      cell.userInteractionEnabled=YES;
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JianjieCell" owner:self options:nil] lastObject];
        [cell setCell];
        cell.selectionStyle=NO;
       
    }
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return self.view.frame.size.height*3+150;
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
