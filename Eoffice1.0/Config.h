//
//  Config.h
//  EOffice
//
//  Created by gyz on 15/7/7.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#ifndef EOffice_Config_h
#define EOffice_Config_h
#define IMAGEVIEW_MYSELF(string) [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForAuxiliaryExecutable:string]]]
#define IMAGEVIEW_MYSELF_WEB(string) [[UIImageView alloc] initWithImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:string]]]];

#define IMAGE_MYSELF(string) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForAuxiliaryExecutable:string]]

#define widgetFrameX(widget) widget.frame.origin.x
#define widgetFrameY(widget) widget.frame.origin.y
#define widgetBoundsWidth(widget) widget.bounds.size.width
#define widgetboundsHeight(widget) widget.bounds.size.height
//#define WEB_IMAGE_URL(suffFix) [NSString stringWithFormat:@"http://192.168.254.68/%@", suffFix]
#define colorWithRGB(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]

#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

#define IOS_7_VERSION (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))
#define IOS_8_VERSION (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))

#define IOS_4R_IMG ((SCREEN_HEIGHT > 480)? (YES):(NO))
//登录界面
#define CHECK_IMG_VIEW 1000
#define NAME_FIELD 1005
#define PASSWORD_FIELD 1010
#define LOGIN_BTN 1015
#define NAME_ICON 1020
#define PASSWORD_ICON 1025
#define SET_TXT 1030

//用户登录接口
#define LOGIN @"http://192.168.0.65:8080/eoffice/phone/user!Login.action?username=%@&password=%@"

//用户注册接口
#define REGISTER @"http://192.168.0.65:8080/eoffice/phone/user!Register.action?username=TTTTT&password=test"

//商品
#define COMMODITYMIDDLE @"http://192.168.0.65:8080/eoffice/phone/product!getMidCategory.action"
//商品详情
#define MAINTAINDETAIL @"http://192.168.0.65:8080/eoffice/phone/order!addBasket.action;jsessionid=%@?userkey=%@&goodsId=%@"
#define MAINTAINSORTSSMART @"http://192.168.0.65:8080/eoffice/phone/product!getSubCategory.action?cartId=%@"

#define MAINTAINSORTS @"http://192.168.0.65:8080/eoffice/phone/product!getMidCategory.action"

#define MAINTAIN @"http://192.168.0.65:8080/eoffice/phone/product!getSubCategory.action?cartId=%@"

//电脑
#define COMPUTER @"http://192.168.0.65:8080/eoffice/phone/product!getMidGoodsList.action?cartId=%@&page=0"
//购物车接口
#define SHOPCAR @"http://192.168.0.65:8080/eoffice/phone/order!getBasket.action;jsessionid=%@?userkey=%@"

#define DELETESHOPCAR  @"http://192.168.0.65:8080/eoffice/phone/order!removeBasket.action?cartId=%@"

//订单接口
#define ORDER @"http://192.168.0.65:8080/eoffice/phone/order!getList.action;jsessionid=%@?userkey=%@"

#define DELETEORDER @"http://192.65.0.65:8080/eoffice/phone/order!deleteOrder.action?orderId=%@"

//收货地址
#define ADDRESS @"http://192.168.0.65:8080/eoffice/phone/order!addressList.action;jsessionid=%@?userkey=%@"
#define ADDRESSDELTE @"http://192.168.0.65:8080/eoffice/phone/order!delAddress.action?id=%@"

#define ADDRESSDETAIL @"http://192.168.0.65:8080/eoffice/phone/order!getAddressDetail.action?id=%@"

//退货原因
#define  RETUNGOODSEXPLAIN @"http://192.168.0.65:8080/eoffice/phone/return!apply.action;jsessionid=%@?userkey=%@&orderId=%@"
#define  BACKBEASON @"http://192.168.0.65:8080/eoffice/phone/return!getReasonList.action;jsessionid=%@?userkey=%@"

#define  RETUNGOODSSTATE @"http://192.168.0.65:8080/eoffice/phone/replace!returnStatus.action;jsessionid=%@?userkey=%@&returnId=%@"

//个人信息
#define   PERSONCONME @"http://192.168.0.65:8080/eoffice/phone/user!toUpdateMyMsg.action;jsessionid=%@?userkey=%@"
#define   PERSONREVISE @"http://192.168.0.65:8080/eoffice/phone/user!updateMyMsg.action;jsessionid=%@?userkey=%@"

//安全设置
#define SAFEVALIDATE @"http://192.168.0.65:8080/eoffice/phone/sms!getPhoneSms.action;jsessionid=%@?userkey=%@"

//信息反馈
#define FEEDBACK @"http://192.168.0.65:8080/eoffice/phone/feedback!add.action;jsessionid=%@?userkey=%@"


#endif
