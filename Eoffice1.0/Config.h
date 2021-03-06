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

/**加载nib文件*/
#define LOAD_NIB(_NibName_) [[NSBundle mainBundle] loadNibNamed:_NibName_ owner:nil options:nil][0]

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
#define COMMODITYMIDDLE @"%@product!getMidCategory.action?kind=%@"
#define MYGOTOSEE @"%@product!getMidCategory.action?"
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
#define SHOPCAR @"%@order!getBasket.action?userkey=%@"
#define SHOPCARTID @"%@order!referBasket.action?userkey=%@&cartIds=%@"
#define EDITORVERSION @"%@order!changeVersion.action?cartId=%@&goodsId=%@&count=%@"

#define CHANGECOUNT @"%@order!changeCount.action?cartId=%@&quantity=%@"

#define DELETESHOPCAR  @"%@order!removeBasket.action?cartId=%@"

//订单接口
#define ORDER @"%@order!getList.action?docstatus=-1&userkey=%@&page=%@"

#define DELETEORDER @"%@order!deleteOrder.action?orderId=%@"

#define SUREORDER @"%@order!goodsCommit.action?userkey=%@&goodsId=%@&count=%@&payway=%@&id=%@"

//phone/ordser!wbasketCommit.action?userkey=?&recommendCode=?&ids=?&payway=?&id=?&invoice=?total=?&remark=?

//收货地址
#define ADDRESS @"%@order!addressList.action?userkey=%@"
#define ADDRESSDELTE @"%@order!delAddress.action?id=%@"

#define ADDRESSDETAIL @"%@order!getAddressDetail.action?id=%@"
//增加地址

#define ADDRESSEDADD @"%@order!addAddress.action?userkey=%@"

#define CHANGEADDRESS @"%@order!updateAddress.action?userkey=%@"


#define  SELECTALL @"%@order!selectAll.action"

//退货原因
#define  RETUNGOODSEXPLAIN @"%@return!apply.action?userkey=%@&orderId=%@"
#define  BACKBEASON @"%@return!getReasonList.action?userkey=%@"
//默认地址设置
#define DEFAULTADDREDD  @"%@order!setDefalutAdress.action?id=%@&userkey=%@"


#define REGISTERVERIF @"%@sms!getPhoneSms.action"

#define ORDERCLASSIFY @"%@order!getList.action?userkey=%@&page=%@"

//信息反馈
#define FEEDBACK @"%@feedback!add.action;userkey=%@&content=%@"

#define  RETUNGOODSSTATE @"%@replace!returnStatus.action?userkey=%@&returnId=%@"

//个人信息
#define   PERSONCONME @"%@user!toUpdateMyMsg.action?userkey=%@"
#define   PERSONREVISE @"%@user!updateMyMsg.action?birthday=%@&sex=%@&nike=%@&userkey=%@&icon=%@"
#define   PERSONREVISENO @"%@user!updateMyMsg.action?birthday=%@&sex=%@&nike=%@&userkey=%@"
//安全设置
#define SAFEVALIDATE @"%@sms!getPhoneSms.action?userkey=%@"
#define SAFENEWPHONE @"%@user!updatePhone.action?userkey=%@"
#define SAFERIVESE @"%@user!updatePassword.action?userkey=%@"

//换货
#define  REPLACEEXPLAIN @"%@replace!getReasonList.action?userkey=%@"
#define  EXPLACE @"%@replace!apply.action?userkey=%@&orderId=%@"
//维修
#define  SERVICEREASON @"%@repair!getReasonList.action?userkey=%@"
#define  SERVICESUBMIT @"%@repair!apply.action?userkey=%@&orderId=%@"
//版本信息
#define PRODUCTMESSAGE @"%@product!selectedByVersion.action?goodsId=%@"
//提交商品生成订单
#define SUBMITORDER  @"%@order!referBasket.action?userkey=%@&cartIds=%@"
#define MONEYRECORD  @"%@user!returnRecord.action?userkey=%@"
#define MONEYDETAILED  @"%@user!cashDetails.action?userkey=%@"

#define ALLMONEYMESSAGE @"%@user!getReturnAll.action?userkey=%@"

#define ADDBANKCARD  @"%@user!addBand.action?userkey=%@&name=%@&bankName=%@&bankNo=%@&bankAddress=%@"

#define BANKCARDLIST @"%@user!getBand.action?userkey=%@"

#define APPLYFOR @"%@user!amount.action?"

#define DELEGATEBANKCARD @"%@user!delBand.action?userkey=%@&id=%@"
//申请提现：phone/user!amount.action?userkey=?&rand=?&phone=?&id=?&amount=?
//返现记录 phone/user!returnRecord.action?userkey=?
//提现明细 phone/user!cashDetails.action?userkey=?
//进入提现页面：phone/user!getBand.action?userkey=?
//增加银行卡界面：phone/user!addBand.action?userkey=?&name=?&bankName=?&bankNo=?&bankAddress=?

//推荐返现：phone/user!getRecom.action?userkey=?
//删除银行卡：phone/user!delBand.action?userkey=?&id=?

//推荐返现
#define RECOMMENBACKMONEY @"%@user!getRecom.action?userkey=%@"

//上传头像
#define UPLOADPHOTO @"%@userImg.action"

#define VERSION @"%@product!getAppVersions.action"

#define HOMECAROUSEL @"%@product!adBanner.action"


#endif
