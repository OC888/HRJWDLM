//
//  SBCaptureToolKit.h
//  SBVideoCaptureDemo
//
//  Created by Pandara on 14-8-13.
//  Copyright (c) 2014年 Pandara. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SBCaptureToolKit : NSObject
//设置视图的宽
+ (void)setView:(UIView *)view toSizeWidth:(CGFloat)width;
//设置视图的起始X点
+ (void)setView:(UIView *)view toOriginX:(CGFloat)x;
//设置视图的起点Y点
+ (void)setView:(UIView *)view toOriginY:(CGFloat)y;
//设置视图的起点
+ (void)setView:(UIView *)view toOrigin:(CGPoint)origin;
//如果文件夹不存在创建视频文件夹
+ (BOOL)createVideoFolderIfNotExist;
//得到视频保存文件路径
+ (NSString *)getVideoSaveFilePathString;
//得到视频合并文件路径
+ (NSString *)getVideoMergeFilePathString;
//得到视频保存文件夹路径
+ (NSString *)getVideoSaveFolderPathString;

@end
