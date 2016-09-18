//
//  AFHttpManager.h
//  temp
//
//  Created by l x on 16/5/26.
//  Copyright © 2016年 wangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFHttpManager : NSObject
//发布简历
+(void)sendResumeWithBiaoZhi:(NSString *)biaoZhi withBirthday:(NSString *)birthday withEmail:(NSString *)email withFabutime:(NSString *)fabutime withgongzuonianxian:(NSString *)gongzuonianxian withgongzuoquyu:(NSString *)gongzuoquyu withgongzuoshijian:(NSString *)gongzuoshijian withjiaxiang:(NSString *)jiaxiang withname:(NSString *)name withphone:(NSString *)phone withqiuzhixuanyan:(NSString *)qiuzhixuanyan withqiwangrixin:(NSString *)qiwangrixin withsalary:(NSString *)salary withsex:(NSString *)sex withtouxiang:(NSData *)touxiang withxueli:(NSString *)xueli withzhiwei:(NSString *)zhiwei withType:(void(^)(NSString *string))block;
//获取简历
+(void)parserResumeInfoWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block;
//发布二手汽车
+(void)sendCarResumeWithbiaoti:(NSString *)biaoti withbrand:(NSString *)brand withcolor:(NSString *)color withimage1:(NSData *)image1 withimage2:(NSData *)image2 withimage3:(NSData *)image3 withimage4:(NSData *)image4 withimage5:(NSData *)image5 withimage6:(NSData *)image6 withimage7:(NSData *)image7 withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withplace:(NSString *)place withprice:(NSString *)price withshangpaidate:(NSString *)shangpaidate withxingshilicheng:(NSString *)xingshilicheng withType:(void(^)(NSString *string))block;
//获取二手车
+(void)parserCarInfoWithArr:(void(^)(NSMutableArray *resumeArr))block;
//发布二手摩托、自行车等
+(void)sendBikeResumeWithbiaoti:(NSString *)biaoti withgongxubiaozhi:(NSString *)gongxubiaozhi  withimage1:(NSData *)image1 withimage2:(NSData *)image2 withimage3:(NSData *)image3 withimage4:(NSData *)image4 withimage5:(NSData *)image5 withimage6:(NSData *)image6 withimage7:(NSData *)image7 withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone  withprice:(NSString *)price withquyu:(NSString *)quyu withzhonglei:(NSString *)zhonglei withType:(void(^)(NSString *string))block;
//获取二手摩托、自行车等
+(void)parserBikeInfoWithArr:(void(^)(NSMutableArray *resumeArr))block;
//发布全职招聘信息
+(void)sendFullTimeWitharea:(NSString *)area withdec_yuexin:(NSString *)dec_yuexin  withdt_datetime:(NSString *)dt_datetime withgongzuodidian:(NSString *)gongzuodidian withgongzuonianxian:(NSString *)gongzuonianxian withi_zhaopinrenshu:(NSString *)i_zhaopinrenshu withlianxiren:(NSString *)lianxiren withnianlingduan:(NSString *)nianlingduan withphone:(NSString *)phone withtitle:(NSString *)title withxueli:(NSString *)xueli withzhiweimiaoshu:(NSString *)zhiweimiaoshu withzhiwei:(NSString *)zhiwei withgongsiname:(NSString *)gongsiname withshisufuli:(NSString *)shisufuli withshehuifuli:(NSString *)shehuifuli withqitafuli:(NSString *)qitafuli withguimo:(NSString *)guimo withgongsijianjie:(NSString *)gongsijianjie withType:(void(^)(NSString *string))block;
//获取全职招聘信息
+(void)parserFullTimeWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block;
//发布兼职招聘信息
+(void)sendPartTimeWitharea:(NSString *)area withdec_xinzi:(NSString *)dec_xinzi  withdt_datetime:(NSString *)dt_datetime withgongsijianjie:(NSString *)gongsijianjie withgongsiname:(NSString *)gongsiname withgongzuodidian:(NSString *)gongzuodidian withgongzuonianxian:(NSString *)gongzuonianxian withgongzuoshijian:(NSString *)gongzuoshijian withguimo:(NSString *)guimo withi_zhaopinrenshu:(NSString *)i_zhaopinrenshu withlianxiren:(NSString *)lianxiren withnianlingduan:(NSString *)nianlingduan withphone:(NSString *)phone withqitafuli:(NSString *)qitafuli withshisufuli:(NSString *)shisufuli withshehuifuli:(NSString *)shehuifuli withtitle:(NSString *)title withxueli:(NSString *)xueli withzhiwei:(NSString *)zhiwei withzhiweimiaoshu:(NSString *)zhiweimiaoshu withType:(void(^)(NSString *string))block;
//获取兼职招聘信息
+(void)parserPartTimeWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block;
//发布二手物品
+(void)sendErShouGoodsWithdec_jiage:(NSString *)dec_jiage withdt_datetime:(NSString *)dt_datetime  withfenlei:(NSString *)fenlei withgongxu:(NSString *)gongxu withimagedata1:(NSData *)imagedata1 withimagedata2:(NSData *)imagedata2 withimagedata3:(NSData *)imagedata3 withimagedata4:(NSData *)imagedata4 withimagedata5:(NSData *)imagedata5 withimagedata6:(NSData *)imagedata6 withimagedata7:(NSData *)imagedata7 withlaiyuan:(NSString *)laiyuan withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withtitle:(NSString *)title withType:(void(^)(NSString *string))block;
//按关键字获取二手物品
+(void)parserErShouGoodsWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block;
//二手房求购发布
+(void)sendErShouFangQiuGouWithdec_qiwangprice:(NSString *)dec_qiwangprice withdt_datetime:(NSString *)dt_datetime  withhuxing:(NSString *)huxing withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withqiwangxiaoqu:(NSString *)qiwangxiaoqu withquyu:(NSString *)quyu withtitle:(NSString *)title withxinxilaiyuan:(NSString *)xinxilaiyuan withType:(void(^)(NSString *string))block;
//二手房求购获取
+(void)parserErShouFangQiuGouWithUrlString:(NSString *)urlString withArr:(void(^)(NSMutableArray *resumeArr))block;
//发布二手房出售
+(void)sendErShouFangChuShouWithchaoxiang:(NSString *)chaoxiang withdec_fangling:(NSString *)dec_fangling  withdec_mianji:(NSString *)dec_mianji withdec_price:(NSString *)dec_price withdt_datetime:(NSString *)dt_datetime wihthhuxing:(NSString *)huxing withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withlianxiren:(NSString *)lianxiren withlouceng:(NSString *)louceng withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withtitle:(NSString *)title withxiaoqu:(NSString *)xiaoqu withxinxilaiyuan:(NSString *)xinxilaiyuan withType:(void(^)(NSString *string))block;
//二手房出售获取
+(void)parserErShouFangChuShouWithUrlString:(NSString *)urlString withArr:(void(^)(NSMutableArray *resumeArr))block;
//商铺出售发布
+(void)sendShangPuChuShouWithbiaozhi:(NSString *)biaozhi withdec_mianji:(NSString *)dec_mianji  withdec_price:(NSString *)dec_price withdizhi:(NSString *)dizhi withdt_datetime:(NSString *)dt_datetime wihthgongxu:(NSString *)gongxu withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withleixing:(NSString *)leixing withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withtitle:(NSString *)title withxinxilaiyuan:(NSString *)xinxilaiyuan withType:(void(^)(NSString *string))block;
//获取商铺出售
+(void)parserShangPuInfoWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block;
//发布新房出售
+(void)sendNewHouseChuShouWithchaoxiang:(NSString *)chaoxiang withzhuangxiu:(NSString *)zhuangxiu  withdec_mianji:(NSString *)dec_mianji withdec_price:(NSString *)dec_price withdt_datetime:(NSString *)dt_datetime wihthhuxing:(NSString *)huxing withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withlianxiren:(NSString *)lianxiren withlouceng:(NSString *)louceng withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withtitle:(NSString *)title withxiaoqu:(NSString *)xiaoqu withxinxilaiyuan:(NSString *)xinxilaiyuan withType:(void(^)(NSString *string))block;
//获取新房出售
+(void)parserNewHouseChuShouInfoWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block;
//发布整租
+(void)sendZhengZuWithbiaoti:(NSString *)biaoti withdec_mianji:(NSString *)dec_mianji  withdec_zujin:(NSString *)dec_zujin withdt_datetime:(NSString *)dt_datetime withhezuleixing:(NSString *)hezuleixing wihthhuxing:(NSString *)huxing withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withlianxiren:(NSString *)lianxiren withlouceng:(NSString *)louceng withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withpeizhi:(NSString *)peizhi withxiaoquname:(NSString *)xiaoquname withxinxilaiyuan:(NSString *)xinxilaiyuan withType:(void(^)(NSString *string))block;
//获取整租
+(void)parserZhengZuInfoWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block;
//发布合租
+(void)sendHeZuWithbiaoti:(NSString *)biaoti withdec_mianji:(NSString *)dec_mianji  withdec_zujin:(NSString *)dec_zujin withdt_datetime:(NSString *)dt_datetime withhezuleixing:(NSString *)hezuleixing wihthhuxing:(NSString *)huxing withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withlianxiren:(NSString *)lianxiren withlouceng:(NSString *)louceng withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withpeizhi:(NSString *)peizhi withxiaoquname:(NSString *)xiaoquname withxinxilaiyuan:(NSString *)xinxilaiyuan withType:(void(^)(NSString *string))block;
//获取合租
+(void)parserHeZuInfoWithTitle:(NSString *)title withArr:(void(^)(NSMutableArray *resumeArr))block;
//求租发布
+(void)sendQiuZuWithbiaoti:(NSString *)biaoti withdec_qiwangzujin:(NSString *)dec_qiwangzujin  withdt_datetime:(NSString *)dt_datetime withhuxing:(NSString *)huxing withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withxinxilaiyuan:(NSString *)xinxilaiyuan withType:(void(^)(NSString *string))block;
//求租获取
+(void)parserQiuZuWithArr:(void(^)(NSMutableArray *resumeArr))block;
//日租短租发布
+(void)sendRiZuDuanZuWithbiaoti:(NSString *)biaoti withdec_zujin:(NSString *)dec_zujin  withdizhi:(NSString *)dizhi withdt_datetime:(NSString *)dt_datetime withduanzuleixing:(NSString *)duanzuleixing withfangwuleixing:(NSString *)fangwuleixing withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu vwithxinxilaiyuan:(NSString *)xinxilaiyuan withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withType:(void(^)(NSString *string))block;
//日租短租获取
+(void)parserRiZuDuanZuWithArr:(void(^)(NSMutableArray *resumeArr))block;
//商铺出租发布
+(void)sendShangPuChuZuWithbiaoti:(NSString *)biaoti withdec_zujin:(NSString *)dec_zujin  withdizhi:(NSString *)dizhi withdt_datetime:(NSString *)dt_datetime withdec_mianji:(NSString *)dec_mianji withgongxu:(NSString *)gongxu withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withshangpuleixing:(NSString *)shangpuleixing withxinxilaiyuan:(NSString *)xinxilaiyuan withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withType:(void(^)(NSString *string))block;
//商铺出租获取
+(void)parserShangPuChuZuWithArr:(void(^)(NSMutableArray *resumeArr))block;
//写字楼、厂房出租发布
+(void)sendXieZiLouChuZuWithbiaoti:(NSString *)biaoti withbiaozhi:(NSString *)biaozhi withdec_zujin:(NSString *)dec_zujin  withdizhi:(NSString *)dizhi withdt_datetime:(NSString *)dt_datetime withdec_mianji:(NSString *)dec_mianji withgongxu:(NSString *)gongxu withlianxiren:(NSString *)lianxiren withmiaoshu:(NSString *)miaoshu withphone:(NSString *)phone withquyu:(NSString *)quyu withleixing:(NSString *)leixing withxinxilaiyuan:(NSString *)xinxilaiyuan withname:(NSString *)name withimg1:(NSData *)img1 withimg2:(NSData *)img2 withimg3:(NSData *)img3 withimg4:(NSData *)img4 withimg5:(NSData *)img5 withimg6:(NSData *)img6 withimg7:(NSData *)img7 withType:(void(^)(NSString *string))block;
//写字楼、厂房出租获取
+(void)parserXieZiLouChuZuWtihTitle:(NSString *)biaozhi ithArr:(void(^)(NSMutableArray *resumeArr))block;
@end
