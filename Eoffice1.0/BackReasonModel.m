//
//  BackReasonModel.m
//  Eoffice1.0
//
//  Created by gyz on 15/8/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "BackReasonModel.h"

@implementation BackReasonModel
+(BackReasonModel *)modelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.title = dic[@"title"];
        self.reasonId = dic[@"reasonId"];
        
        
    }
    
    return self;
}

@end
