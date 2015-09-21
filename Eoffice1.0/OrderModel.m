//
//  OrderModel.m
//  Eoffice1.0
//
//  Created by gyz on 15/8/10.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel
+(OrderModel *)modelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.Description = dic[@"description"];
        self.price = dic[@"price"];
        self.orderDescription = dic[@"orderDescription"];
        self.color = dic[@"color"];
        self.size = dic[@"size"];
        self.imgurl = dic[@"imgurl"];
        self.orderId = dic[@"orderId"];
        self.docstatus = dic[@"docstatus"];
        self.list = dic[@"list"];
        self.totalFee = dic[@"totalFee"];
    }
    
    return self;
}
@end
