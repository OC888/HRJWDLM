//
//  AllinceOfShopsReusableView.m
//  HuarenjieMarket
//
//  Created by aaa on 16/9/13.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import "AllinceOfShopsReusableView.h"
#import "SDCycleScrollView.h"

@interface AllinceOfShopsReusableView ()
@end

@implementation AllinceOfShopsReusableView

- (NSArray *)imagesArr {
    if (!_imagesArr) {
        self.imagesArr = [[NSArray alloc]init];
    }
    return _imagesArr;
}

- (NSArray *)titlesArr {
    if (!_titlesArr) {
        self.titlesArr = [[NSArray alloc]init];
    }
    return _titlesArr;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubViews];
    }
    return self;
}

- (void)setSubViews {
//摆放分类选项
    NSArray *sectionTitles = @[@"服装",@"娱乐",@"外卖",@"美食",@"酒店"];
    NSArray *imageArr = @[@"服装.png",@"娱乐.png",@"外卖.png",@"美食.png",@"酒店.png"];
    for (int i = 0; i < sectionTitles.count; i++) {
        UIView *view = [[UIView alloc]init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(150);
            make.left.equalTo(self.left).offset(i * WIDTH / 5);
            make.size.equalTo(CGSizeMake(WIDTH / 5, WIDTH / 5 * 5 /4));
        }];
        
        UIImageView *image = [[UIImageView alloc]init];
        image.backgroundColor = [UIColor whiteColor];
        image.image = [UIImage imageNamed:imageArr[i]];
        [view addSubview:image];
        [image makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(10);
            make.top.equalTo(view.top).offset(10);
            make.width.equalTo(view.width).offset(-20);
            make.height.equalTo(view.height).offset(-20);
        }];
//        UILabel *sectionLabel = [[UILabel alloc]init];
//        sectionLabel.text = sectionTitles[i];
//        sectionLabel.textAlignment = NSTextAlignmentCenter;
//        [view addSubview:sectionLabel];
//        [sectionLabel makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(image.centerX);
//            make.top.equalTo(image.bottom);
//            make.bottom.equalTo(view.bottom);
//            make.width.equalTo(image.width);
//        }];
    }
}
//分类选项轻拍事件
- (void)tapAction:(UITapGestureRecognizer *)sender {
    !self.block?:self.block();
}
//加载轮播图
- (void)setSDCycleScrollView:(UICollectionViewController *)delegate {
    PCLog(@"%@",NSStringFromClass([delegate class]));
      self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, 150) shouldInfiniteLoop:YES imageNamesGroup:self.imagesArr];
    _cycleScrollView.titlesGroup = self.titlesArr;
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self addSubview:_cycleScrollView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
