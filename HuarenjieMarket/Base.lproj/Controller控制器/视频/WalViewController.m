//
//  ViewController.m
//  AideoPlayProject
//
//  Created by aaa on 16/5/3.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "WalViewController.h"
//#import "TakeMovieViewController.h"
#import "CaptureViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SBCaptureToolKit.h"
#import <AVFoundation/AVFoundation.h>
#import "GRViewController.h"
@interface WalViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentC;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation WalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = BJCOLOR;
    _segmentC.tintColor = BJCOLOR;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.translucent = NO;
    _scrollView.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

//点击可拍摄个人短视频
- (IBAction)takeMovieAction:(UIBarButtonItem *)sender {
    UINavigationController *navCon = [[UINavigationController alloc] init];
    navCon.navigationBarHidden = YES;
    CaptureViewController *captureViewCon = [[CaptureViewController alloc] initWithNibName:@"CaptureViewController" bundle:nil];
    [navCon pushViewController:captureViewCon animated:NO];
    [self presentViewController:navCon animated:YES completion:nil];
}

- (IBAction)segmentControlAction:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            _scrollView.contentOffset = CGPointMake(0, [UIScreen mainScreen].bounds.origin.y);
        }
            break;
        case 1:
        {
            _scrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.origin.y);
        }
            break;
        case 2:
        {
            _scrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width*2, [UIScreen mainScreen].bounds.origin.y);
//            GRViewController *GRView = [[GRViewController alloc] init];
//            [self.navigationController pushViewController:GRView animated:YES];
        }
            break;
        case 3:
        {
            _scrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width*3, [UIScreen mainScreen].bounds.origin.y);
        }
            break;
        default:
            break;
    }
}

- (void)showAlert {
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil message:@"该模块尚未开通" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeFireMethod:) userInfo:alertV repeats:NO];
    [alertV show];
}

#pragma mark <UIScrollViewDelegate>
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0) {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backToMain:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotate {
    return NO;
}

@end
