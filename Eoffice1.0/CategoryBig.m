//
//  CategoryBig.m
//  Eoffice1.0
//
//  Created by gyz on 15/8/4.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "CategoryBig.h"

@implementation CategoryBig
+(CategoryBig *)modelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.name = dic[@"name"];

        self.MProductCategoryId = dic[@"MProductCategoryId"];
    }
    
    return self;
}

@end
