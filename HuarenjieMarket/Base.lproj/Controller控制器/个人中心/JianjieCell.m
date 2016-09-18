//
//  JianjieCell.m
//  PhoneCallBack
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 com.hjl. All rights reserved.
//

#import "JianjieCell.h"

@implementation JianjieCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setCell{

    self.text1.text=@"  河南华人街电子商务有限公司注册资金6100万元。公司顺应时代发展潮流，紧跟“互联网+”战略，为中小企业和个人研发属于自己的APP功能品牌，开创了“互联网+”发展新局面。公司自营平台主营服装，鞋帽，化妆品，日用品，电子产品等，信息服务，同时亦提供团购、电子会员卡及餐厅预订等O2O（Online To Offline）交易服务，把O2O（Online To Offline）（在线离线/线上到线下），网络电话，技紧密结合，把互联网和包括传统行业在内的各行各业结合起来，在新的领域创造一种新的生态。";
    self.text2.text=@"打电话，话费充值，制作电话充值卡。\n聊天功能。（像QQ微信一样聊天，建群，发红包，搜索附近的人等等）\n商城购物，开设网店，手机打理店铺。（像淘宝京东一样开网店，网上购物，用手机管理店铺\n搜索附近店铺团购。（像美团大众点评一样团购餐饮美食，电影票等等\n中介功能。（像赶集58同城一样二手物品交易，投简历找工作，租房子，买二手商铺二手房等等）\n上传视频搜索视频功能。（像优酷，爱奇艺一样上传或观看好玩的视频等等）\n";
    self.text3.text=@"  任何品牌都想要做大做强都需要招聘代理商，\n代理商市场价格由您自己决定，（给你的系统是主系统，你可以无限开分系统）\n招代理好处：\n1、净赚代理费\n2、赚充值卡差价\n3、帮你宣传品牌让你更好招代理\n4、帮你提高下载量让你的广告位更值钱。";
    self.text4.text=@"  您可以把手机充值卡批发给商家，现在实体店为扩大营业额经常会做活动，把面值100的充值卡以5元至10元的价格批发给商家，让商家做活动赠送，您可以在充值卡的页面上为商家打广告，商家批发量超过1000张，您还可以在自己的平台（APP）上免费赠送商家网店或是广告位。";
    self.text5.text=@"  你可以在当地找商家店铺入驻平台（例如，酒店，服装点，饭店等）。每个商家每月收取200元费用（包括一个免费网店和一个月免费广告），你在所在的城市招200家店铺入驻平台，收取费用就是40000元，减去公司成本费用后，你此项利润每月在20000元至30000元之间。";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
