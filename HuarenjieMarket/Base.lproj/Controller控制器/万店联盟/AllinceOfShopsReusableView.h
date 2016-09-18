//
//  AllinceOfShopsReusableView.h
//  HuarenjieMarket
//
//  Created by aaa on 16/9/13.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^collectionBlock)();
@interface AllinceOfShopsReusableView : UICollectionReusableView

@property (nonatomic,strong) NSArray *imagesArr;

@property (nonatomic,strong) NSArray *titlesArr;

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic,copy) collectionBlock block;

- (void)setSDCycleScrollView:(UICollectionViewController *)delegate;

@end
