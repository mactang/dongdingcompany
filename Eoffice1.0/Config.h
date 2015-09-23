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

#define COMMON @"http://120.26.124.171/phone/"
//#define COMMON @"http://192.168.0.65:8080/phone/"

#define OFFICE @"http://121.43.193.193"

//用户登录接口
#define LOGIN @"%@user!Login.action?username=%@&password=%@"

//用户注册接口
#define REGISTER @"%@user!Register.action?username=TTTTT&password=test"
#define REGISTERMASSAGE @"%@sms!getPhoneSms.action?phoneNo=%@"



//商品
#define COMMODITYMIDDLE @"%@product!getMidCategory.action"
//商品详情
#define MAINTAINDETAIL @"%@product!getGoodsDetail.action?paraId=%@&goodsId=%@&cPartnerId=%@"
#define ADDMAINTAIN @"%@order!addBasket.action?userkey=%@&goodsId=%@&count=%@"
#define MAINTAINSORTSSMART @"%@product!getSubCategory.action?cartId=%@"

#define MAINTAINSORTS @"%@product!getMidCategory.action"

#define MAINTAIN @"%@product!getSubCategory.action?cartId=%@"

#define PARAMETER @"%@product!getParameters.action?paraId=%@"

//电脑
#define COMPUTER @"%@product!getMidGoodsList.action?cartId=%@&page=%@"

//购物车接口
#define SHOPCAR @"%@order!getBasket.action;jsessionid=%@?userkey=%@"
#define SHOPCARTID @"%@order!referBasket.action?userkey=%@&cartIds=%@"
#define EDITORVERSION @"%@order!changeVersion.action?cartId=%@&goodsId=%@&count=%@"


#define DELETESHOPCAR  @"%@order!removeBasket.action?cartId=%@"

//订单接口
#define ORDER @"%@order!getList.action?docstatus=-1&userkey=%@"

#define DELETEORDER @"%@order!deleteOrder.action?orderId=%@"

#define SUREORDER @"%@order!goodsCommit.action?userkey=%@&goodsId=%@&count=%@&payway=%@&id=%@"

//收货地址
#define ADDRESS @"%@order!addressList.action;jsessionid=%@?userkey=%@"
#define ADDRESSDELTE @"%@order!delAddress.action?id=%@"

#define ADDRESSDETAIL @"%@order!getAddressDetail.action?id=%@"
//增加地址

#define ADDRESSEDADD @"%@order!addAddress.action?userkey=%@"

#define CHANGEADDRESS @"%@order!updateAddress.action?userkey=%@"


#define  SELECTALL @"%@order!selectAll.action"

//退货原因
#define  RETUNGOODSEXPLAIN @"%@return!apply.action;jsessionid=%@?userkey=%@&orderId=%@"
#define  BACKBEASON @"%@return!getReasonList.action;jsessionid=%@?userkey=%@"
//默认地址设置
#define DEFAULTADDREDD  @"%@order!setDefalutAdress.action;id=%@?userkey=%@"


#define REGISTERVERIF @"%@sms!getPhoneSms.action"

#define ORDERCLASSIFY @"%@order!getList.action;jsessionid=%@?userkey=%@"

//信息反馈
#define FEEDBACK @"%@feedback!add.action;jsessionid=%@?userkey=%@"

#define  RETUNGOODSSTATE @"%@replace!returnStatus.action;jsessionid=%@?userkey=%@&returnId=%@"

//个人信息
#define   PERSONCONME @"%@user!toUpdateMyMsg.action;jsessionid=%@?userkey=%@"
#define   PERSONREVISE @"%@user!updateMyMsg.action?birthday=%@&sex=%@&nike=%@&userkey=%@"
//安全设置
#define SAFEVALIDATE @"%@sms!getPhoneSms.action;jsessionid=%@?userkey=%@"
#define SAFENEWPHONE @"%@user!updatePhone.action;jsessionid=%@?userkey=%@"
#define SAFERIVESE @"%@user!updatePassword.action;jsessionid=%@?userkey=%@"

//换货
#define  REPLACEEXPLAIN @"%@replace!getReasonList.action;jsessionid=%@?userkey=%@"
#define  EXPLACE @"%@replace!apply.action;jsessionid=%@?userkey=%@&orderId=%@"
//维修
#define  SERVICEREASON @"%@repair!getReasonList.action;jsessionid=%@?userkey=%@"
#define  SERVICESUBMIT @"%@repair!apply.action;jsessionid=%@?userkey=%@&orderId=%@"
//版本信息
#define PRODUCTMESSAGE @"%@product!selectedByVersion.action?goodsId=%@"
//提交商品生成订单
#define SUBMITORDER  @"%@order!referBasket.action?userkey=%@&cartIds=%@"
#endif
