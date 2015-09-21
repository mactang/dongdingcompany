//
//  ShopCarModel.m
//  Eoffice1.0
//
//  Created by gyz on 15/8/13.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ShopCarModel.h"

@implementation ShopCarModel
+(ShopCarModel *)modelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.name = dic[@"name"];
        self.Description = dic[@"description"];
        self.price = dic[@"price"];
        self.count = dic[@"count"];
        self.subTotal = dic[@"subTotal"];
        self.goodsId = dic[@"goodsId"];
        self.cartId = dic[@"cartId"];
        self.cartImg = dic[@"cartImg"];
        
        
    }
    
    return self;
}
@end
