////
////  AixinManager.m
////  AideoPlayProject
////
////  Created by aaa on 16/5/5.
////  Copyright © 2016年 wangli. All rights reserved.
////
//
//#import "AixinManager.h"
//
//@implementation AixinManager
//
//+ (AixinManager *)shareInstance {
//    static AixinManager *manager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [[AixinManager alloc] init];
//    });
//    return manager;
//}
//
//- (NSMutableArray *)dataSource {
//    if (!_dataSource) {
//        self.dataSource = [NSMutableArray arrayWithCapacity:0];
//    }
//    return _dataSource;
//}
//
//- (void)Networking {
//    NSURL *url = [NSURL URLWithString:VideoURL];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error == nil) {
//            NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            
//            //数据解析
//            [self parseData:dictionary];
//        }
//    }];
//    [task resume];
//}
//
//- (void)parseData:(id)response {
//    NSMutableArray *issueList = response[@"issueList"];
//    for (NSMutableDictionary *Dic in issueList) {
//        NSMutableArray *itemList = Dic[@"itemList"];
//        [itemList removeObjectAtIndex:0];
//        for (NSMutableDictionary *dic in itemList) {
//            AixinModel *model = [[AixinModel alloc] init];
//            NSMutableDictionary *data = dic[@"data"];
//            [model setValuesForKeysWithDictionary:data];
//            NSMutableDictionary *consumption = dic[@"consumption"];
//            [model setValuesForKeysWithDictionary:consumption];
//            NSMutableDictionary *cover = dic[@"cover"];
//            [model setValuesForKeysWithDictionary:cover];
//            [self.dataSource addObject:model];
//        }
//    }
//}
//
//
//@end
