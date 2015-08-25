//
//  OrderStateModel.m
//  Eoffice1.0
//
//  Created by gyz on 15/8/24.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "OrderStateModel.h"

@implementation OrderStateModel
+(OrderStateModel *)modelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.dealTime = dic[@"dealTime"];
        self.status = dic[@"status"];
        self.remark = dic[@"remark"];
        
        
    }
    
    return self;
}

@end
