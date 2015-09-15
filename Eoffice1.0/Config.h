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

//用户注册界面
#define VERIFICATION 1010

//用户登录接口
#define LOGIN @"http://192.168.0.65:8080/eoffice/phone/user!Login.action?username=%@&password=%@"

//用户注册接口
#define REGISTER @"http://192.168.0.65:8080/eoffice/phone/user!Register.action?username=TTTTT&password=test"
#define REGISTERMASSAGE @"http://192.168.0.65:8080/eoffice/phone/sms!getPhoneSms.action?phoneNo=%@"

//
#define OFFICE @"http://192.168.0.65:8080/eoffice/";

//商品
#define COMMODITYMIDDLE @"http://192.168.0.65:8080/eoffice/phone/product!getMidCategory.action"
//商品详情
#define MAINTAINDETAIL @"http://192.168.0.65:8080/eoffice/phone/product!getGoodsDetail.action?paraId=%@&goodsId=%@&cPartnerId=%@"
#define ADDMAINTAIN @"http://192.168.0.65:8080/eoffice/phone/order!addBasket.action?userkey=%@&goodsId=%@&count=%@"
#define MAINTAINSORTSSMART @"http://192.168.0.65:8080/eoffice/phone/product!getSubCategory.action?cartId=%@"

#define MAINTAINSORTS @"http://192.168.0.65:8080/eoffice/phone/product!getMidCategory.action"

#define MAINTAIN @"http://192.168.0.65:8080/eoffice/phone/product!getSubCategory.action?cartId=%@"

#define PARAMETER @"http://192.168.0.65:8080/eoffice/phone/product!getParameters.action?paraId=%@"

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
//增加地址
#define ADDRESSEDADD @"http://192.168.0.65:8080/eoffice/phone/order!addAddress.action?address=%@&telPhone=%@&receiver=%@&post=%@&id=%@"
//退货原因
#define  RETUNGOODSEXPLAIN @"http://192.168.0.65:8080/eoffice/phone/return!apply.action;jsessionid=%@?userkey=%@&orderId=%@"
#define  BACKBEASON @"http://192.168.0.65:8080/eoffice/phone/return!getReasonList.action;jsessionid=%@?userkey=%@"
//默认地址设置
#define DEFAULTADDREDD  @"http://192.168.0.65:8080/eoffice/phone/order!setDefalutAdress.action;id=%@?userkey=%@"


#define REGISTERVERIF @"http://192.168.0.65:8080/eoffice/phone/sms!getPhoneSms.action"

#define ORDERCLASSIFY @"http://192.168.0.65:8080/eoffice/phone/order!getList.action;jsessionid=%@?userkey=%@"

//信息反馈
#define FEEDBACK @"http://192.168.0.65:8080/eoffice/phone/feedback!add.action;jsessionid=%@?userkey=%@"

#define  RETUNGOODSSTATE @"http://192.168.0.65:8080/eoffice/phone/replace!returnStatus.action;jsessionid=%@?userkey=%@&returnId=%@"

//个人信息
#define   PERSONCONME @"http://192.168.0.65:8080/eoffice/phone/user!toUpdateMyMsg.action;jsessionid=%@?userkey=%@"
#define   PERSONREVISE @"http://192.168.0.65:8080/eoffice/phone/user!updateMyMsg.action;jsessionid=%@?userkey=%@"
//安全设置
#define SAFEVALIDATE @"http://192.168.0.65:8080/eoffice/phone/sms!getPhoneSms.action;jsessionid=%@?userkey=%@"
#define SAFENEWPHONE @"http://192.168.0.65:8080/eoffice/phone/user!updatePhone.action;jsessionid=%@?userkey=%@"
#define SAFERIVESE @"http://192.168.0.65:8080/eoffice/phone/user!updatePassword.action;jsessionid=%@?userkey=%@"

//换货
#define  REPLACEEXPLAIN @"http://192.168.0.65:8080/eoffice/phone/replace!getReasonList.action;jsessionid=%@?userkey=%@"
#define  EXPLACE @"http://192.168.0.65:8080/eoffice/phone/replace!apply.action;jsessionid=%@?userkey=%@&orderId=%@"
//维修
#define  SERVICEREASON @"http://192.168.0.65:8080/eoffice/phone/repair!getReasonList.action;jsessionid=%@?userkey=%@"
#define  SERVICESUBMIT @"http://192.168.0.65:8080/eoffice/phone/repair!apply.action;jsessionid=%@?userkey=%@&orderId=%@"
#endif
