//
//  AFHttpManager.m
//  temp
//
//  Created by l x on 16/5/26.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import "AFHttpManager.h"

@implementation AFHttpManager

//发布简历
+(void)sendResumeWithBiaoZhi:(NSString *)biaoZhi withBirthday:(NSString *)birthday withEmail:(NSString *)email withFabutime:(NSString *)fabutime withgongzuonianxian:(NSString *)gongzuonianxian withgongzuoquyu:(NSString *)gongzuoquyu withgongzuoshijian:(NSString *)gongzuoshijian withjiaxiang:(NSString *)jiaxiang withname:(NSString *)name withphone:(NSString *)phone withqiuzhixuanyan:(NSString *)qiuzhixuanyan withqiwangrixin:(NSString *)qiwangrixin withsalary:(NSString *)salary withsex:(NSString *)sex withtouxiang:(NSData *)touxiang withxueli:(NSString *)xueli withzhiwei:(NSString *)zhiwei withType:(void(^)(NSString *string))block{
    
    NSArray *keys = @[@"biaozhi",@"birthday",@"email",@"fabutime",@"gongzuonianxian",@"gongzuoquyu",@"gongzuoshijian",@"jiaxiang",@"name",@"phone",@"qiuzhixuanyan",@"qiwangrixin",@"salary",@"sex",@"touxiang",@"xueli",@"zhiwei"];
    NSArray *objects = @[biaoZhi,birthday,email,fabutime,gongzuonianxian,gongzuoquyu,gongzuoshijian,jiaxiang,name,phone,qiuzhixuanyan,qiwangrixin,salary,sex,touxiang,xueli,zhiwei];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/jianlisave.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];

}

