//
//  AXViewController.m
//  AideoPlayProject
//
//  Created by aaa on 16/6/20.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "AXViewController.h"
#import "MJRefresh.h"
#import "DataManager.h"
//#import "THVideoCell.h"
#import "UIViewExt.h"
#import "HTPlayer.h"
#import "WLDetailViewController.h"
#import "AFNetworking.h"
#import "AixinModel.h"
#import "AXTableViewCell.h"
#define VideoURL @"http://baobab.wandoujia.com/api/v2/feed?num=2&udid=6ff0d59fcc8a435e83148423a0fdcb56608d6876&vc=106&vn=2.0.2&deviceModel=SM-A8000&first_channel=eyepetizer_baidu_market&last_channel=eyepetizer_baidu_market"

@interface AXViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (strong, nonatomic)NSMutableArray *dataSource; //数据源
@property (strong, nonatomic)UITableView *table;
@property (strong, nonatomic)NSIndexPath *currentIndexPath;
@property (strong, nonatomic)AXTableViewCell *currentCell;//当前播放的cell
@property (strong, nonatomic)HTPlayer *htPlayer;
@property (assign, nonatomic)BOOL isSmallScreen;
@property (strong, nonatomic)WLDetailViewController *detail;
@end

@implementation AXViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.table];
    [self.table registerClass:[AXTableViewCell class] forCellReuseIdentifier:@"VideoCell"];
    
    //    [self addMJRefresh];
    [self Networking];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popDetail:)
                                                 name:kHTPlayerPopDetailNotificationKey
                                               object:nil];
    [self addObserver];
}


- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:)
                                                 name:kHTPlayerFinishedPlayNotificationKey object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:)
                                                 name:kHTPlayerFullScreenBtnNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeTheVideo:)
                                                 name:kHTPlayerCloseVideoNotificationKey
                                               object:nil];
    
}

-(void)videoDidFinished:(NSNotification *)notice{
    
    if (_htPlayer.screenType == UIHTPlayerSizeFullScreenType){
        
        [self toCell];//先变回cell
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _htPlayer.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_htPlayer removeFromSuperview];
        [self releaseWMPlayer];
    }];
    
}
-(void)closeTheVideo:(NSNotification *)obj{
    
    [UIView animateWithDuration:0.3 animations:^{
        _htPlayer.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_htPlayer removeFromSuperview];
        [self releaseWMPlayer];
    }];
}

-(void)fullScreenBtnClick:(NSNotification *)notice{
    
    UIButton *fullScreenBtn = (UIButton *)[notice object];
    if (fullScreenBtn.isSelected) {//全屏显示
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        if (_isSmallScreen) {
            //放widow上,小屏显示
            [self toSmallScreen];
        }else{
            [self toCell];
        }
    }
}

-(void)releaseWMPlayer{
    
    [_htPlayer releaseWMPlayer];
    _htPlayer = nil;
    _currentIndexPath = nil;
}

//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//
//    [self loadData];
//}
//-(void)loadData{
//    if (self.dataSource.count == 0) {
//        [self refreshData];
//    }
//}

//- (void)refreshData
//{
//     __unsafe_unretained UITableView *tableView = self.table;
//    [[DataManager shareManager] getSIDArrayWithURLString:@"http://c.m.163.com/nc/video/home/0-10.html"
//                                                 success:^(NSArray *sidArray, NSArray *videoArray) {
//                                                     _dataSource =[NSMutableArray arrayWithArray:videoArray];
//                                                     dispatch_async(dispatch_get_main_queue(), ^{
//
//                                                         [tableView reloadData];
//                                                         [tableView.mj_header endRefreshing];
//                                                     });
//                                                 }
//                                                  failed:^(NSError *error) {
//
//                                                  }];
//
//}

//-(void)addMJRefresh{
//    __unsafe_unretained UITableView *tableView = self.table;
//    __weak GRViewController *selfView = self;
//    // 下拉刷新
//    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//        [selfView refreshData];
//    }];
//
//    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    tableView.mj_header.automaticallyChangeAlpha = YES;
//    // 上拉刷新
//    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        NSString *URLString = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/%ld-10.html",_dataSource.count - _dataSource.count%10];
//        [[DataManager shareManager] getSIDArrayWithURLString:URLString
//                                                     success:^(NSArray *sidArray, NSArray *videoArray) {
//                                                         [_dataSource addObjectsFromArray:videoArray];
//                                                         dispatch_async(dispatch_get_main_queue(), ^{
//                                                             [tableView reloadData];
//                                                             [tableView.mj_header endRefreshing];
//                                                         });
//
//                                                     }
//                                                      failed:^(NSError *error) {
//
//                                                      }];
//
//        // 结束刷新
//        [tableView.mj_footer endRefreshing];
//    }];
//}

