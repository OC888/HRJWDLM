//
//  SegmentViewController.m
//  HuarenjieMarket
//
//  Created by l x on 16/8/19.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "SegmentViewController.h"

@interface SegmentViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *segMent;
@property (strong, nonatomic) IBOutlet UIView *bottomCustomView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollV;
@property (copy,nonatomic) NSString *obseverStr;
@end

@implementation SegmentViewController
- (IBAction)backs:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = BJCOLOR;
    self.navigationController.navigationBar.translucent = NO;
//    自身添加监听者，监听自身，keypath为自身属性
    [ _scrollV addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}

//调用监听代理方法，监听改变
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (change) {
            _segMent.selectedSegmentIndex = !_segMent.selectedSegmentIndex;
        }
    }
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segAction:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
//
            self.scrollV.contentOffset = CGPointMake(0, 0);
            break;
        case 1:
//
            self.scrollV.contentOffset = CGPointMake(MW, 0);

            break;
            
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dealloc {
    [_scrollV removeObserver:self forKeyPath:@"contentOffset"];
}
@end
