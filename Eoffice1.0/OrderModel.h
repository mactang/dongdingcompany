//
//  OrderModel.h
//  Eoffice1.0
//
//  Created by gyz on 15/8/10.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (strong,nonatomic) NSString *Description;
@property (strong,nonatomic) NSString *price;
@property (strong,nonatomic) NSString *orderDescription;
@property (strong,nonatomic) NSString *color;
@property (strong,nonatomic) NSString *size;
@property (strong,nonatomic) NSString *imgurl;
@property (strong,nonatomic) NSString *orderId;
@property (strong,nonatomic) NSString *docstatus;

@property (strong,nonatomic) NSArray *list;


+(OrderModel *)modelWithDic:(NSDictionary *)dic;
-(id)initWithDic:(NSDictionary *)dic;
@end
