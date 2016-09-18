//
//  TLCycleScrollView.m
//  WuXianLunBo
//
//  Created by TongLi on 15/12/11.
//  Copyright © 2015年 lanouhn. All rights reserved.
//

#import "TLCycleScrollView.h"
#import "UIImageView+WebCache.h"

@interface TLCycleScrollView ()
//判断本地图片还是网络图片链接
@property (nonatomic,assign)BOOL isLocationImage;
//图片数组
@property (nonatomic,strong)NSMutableArray *dataSouceImagesArr;
//图片链接数组
@property (nonatomic,strong)NSMutableArray *dataSouceImageURLArr;
//定时器
@property (nonatomic,strong)NSTimer *tempTime;
//定时的时间
@property (nonatomic,assign)NSTimeInterval imageChangeTimeInterval;


@end

@implementation TLCycleScrollView

- (id)initWithImageArr:(NSMutableArray *)imageArr withY:(CGFloat)Y withAspectRatio:(CGFloat)aspect withImageChangeTimeInterval:(NSTimeInterval )imageChangeTime {
    
    self = [super init];
    if (self) {
        
        self.isLocationImage = YES;
        //原有的images
        self.dataSouceImagesArr = imageArr;
        //定时器间隔
        self.imageChangeTimeInterval = imageChangeTime;
        //轮播图的frame
        self.frame = CGRectMake(0, Y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * aspect);
        //初始化定时器
        [self initWithTimer];
        //给图片数组前面和后面各在加一张图片
        NSMutableArray *tempImagesArr = [self addTempArr];

        //imageView的高度，因为宽度是屏幕宽，高度要计算
        float imageViewHeight = self.frame.size.height;
        
        //配置scrollView和在scrollView上添加图片
        [self initScrollViewAndAddImage:tempImagesArr withHeight:imageViewHeight];
        
    }
    return self;
}

- (id)initWithImageURLArr:(NSMutableArray *)imageURLArr withY:(CGFloat)Y withAspectRatio:(CGFloat)aspect withImageChangeTimeInterval:(NSTimeInterval )imageChangeTime {
    self = [super init];
    if (self) {
        
        self.isLocationImage = NO;
        //原有的images
        self.dataSouceImageURLArr = imageURLArr;
        //定时器间隔
        self.imageChangeTimeInterval = imageChangeTime;
        //轮播图的frame
        self.frame = CGRectMake(0, Y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * aspect);
        //初始化定时器
        [self initWithTimer];
        //给图片数组前面和后面各在加一张图片
        NSMutableArray *tempImagesArr =[self addTempArr];
//        tempImagesArr = [self addTempArr];
        

        //imageView的高度，因为宽度是屏幕宽，高度要计算
        float imageViewHeight = self.frame.size.height;
        //配置scrollView和在scrollView上添加图片
        [self initScrollViewAndAddImage:tempImagesArr withHeight:imageViewHeight];
        
    }
    return self;

}
//-------------------------------------------
//初始化实现
- (void)initWithTimer {
    self.tempTime = [NSTimer scheduledTimerWithTimeInterval:self.imageChangeTimeInterval target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];

}

//给数据源图片前后各自加一张图片
- (NSMutableArray *)addTempArr {
    NSMutableArray *tempImagesArr = [NSMutableArray array];
    if (self.isLocationImage == YES) {
        [tempImagesArr addObject:[self.dataSouceImagesArr objectAtIndex:self.dataSouceImagesArr.count-1]];
        for (int i = 0; i < self.dataSouceImagesArr.count; i++) {
            [tempImagesArr addObject:[self.dataSouceImagesArr objectAtIndex:i]];
        }
        [tempImagesArr addObject:[self.dataSouceImagesArr objectAtIndex:0]];
        

    }else {
        [tempImagesArr addObject:[self.dataSouceImageURLArr objectAtIndex:self.dataSouceImageURLArr.count-1]];
        for (int i = 0; i < self.dataSouceImageURLArr.count; i++) {
            [tempImagesArr addObject:[self.dataSouceImageURLArr objectAtIndex:i]];
        }
        [tempImagesArr addObject:[self.dataSouceImageURLArr objectAtIndex:0]];
        

    }
       return tempImagesArr;
}

//配置scrollView和在scrollView上添加图片
- (void)initScrollViewAndAddImage:(NSMutableArray *)tempImageArr withHeight:(CGFloat)imageViewHeight{
    self.delegate = self;
    self.pagingEnabled = YES;
    [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    self.showsHorizontalScrollIndicator = NO;
    self.backgroundColor = [UIColor orangeColor];
    //一共四张图片
    self.contentSize = CGSizeMake(self.frame.size.width * tempImageArr.count, imageViewHeight);
    
    //for循环创建imageView
    for (int i = 0; i < tempImageArr.count; i++) {
        UIImageView *tempImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, imageViewHeight)];
        if (self.isLocationImage == YES) {
            tempImageView.image = tempImageArr[i];

        }else {
            [tempImageView sd_setImageWithURL:tempImageArr[i]];
        }
        [self addSubview:tempImageView];
    }

}

//--------------------------------------------------------------
//当切换到最前面和最后面的时候要跳转
- (void)headImageAndFootImageContentOffset{
//    NSLog(@"%f",self.contentOffset.x);
    if (self.contentOffset.x == 0 ) {
//        NSLog(@"跳到最后");
        //跳转到最后一张图片
        if (self.isLocationImage == YES) {
            [self setContentOffset:CGPointMake(self.frame.size.width*self.dataSouceImagesArr.count, 0) animated:NO];

        }else {
            [self setContentOffset:CGPointMake(self.frame.size.width*self.dataSouceImageURLArr.count, 0) animated:NO];
        }
    }
    
    if (self.isLocationImage == YES) {
        if (self.contentOffset.x == self.frame.size.width*(self.dataSouceImagesArr.count+1)) {
            //跳转到第一张图片
            [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        }

    }else {
        if (self.contentOffset.x == self.frame.size.width*(self.dataSouceImageURLArr.count+1)) {
            //跳转到第一张图片
            [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        }

    }
}

#pragma mark - scrollView delegate -
//将要拖住时，需要将定时器停止
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.tempTime setFireDate:[NSDate distantFuture]];
}

//已经结束减速 scroll的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"%f,%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    [self headImageAndFootImageContentOffset];
    //重新开启定时器
    [self.tempTime setFireDate:[[NSDate alloc] initWithTimeIntervalSinceNow:self.imageChangeTimeInterval]];
    
    
}
//动画结束后，即定时器切换时候的有动画，
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    NSLog(@"切换后 %f",self.contentOffset.x);
    [self headImageAndFootImageContentOffset];

}

#pragma mark - 定时器 -
//定时器
- (void)timerAction:(NSTimer *)sender{    
//    NSLog(@"切换前  %f",self.contentOffset.x);
    [self setContentOffset:CGPointMake(self.contentOffset.x + self.frame.size.width, 0) animated:YES];
}

//移除定时器
- (void)removeTime{
    [self.tempTime invalidate];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
