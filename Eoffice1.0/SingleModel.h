//
//  SingleModel.h
//  Eoffice1.0
//
//  Created by gyz on 15/8/6.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleModel : NSObject

@property(nonatomic,strong)NSString *ids;
@property(nonatomic,strong)NSString *userkey;
@property(nonatomic,strong)NSString *jsessionid;
@property(nonatomic,strong)NSString *wGoodsId;
@property(nonatomic,strong)NSString *telphone;

@property(nonatomic,strong)NSString *addressId;

@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *reasonId;

@property(nonatomic,strong)NSString *serviceOrderId;

//商品
@property(nonatomic,strong)NSString *paraId;
@property(nonatomic,strong)NSString *goodsId;
@property(nonatomic,strong)NSString *cPartnerId;

@property(nonatomic,strong)NSString *price;

//是否已经登录
@property(nonatomic,assign)NSString *isBoolLogin;
@property(nonatomic,assign)NSString *push;

@property(nonatomic,assign)NSString *isBoolmy;

//头像
@property(nonatomic,assign)NSString *fileUrl;



//通过类方法，创建唯一的对象
+(SingleModel *)sharedSingleModel;

@end
