//
//  QJHttpTools.h
//  Lawyer
//
//  Created by MYMAc on 2017/8/7.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJHttpTools : NSObject


#define SetColor(a) [UIColor colorWithHex:a]

#define MainYellowColor [UIColor colorWithHex:0xEAA431]

////服务器 正式版
#define MainUrl @"http://www.huirongfa.com/App/Index/api"
//图片
#define ImageUrl @"http://www.huirongfa.com/"
////服务器 正式版
//#define MainUrl @"http://192.168.0.5/App/Index/api"
////图片
//#define ImageUrl @"http://192.168.0.5/"
////
//
//服务器  测试
//#define MainUrl @"http://122.114.208.180:92/App/Index/api"
////图片
//#define ImageUrl @"http://122.114.208.180:92/"



// 接口目录

#pragma   mark    首页接口
// 首页轮播图
#define QJMainBanner     [dic setValue:@"App/Public/banner" forKey:@"action"];
// 首页接口
#define QJMainPageData     [dic setValue:@"App/User/getTuiLawyer" forKey:@"action"];

//查看律师详情
#define Userlawxq [dic setValue:@"App/User/lawxq" forKey:@"action"];

#pragma   mark    发现接口


#pragma   mark    资讯接口
//资讯接口
#define QJNEW     [dic setValue:@"App/News/index" forKey:@"action"];
//资讯的分类
#define QJNEWGETCATE     [dic setValue:@"App/News/getcate" forKey:@"action"];
// 资讯详情
#define INFODETAIL  @"/Wap/News/info/id"


#pragma   mark    我的接口

// 注册 获取 验证码
#define GETCODE     [dic setValue:@"Base/User/user_get_code" forKey:@"action"];

// 注册接口
#define REGIST     [dic setValue:@"Base/User/user_reg" forKey:@"action"];

// 登陆接口
#define QJLOGION     [dic setValue:@"Base/User/user_login" forKey:@"action"];

// 忘记密码 获取验证码 Base/User/user_find_code
#define QJFINDCODE     [dic setValue:@"Base/User/user_find_code" forKey:@"action"];

// 忘记密码  Base/User/find_user_password
#define QJFINDPASS    [dic setValue:@"Base/User/find_user_password" forKey:@"action"];


// 我的套餐 App/User/wdtc
#define QJWDTC    [dic setValue:@"App/User/wdtc" forKey:@"action"];
//vip 会员
#define VIPTAOCAN    [dic setValue:@"App/User/getVip" forKey:@"action"];
//vip 下订单
// VIP 余额支付 App/OtherPay/suit_pay
#define QjVIPSUIT_PAY    [dic setValue:@"App/OtherPay/suit_pay" forKey:@"action"];

// 余额支付 聘用律师
#define QjVIPSUITYUEPay    [dic setValue:@"App/User/yuepay" forKey:@"action"];


#define VIpOrder    [dic setValue:@"App/User/buySuit" forKey:@"action"];
//我的咨询
#define QJZIXUN    [dic setValue:@"App/User/zixun" forKey:@"action"];
// 我的咨询评论
#define QJPINGJIA    [dic setValue:@"App/User/zx_pingjia" forKey:@"action"];


//用户信息App/User/editUser
#define QJeditUser    [dic setValue:@"App/User/editUser" forKey:@"action"];
// 编辑 用户信息
#define QJDOUser    [dic setValue:@"App/User/doUser" forKey:@"action"];
//w我的预约
#define  BOOKLIST    [dic setValue:@"App/User/bookList" forKey:@"action"];
//我的关注
#define  MYGUANZHU    [dic setValue:@"App/User/guanzhu" forKey:@"action"];
//意见反馈 App/User/suges
#define  QJAddvice    [dic setValue:@"App/User/suges" forKey:@"action"];
//我的需求  App/User/wdxq
#define  QJWDXQ    [dic setValue:@"App/User/wdxq" forKey:@"action"];
// 我的需求 抢单律师 列表App/User/getLawyerList
#define  QJGETLAWYERLIST   [dic setValue:@"App/User/getLawyerList" forKey:@"action"];
//我的需求 抢单律师
#define  DOOPEARE   [dic setValue:@"App/User/doOpeare" forKey:@"action"];



//   历史记录     消费记录
#define  QJXIAOFEI    [dic setValue:@"App/User/cousumeList" forKey:@"action"];
//   历史记录 -    咨询记录  App/User/consultList
#define  QJZIXUNLIST   [dic setValue:@"App/User/consultList" forKey:@"action"];
// 常见问题
#define  QJCQUESTION   [dic setValue:@"App/User/question" forKey:@"action"];
//服务支付 获取信息
#define  ShowPay   [dic setValue:@"App/Consult/showPay" forKey:@"action"];
// 服务支付获取支付信息 App/OtherPay/showBook
#define  QJShowBooK   [dic setValue:@"App/OtherPay/showBook" forKey:@"action"];
// vip 支付 获取信息 接口App/User/showOrder
#define  QJShowVIPOrder  [dic setValue:@"App/User/showOrder" forKey:@"action"];

//余额支付  案件委托 发律师函 合同审查 代写文书 ——余额支付  App/OtherPay/money_pay
#define  QJMoney_Pay   [dic setValue:@"App/OtherPay/money_pay" forKey:@"action"];
//套餐次数支付  App/OtherPay/numberPay
#define  QJNumber_Pay   [dic setValue:@"App/OtherPay/numberPay" forKey:@"action"];


// 余额支付  法律咨询——余额or次数 支付方法 App/OtherPay/changInfoStatus
#define  QJChangInfoSTARUS   [dic setValue:@"App/OtherPay/changInfoStatus" forKey:@"action"];
//     律师预约余额 次数支付
#define  QJChangInforSTATUS   [dic setValue:@"App/OtherPay/changInforSatatus" forKey:@"action"];
// 充值微信支付
#define  WXPreCharge   [dic setValue:@"App/User/reCharge" forKey:@"action"];
//预约微信支付
#define  WXYYCharge   [dic setValue:@"App/Pay/yyPay" forKey:@"action"];
// 咨询 微信支付
#define  WXZXCharge   [dic setValue:@"App/Pay/zxPay" forKey:@"action"];
//  微信支付 法律服务
#define  WXServicePay   [dic setValue:@"App/Pay/serverPay" forKey:@"action"];
//微信支付 购买套餐；
#define  WXSuitPay   [dic setValue:@"App/Pay/suitPay" forKey:@"action"];
//微信支付聘用律师支付
#define  WXLawyerPay   [dic setValue:@"App/Pay/lawyerPay" forKey:@"action"];






@end