- (void)Networking {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text", @"application/json", @"xml", @"script",  nil];
    __weak AXViewController *AixinVC = self;
    [manager GET:VideoURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [AixinVC parseData:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)parseData:(id)response {
    NSMutableArray *issueList = response[@"issueList"];
    for (NSMutableDictionary *Dic in issueList) {
        NSMutableArray *itemList = Dic[@"itemList"];
        for (NSMutableDictionary *dic in itemList) {
            AixinModel *model = [[AixinModel alloc] init];
            if ([dic[@"type"] isEqualToString:@"video"]) {
                NSMutableDictionary *data = dic[@"data"];
                [model setValuesForKeysWithDictionary:data];
                NSMutableDictionary *consumption = data[@"consumption"];
                [model setValuesForKeysWithDictionary:consumption];
                NSMutableDictionary *cover = data[@"cover"];
                [model setValuesForKeysWithDictionary:cover];
                [self.dataSource addObject:model];
            }
        }
    }
    [self.table reloadData];
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.height / 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"VideoCell";
    AXTableViewCell *cell = (AXTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    cell.model = [_dataSource objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.playBtn addTarget:self action:@selector(startPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
    cell.playBtn.tag = indexPath.row;
    
    return cell;
}

#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView ==self.table){
        if (_htPlayer==nil) return;
        
        if (_htPlayer.superview) {
            CGRect rectInTableView = [self.table rectForRowAtIndexPath:_currentIndexPath];
            CGRect rectInSuperview = [self.table convertRect:rectInTableView toView:[self.table superview]];
            
            //            NSLog(@"rectInSuperview = %@",NSStringFromCGRect(rectInSuperview));
            
            if (rectInSuperview.origin.y-kNavbarHeight<-self.currentCell.backView.height||rectInSuperview.origin.y>self.view.height) {//往上拖动
                
                if (![[UIApplication sharedApplication].keyWindow.subviews containsObject:_htPlayer]) {
                    //放widow上,小屏显示
                    [self toSmallScreen];
                }
                
            }else{
                if (![self.currentCell.backView.subviews containsObject:_htPlayer]) {
                    [self toCell];
                }
            }
        }
        
    }
}

-(void)toCell{
    
    self.currentCell = (AXTableViewCell *)[self.table cellForRowAtIndexPath:_currentIndexPath];
    [_htPlayer reductionWithInterfaceOrientation:self.currentCell.backView];
    _isSmallScreen = NO;
    [self.table reloadData];
}

-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    
    [_htPlayer toFullScreenWithInterfaceOrientation:interfaceOrientation];
}
-(void)toSmallScreen{
    //放widow上
    [_htPlayer toSmallScreen];
    _isSmallScreen = YES;
}

//开始播放
-(void)startPlayVideo:(UIButton *)sender{
    _currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    self.currentCell = (AXTableViewCell *)[self.table cellForRowAtIndexPath:_currentIndexPath];
    AixinModel *model = [_dataSource objectAtIndex:sender.tag];
    
    
    if (_htPlayer) {
        [_htPlayer removeFromSuperview];
        [_htPlayer setVideoURLStr:model.playUrl];
        
    }else{
        _htPlayer = [[HTPlayer alloc]initWithFrame:self.currentCell.backView.bounds videoURLStr:model.playUrl];
    }
    
    [_htPlayer setPlayTitle:model.title];
    
    [self.currentCell.backView addSubview:_htPlayer];
    [self.currentCell.backView bringSubviewToFront:_htPlayer];
    
    if (_htPlayer.screenType == UIHTPlayerSizeSmallScreenType) {
        [_htPlayer reductionWithInterfaceOrientation:self.currentCell.backView];
    }
    _isSmallScreen = NO;
    
    [self.table reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!_detail) {
        _detail = [[WLDetailViewController alloc] init];
        _detail.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController addChildViewController:_detail];
        [self.navigationController.view addSubview:_detail.view];
        _detail.view.alpha = 0;
    }
    
    //    判断当前播放的视频，是否用户点击的视频。
    if (_currentIndexPath && _currentIndexPath.row != indexPath.row) {
        
        _isSmallScreen = NO;
        if (_htPlayer) {
            [self releaseWMPlayer];//关闭视频
        }
        
        _currentIndexPath = indexPath;
        _currentCell = [tableView cellForRowAtIndexPath:indexPath];
    }
    _detail.htPlayer = _htPlayer;
    AixinModel *model = [_dataSource objectAtIndex:indexPath.row];
    _detail.model = model;
    
    [_detail reloadData];
    
    [UIView animateWithDuration:0.5 animations:^{
        _detail.view.alpha = 1;
    }];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHTPlayerFinishedPlayNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHTPlayerFullScreenBtnNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHTPlayerFinishedPlayNotificationKey object:nil];
}

- (void)popDetail:(NSNotification *)obj
{
    _htPlayer = (HTPlayer *)obj.object;
    
    if (_htPlayer) {
        if (_isSmallScreen) {
            //放widow上,小屏显示
            [self toSmallScreen];
        }else{
            [self toCell];
        }
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        _detail.view.alpha = 0.0;
    }];
    
    [[NSNotificationCenter defaultCenter] removeObserver:_detail];
    [self addObserver];
}

- (UITableView *)table
{
    if (_table) return _table;
    _table = [[UITableView alloc] initWithFrame:self.view.bounds];
    _table.dataSource = self;
    _table.delegate = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    return _table;
}

-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releaseWMPlayer];
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