//获取简历
+(void)parserResumeInfoWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlString=@"http://zghrj.cn/interface/jianliselect.php";
    __block ResumeInfo *resumeInfo;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    __block NSMutableArray *tempArr;
    tempArr =[NSMutableArray array];
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            resumeInfo =[ResumeInfo parseResumeInfoWithDic:dic];
            [resumeArr addObject:resumeInfo];
        }
        for (ResumeInfo *resumeInfo in resumeArr) {
            if ([resumeInfo.zhiwei isEqualToString:title]) {
                [tempArr addObject:resumeInfo];
            }
        }
        block(tempArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//发布二手汽车
+(void)sendCarResumeWithbiaoti:(NSString *)biaoti withbrand:(NSString *)brand withcolor:(NSString *)color withimage1:(NSData *)image1 withimage2:(NSData *)image2 withimage3:(NSData *)image3 withimage4:(NSData *)image4 withimage5:(NSData *)image5 withimage6:(NSData *)image6 withimage7:(NSData *)image7 withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withplace:(NSString *)place withprice:(NSString *)price withshangpaidate:(NSString *)shangpaidate withxingshilicheng:(NSString *)xingshilicheng withType:(void(^)(NSString *string))block{
    
    NSArray *keys = @[@"biaoti",@"brand",@"color",@"image1",@"image2",@"image3",@"image4",@"image5",@"image6",@"image7",@"lianxiren",@"miaoshu",@"phone",@"place",@"price",@"shangpaidate",@"xingshilicheng"];
    NSArray *objects = @[biaoti,brand,color,image1,image2,image3,image4,image5,image6,image7,lianxiren,miaoshu,phone,place,price,shangpaidate,xingshilicheng];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/ershouqichesave.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//获取二手车
+(void)parserCarInfoWithArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString=@"http://zghrj.cn/interface/ershouqicheselect.php";
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block CarInfo *carInfo;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            carInfo =[CarInfo parseResumeInfoWithDic:dic];
            [resumeArr addObject:carInfo];
        }
        block(resumeArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//发布二手摩托、自行车等
+(void)sendBikeResumeWithbiaoti:(NSString *)biaoti withgongxubiaozhi:(NSString *)gongxubiaozhi  withimage1:(NSData *)image1 withimage2:(NSData *)image2 withimage3:(NSData *)image3 withimage4:(NSData *)image4 withimage5:(NSData *)image5 withimage6:(NSData *)image6 withimage7:(NSData *)image7 withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone  withprice:(NSString *)price withquyu:(NSString *)quyu withzhonglei:(NSString *)zhonglei withType:(void(^)(NSString *string))block{
    NSArray *keys = @[@"biaoti",@"gongxubiaozhi",@"image1",@"image2",@"image3",@"image4",@"image5",@"image6",@"image7",@"lianxiren",@"miaoshu",@"phone",@"price",@"quyu",@"zhonglei"];
    NSArray *objects = @[biaoti,gongxubiaozhi,image1,image2,image3,image4,image5,image6,image7,lianxiren,miaoshu,phone,price,quyu,zhonglei];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/cheqitasave.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//获取二手摩托、自行车等
+(void)parserBikeInfoWithArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString=@"http://zghrj.cn/interface/cheqitaselect.php";
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block BikeInfo *bikeInfo;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            bikeInfo =[BikeInfo parseResumeInfoWithDic:dic];
            [resumeArr addObject:bikeInfo];
        }
        block(resumeArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];    
}
//发布全职招聘信息
+(void)sendFullTimeWitharea:(NSString *)area withdec_yuexin:(NSString *)dec_yuexin  withdt_datetime:(NSString *)dt_datetime withgongzuodidian:(NSString *)gongzuodidian withgongzuonianxian:(NSString *)gongzuonianxian withi_zhaopinrenshu:(NSString *)i_zhaopinrenshu withlianxiren:(NSString *)lianxiren withnianlingduan:(NSString *)nianlingduan withphone:(NSString *)phone withtitle:(NSString *)title withxueli:(NSString *)xueli withzhiweimiaoshu:(NSString *)zhiweimiaoshu withzhiwei:(NSString *)zhiwei withgongsiname:(NSString *)gongsiname withshisufuli:(NSString *)shisufuli withshehuifuli:(NSString *)shehuifuli withqitafuli:(NSString *)qitafuli withguimo:(NSString *)guimo withgongsijianjie:(NSString *)gongsijianjie withType:(void(^)(NSString *string))block{
    
    NSArray *keys = @[@"area",@"dec_yuexin",@"dt_datetime",@"gongzuodidian",@"gongzuonianxian",@"i_zhaopinrenshu",@"lianxiren",@"nianlingduan",@"phone",@"title",@"xueli",@"zhiweimiaoshu",@"zhiwei",@"gongsiname",@"shisufuli",@"shehuifuli",@"qitafuli",@"guimo",@"gongsijianjie"];
    NSArray *objects = @[area,dec_yuexin,dt_datetime,gongzuodidian,gongzuonianxian,i_zhaopinrenshu,lianxiren,nianlingduan,phone,title,xueli,zhiweimiaoshu,zhiwei,gongsiname,shisufuli,shehuifuli,qitafuli,guimo,gongsijianjie];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/zhaopin_quanzhi_save.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//获取全职招聘信息
+(void)parserFullTimeWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString=@"http://zghrj.cn/interface/zhaopin_quanzhi_select.php";
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block FullTimeInfo *fullTimeInfo;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    __block NSMutableArray *tempArr;
    tempArr =[NSMutableArray array];
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            fullTimeInfo =[FullTimeInfo parseFullTimeInfoWithDic:dic];
            [resumeArr addObject:fullTimeInfo];
        }
        for (FullTimeInfo *fullTimeInfo in resumeArr) {
            if ([fullTimeInfo.zhiwei isEqualToString:title]) {
                [tempArr addObject:fullTimeInfo];
            }
        }
        block(tempArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}

//发布兼职招聘信息
+(void)sendPartTimeWitharea:(NSString *)area withdec_xinzi:(NSString *)dec_xinzi  withdt_datetime:(NSString *)dt_datetime withgongsijianjie:(NSString *)gongsijianjie withgongsiname:(NSString *)gongsiname withgongzuodidian:(NSString *)gongzuodidian withgongzuonianxian:(NSString *)gongzuonianxian withgongzuoshijian:(NSString *)gongzuoshijian withguimo:(NSString *)guimo withi_zhaopinrenshu:(NSString *)i_zhaopinrenshu withlianxiren:(NSString *)lianxiren withnianlingduan:(NSString *)nianlingduan withphone:(NSString *)phone withqitafuli:(NSString *)qitafuli withshisufuli:(NSString *)shisufuli withshehuifuli:(NSString *)shehuifuli withtitle:(NSString *)title withxueli:(NSString *)xueli withzhiwei:(NSString *)zhiwei withzhiweimiaoshu:(NSString *)zhiweimiaoshu withType:(void(^)(NSString *string))block{
    
    NSArray *keys = @[@"area",@"dec_xinzi",@"dt_datetime",@"gongsijianjie",@"gongsiname",@"gongzuodidian",@"gongzuonianxian",@"gongzuoshijian",@"guimo",@"i_zhaopinrenshu",@"lianxiren",@"nianlingduan",@"phone",@"qitafuli",@"shehuifuli",@"shisufuli",@"title",@"xueli",@"zhiwei",@"zhiweimiaoshu"];
    NSArray *objects = @[area,dec_xinzi,dt_datetime,gongsijianjie,gongsiname,gongzuodidian,gongzuonianxian,gongzuoshijian,guimo,i_zhaopinrenshu,lianxiren,nianlingduan,phone,qitafuli,shehuifuli,shisufuli,title,xueli,zhiwei,zhiweimiaoshu];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/zhaopin_jianzhi_save.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}

//获取兼职招聘信息
+(void)parserPartTimeWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString=@"http://zghrj.cn/interface/zhaopin_jianzhi_select.php";
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block PartTimeInfo *partTimeInfo;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    __block NSMutableArray *tempArr;
    tempArr =[NSMutableArray array];
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            partTimeInfo =[PartTimeInfo parsePartTimeInfoWithDic:dic];
            [resumeArr addObject:partTimeInfo];
        }
        for (PartTimeInfo *partTimeInfo in resumeArr) {
            if ([partTimeInfo.zhiwei isEqualToString:title]) {
                [tempArr addObject:partTimeInfo];
            }
        }
        block(tempArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//发布二手物品
+(void)sendErShouGoodsWithdec_jiage:(NSString *)dec_jiage withdt_datetime:(NSString *)dt_datetime  withfenlei:(NSString *)fenlei withgongxu:(NSString *)gongxu withimagedata1:(NSData *)imagedata1 withimagedata2:(NSData *)imagedata2 withimagedata3:(NSData *)imagedata3 withimagedata4:(NSData *)imagedata4 withimagedata5:(NSData *)imagedata5 withimagedata6:(NSData *)imagedata6 withimagedata7:(NSData *)imagedata7 withlaiyuan:(NSString *)laiyuan withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withtitle:(NSString *)title withType:(void(^)(NSString *string))block{
    NSArray *keys = @[@"dec_jiage",@"dt_datetime",@"fenlei",@"gongxu",@"img1",@"img2",@"img3",@"img4",@"img5",@"img6",@"img7",@"laiyuan",@"lianxiren",@"miaoshu",@"phone",@"quyu",@"title"];
    NSArray *objects = @[dec_jiage,dt_datetime,fenlei,gongxu,imagedata1,imagedata2,imagedata3,imagedata4,imagedata5,imagedata6,imagedata7,laiyuan,lianxiren,miaoshu,phone,quyu,title];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/ershouwupin_save.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//获取二手物品
+(void)parserErShouGoodsWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString=@"http://zghrj.cn/interface/ershouwupin_select.php";
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block ErShouGoods *erShouGoods;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    __block NSMutableArray *tempArr;
    tempArr =[NSMutableArray array];
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            erShouGoods =[ErShouGoods parseErShouGoodsInfoWithDic:dic];
            [resumeArr addObject:erShouGoods];
        }
        for (ErShouGoods *erShouGood in resumeArr) {
            if ([erShouGood.fenlei isEqualToString:title]) {
                [tempArr addObject:erShouGood];
            }
        }
        block(tempArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//二手房求购发布
+(void)sendErShouFangQiuGouWithdec_qiwangprice:(NSString *)dec_qiwangprice withdt_datetime:(NSString *)dt_datetime  withhuxing:(NSString *)huxing withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withqiwangxiaoqu:(NSString *)qiwangxiaoqu withquyu:(NSString *)quyu withtitle:(NSString *)title withxinxilaiyuan:(NSString *)xinxilaiyuan withType:(void(^)(NSString *string))block{
    
    NSArray *keys = @[@"dec_qiwangprice",@"dt_datetime",@"huxing",@"lianxiren",@"miaoshu",@"phone",@"qiwangxiaoqu",@"quyu",@"title",@"xinxilaiyuan"];
    NSArray *objects = @[dec_qiwangprice,dt_datetime,huxing,lianxiren,miaoshu,phone,qiwangxiaoqu,quyu,title,xinxilaiyuan];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/house_ershouqiugou_save.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//二手房求购获取
+(void)parserErShouFangQiuGouWithUrlString:(NSString *)urlString withArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block ErShouFangQiuGouInfo *info;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            info =[ErShouFangQiuGouInfo parseErShouFangQiuGouInfoWithDic:dic];
            [resumeArr addObject:info];
        }
        block(resumeArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//发布二手房出售
+(void)sendErShouFangChuShouWithchaoxiang:(NSString *)chaoxiang withdec_fangling:(NSString *)dec_fangling  withdec_mianji:(NSString *)dec_mianji withdec_price:(NSString *)dec_price withdt_datetime:(NSString *)dt_datetime wihthhuxing:(NSString *)huxing withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withlianxiren:(NSString *)lianxiren withlouceng:(NSString *)louceng withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withtitle:(NSString *)title withxiaoqu:(NSString *)xiaoqu withxinxilaiyuan:(NSString *)xinxilaiyuan withType:(void(^)(NSString *string))block{
    NSArray *keys = @[@"chaoxiang",@"dec_fangling",@"dec_mianji",@"dec_price",@"dt_datetime",@"huxing",@"img1",@"img2",@"img3",@"img4",@"img5",@"img6",@"img7",@"lianxiren",@"louceng",@"miaoshu",@"phone",@"quyu",@"title",@"xiaoqu",@"xinxilaiyuan"];
    NSArray *objects = @[chaoxiang,dec_fangling,dec_mianji,dec_price,dt_datetime,huxing,img1,img2,img3,img4,img5,img6,img7,lianxiren,louceng,miaoshu,phone,quyu,title,xiaoqu,xinxilaiyuan];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/house_ershousale_save.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//二手房出售获取
+(void)parserErShouFangChuShouWithUrlString:(NSString *)urlString withArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block ErShouFangInfo *info;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            info =[ErShouFangInfo parseErShouFangChuShouInfoWithDic:dic];
            [resumeArr addObject:info];
        }
        block(resumeArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//商铺出售发布
+(void)sendShangPuChuShouWithbiaozhi:(NSString *)biaozhi withdec_mianji:(NSString *)dec_mianji  withdec_price:(NSString *)dec_price withdizhi:(NSString *)dizhi withdt_datetime:(NSString *)dt_datetime wihthgongxu:(NSString *)gongxu withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withleixing:(NSString *)leixing withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withtitle:(NSString *)title withxinxilaiyuan:(NSString *)xinxilaiyuan withType:(void(^)(NSString *string))block{
    NSArray *keys = @[@"biaozhi",@"dec_mianji",@"dec_price",@"dizhi",@"dt_datetime",@"gongxu",@"img1",@"img2",@"img3",@"img4",@"img5",@"img6",@"img7",@"leixing",@"lianxiren",@"miaoshu",@"phone",@"quyu",@"title",@"xinxilaiyuan"];
    NSArray *objects = @[biaozhi,dec_mianji,dec_price,dizhi,dt_datetime,gongxu,img1,img2,img3,img4,img5,img6,img7,leixing,lianxiren,miaoshu,phone,quyu,title,xinxilaiyuan];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/house_shangpusale_save.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//获取商铺出售
+(void)parserShangPuInfoWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString=@"http://zghrj.cn/interface/house_shangpusale_select.php";
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block  ShangPuInfo*shangPuInfo;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    __block NSMutableArray *tempArr;
    tempArr =[NSMutableArray array];
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            shangPuInfo =[ShangPuInfo parseShangPuChuShouInfoWithDic:dic];
            [resumeArr addObject:shangPuInfo];
        }
        for (ShangPuInfo *shangPuInfo in resumeArr) {
            if ([shangPuInfo.biaozhi isEqualToString:title]) {
                [tempArr addObject:shangPuInfo];
            }
        }
        block(tempArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//发布新房出售
+(void)sendNewHouseChuShouWithchaoxiang:(NSString *)chaoxiang withzhuangxiu:(NSString *)zhuangxiu  withdec_mianji:(NSString *)dec_mianji withdec_price:(NSString *)dec_price withdt_datetime:(NSString *)dt_datetime wihthhuxing:(NSString *)huxing withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withlianxiren:(NSString *)lianxiren withlouceng:(NSString *)louceng withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withtitle:(NSString *)title withxiaoqu:(NSString *)xiaoqu withxinxilaiyuan:(NSString *)xinxilaiyuan withType:(void(^)(NSString *string))block{
    NSArray *keys = @[@"chaoxiang",@"zhuangxiu",@"dec_jianzhumianji",@"dec_shoujia",@"dt_datetime",@"huxing",@"img1",@"img2",@"img3",@"img4",@"img5",@"img6",@"img7",@"lianxiren",@"louceng",@"miaoshu",@"phone",@"quyu",@"title",@"xiaoquname",@"xinxilaiyuan"];
    NSArray *objects = @[chaoxiang,zhuangxiu,dec_mianji,dec_price,dt_datetime,huxing,img1,img2,img3,img4,img5,img6,img7,lianxiren,louceng,miaoshu,phone,quyu,title,xiaoqu,xinxilaiyuan];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/house_xinfangsale_save.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//获取新房出售
+(void)parserNewHouseChuShouInfoWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString=@"http://zghrj.cn/interface/house_xinfangsale_select.php";
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block  NewHouseInfo*newHouseInfo;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    __block NSMutableArray *tempArr;
    tempArr =[NSMutableArray array];
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            newHouseInfo =[NewHouseInfo parseNewHouseChuShouInfoWithDic:dic];
            [resumeArr addObject:newHouseInfo];
        }
        for (NewHouseInfo *newHouseInfo in resumeArr) {
            if ([newHouseInfo.zhuangxiu isEqualToString:title]) {
                [tempArr addObject:newHouseInfo];
            }
        }
        block(resumeArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//发布整租
+(void)sendZhengZuWithbiaoti:(NSString *)biaoti withdec_mianji:(NSString *)dec_mianji  withdec_zujin:(NSString *)dec_zujin withdt_datetime:(NSString *)dt_datetime withhezuleixing:(NSString *)hezuleixing wihthhuxing:(NSString *)huxing withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withlianxiren:(NSString *)lianxiren withlouceng:(NSString *)louceng withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withpeizhi:(NSString *)peizhi withxiaoquname:(NSString *)xiaoquname withxinxilaiyuan:(NSString *)xinxilaiyuan withType:(void(^)(NSString *string))block{
    NSArray *keys = @[@"biaoti",@"dec_mianji",@"dec_zujin",@"dt_datetime",@"hezuleixing",@"huxing",@"img1",@"img2",@"img3",@"img4",@"img5",@"img6",@"img7",@"lianxiren",@"louceng",@"miaoshu",@"phone",@"quyu",@"peizhi",@"xiaoquname",@"xinxilaiyuan"];
    NSArray *objects = @[biaoti,dec_mianji,dec_zujin,dt_datetime,hezuleixing,huxing,img1,img2,img3,img4,img5,img6,img7,lianxiren,louceng,miaoshu,phone,quyu,peizhi,xiaoquname,xinxilaiyuan];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/house_zu_zhengzu_save.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//获取整租
+(void)parserZhengZuInfoWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString=@"http://zghrj.cn/interface/house_zu_zhengzu_select.php";
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block  HeZuInfo*heZuInfo;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    __block NSMutableArray *tempArr;
    tempArr =[NSMutableArray array];
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            heZuInfo =[HeZuInfo parseHeZuInfoWithDic:dic];
            [resumeArr addObject:heZuInfo];
        }
        for (HeZuInfo *heZuInfo in resumeArr) {
            if ([heZuInfo.hezuleixing isEqualToString:title]) {
                [tempArr addObject:heZuInfo];
            }
        }
        block(resumeArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//发布合租
+(void)sendHeZuWithbiaoti:(NSString *)biaoti withdec_mianji:(NSString *)dec_mianji  withdec_zujin:(NSString *)dec_zujin withdt_datetime:(NSString *)dt_datetime withhezuleixing:(NSString *)hezuleixing wihthhuxing:(NSString *)huxing withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withlianxiren:(NSString *)lianxiren withlouceng:(NSString *)louceng withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withpeizhi:(NSString *)peizhi withxiaoquname:(NSString *)xiaoquname withxinxilaiyuan:(NSString *)xinxilaiyuan withType:(void(^)(NSString *string))block{
    NSArray *keys = @[@"biaoti",@"dec_mianji",@"dec_zujin",@"dt_datetime",@"hezuleixing",@"huxing",@"img1",@"img2",@"img3",@"img4",@"img5",@"img6",@"img7",@"lianxiren",@"louceng",@"miaoshu",@"phone",@"quyu",@"peizhi",@"xiaoquname",@"xinxilaiyuan"];
    NSArray *objects = @[biaoti,dec_mianji,dec_zujin,dt_datetime,hezuleixing,huxing,img1,img2,img3,img4,img5,img6,img7,lianxiren,louceng,miaoshu,phone,quyu,peizhi,xiaoquname,xinxilaiyuan];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/house_zu_hezu_save.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//获取合租
+(void)parserHeZuInfoWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString=@"http://zghrj.cn/interface/house_zu_hezu_select.php";
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block  HeZuInfo*heZuInfo;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    __block NSMutableArray *tempArr;
    tempArr =[NSMutableArray array];
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            heZuInfo =[HeZuInfo parseHeZuInfoWithDic:dic];
            [resumeArr addObject:heZuInfo];
        }
        for (HeZuInfo *heZuInfo in resumeArr) {
            if ([heZuInfo.hezuleixing isEqualToString:title]) {
                [tempArr addObject:heZuInfo];
            }
        }
        block(resumeArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//求租发布
+(void)sendQiuZuWithbiaoti:(NSString *)biaoti withdec_qiwangzujin:(NSString *)dec_qiwangzujin  withdt_datetime:(NSString *)dt_datetime withhuxing:(NSString *)huxing withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withxinxilaiyuan:(NSString *)xinxilaiyuan withType:(void(^)(NSString *string))block{
    
    NSArray *keys = @[@"biaoti",@"dec_qiwangzujin",@"dt_datetime",@"huxing",@"lianxiren",@"miaoshu",@"phone",@"quyu",@"xinxilaiyuan"];
    NSArray *objects = @[biaoti,dec_qiwangzujin,dt_datetime,huxing,lianxiren,miaoshu,phone,quyu,xinxilaiyuan];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/house_zu_qiuzu_save.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//求租获取
+(void)parserQiuZuWithArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block QiuZuInfo *info;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    [manager GET:@"http://zghrj.cn/interface/house_zu_qiuzu_select.php" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            info =[QiuZuInfo parseQiuZhiInfoWithDic:dic];
            [resumeArr addObject:info];
        }
        block(resumeArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//日租短租发布
+(void)sendRiZuDuanZuWithbiaoti:(NSString *)biaoti withdec_zujin:(NSString *)dec_zujin  withdizhi:(NSString *)dizhi withdt_datetime:(NSString *)dt_datetime withduanzuleixing:(NSString *)duanzuleixing withfangwuleixing:(NSString *)fangwuleixing withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu vwithxinxilaiyuan:(NSString *)xinxilaiyuan withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withType:(void(^)(NSString *string))block{
    
    NSArray *keys = @[@"biaoti",@"dec_zujin",@"dizhi",@"dt_datetime",@"duanzuleixing",@"fangwuleixing",@"lianxiren",@"miaoshu",@"phone",@"quyu",@"xinxilaiyuan",@"img1",@"img2",@"img3",@"img4",@"img5",@"img6",@"img7"];
    NSArray *objects = @[biaoti,dec_zujin,dizhi,dt_datetime,duanzuleixing,fangwuleixing,lianxiren,miaoshu,phone,quyu,xinxilaiyuan,img1,img2,img3,img4,img5,img6,img7];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/house_zu_rizu_duanzu_save.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//日租短租获取
+(void)parserRiZuDuanZuWithArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block RiZuDuanZu *info;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    [manager GET:@"http://zghrj.cn/interface/house_zu_rizu_duanzu_select.php" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            info =[RiZuDuanZu parseRiZuInfoWithDic:dic];
            [resumeArr addObject:info];
        }
        block(resumeArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//商铺出租发布
+(void)sendShangPuChuZuWithbiaoti:(NSString *)biaoti withdec_zujin:(NSString *)dec_zujin  withdizhi:(NSString *)dizhi withdt_datetime:(NSString *)dt_datetime withdec_mianji:(NSString *)dec_mianji withgongxu:(NSString *)gongxu withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withshangpuleixing:(NSString *)shangpuleixing withxinxilaiyuan:(NSString *)xinxilaiyuan withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withType:(void(^)(NSString *string))block{
    
    NSArray *keys = @[@"biaoti",@"dec_mianji",@"dec_zujin",@"dizhi",@"dt_datetime",@"gongxu",@"lianxiren",@"miaoshu",@"phone",@"quyu",@"shangpuleixing",@"xinxilaiyuan",@"img1",@"img2",@"img3",@"img4",@"img5",@"img6",@"img7"];
    NSArray *objects = @[biaoti,dec_mianji,dec_zujin,dizhi,dt_datetime,gongxu,lianxiren,miaoshu,phone,quyu,shangpuleixing,xinxilaiyuan,img1,img2,img3,img4,img5,img6,img7];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/house_zu_shangpu_save.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//商铺出租获取
+(void)parserShangPuChuZuWithArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block HeZuInfo *info;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    [manager GET:@"http://zghrj.cn/interface/house_zu_shangpu_select.php" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            info =[HeZuInfo parseHeZuInfoWithDic:dic];
            [resumeArr addObject:info];
        }
        block(resumeArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//写字楼、厂房出租发布
+(void)sendXieZiLouChuZuWithbiaoti:(NSString *)biaoti withbiaozhi:(NSString *)biaozhi withdec_zujin:(NSString *)dec_zujin  withdizhi:(NSString *)dizhi withdt_datetime:(NSString *)dt_datetime withdec_mianji:(NSString *)dec_mianji withgongxu:(NSString *)gongxu withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withleixing:(NSString *)leixing withxinxilaiyuan:(NSString *)xinxilaiyuan withname:(NSString *)name withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withType:(void(^)(NSString *string))block{
    
    NSArray *keys = @[@"biaozhi",@"biaoti",@"dec_mianji",@"dec_zujin",@"dizhi",@"dt_datetime",@"gongxu",@"lianxiren",@"miaoshu",@"phone",@"quyu",@"leixing",@"xinxilaiyuan",@"name",@"img1",@"img2",@"img3",@"img4",@"img5",@"img6",@"img7"];
    NSArray *objects = @[biaozhi,biaoti,dec_mianji,dec_zujin,dizhi,dt_datetime,gongxu,lianxiren,miaoshu,phone,quyu,leixing,xinxilaiyuan,name,img1,img2,img3,img4,img5,img6,img7];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
    NSString *urlString=@"http://zghrj.cn/interface/house_zu_xiezilou_save.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block NSString *string;
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        string=[dic objectForKey:@"type"];
        block(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}
//写字楼、厂房出租获取
+(void)parserXieZiLouChuZuWtihTitle:(NSString *)biaozhi ithArr:(void(^)(NSMutableArray *resumeArr))block{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __block HeZuInfo *info;
    __block NSMutableArray *resumeArr;
    resumeArr =[NSMutableArray array];
    __block NSMutableArray *tempArr;
    tempArr =[NSMutableArray array];
    [manager GET:@"http://zghrj.cn/interface/house_zu_xiezilou_select.php" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            info =[HeZuInfo parseHeZuInfoWithDic:dic];
            [resumeArr addObject:info];
        }
        for (HeZuInfo *hezuInfo in resumeArr) {
            if ([hezuInfo.biaozhi isEqualToString:biaozhi]) {
                [tempArr addObject:hezuInfo];
            }
        }

        block(tempArr);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error====%@",error);
        }
    }];
}

@end
