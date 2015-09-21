//
//  ShopCartId.m
//  Eoffice1.0
//
//  Created by gyz on 15/9/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ShopCartId.h"

@implementation ShopCartId
+(ShopCartId *)modelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.list = dic[@"list"];

        
    }
    
    return self;
}

@end
