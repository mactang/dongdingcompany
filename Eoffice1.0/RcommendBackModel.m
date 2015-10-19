//
//  RcommendBackModel.m
//  Eoffice1.0
//
//  Created by gyz on 15/10/16.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "RcommendBackModel.h"

@implementation RcommendBackModel
+(RcommendBackModel *)modelWithDic:(NSDictionary *)dic{

    return [[RcommendBackModel alloc]initWithDic:dic];
}
-(id)initWithDic:(NSDictionary *)dic{

    self.registerCount = dic[@"registerCount"];
    self.buyCount = dic[@"buyCount"];
    self.totalAmount = dic[@"totalAmount"];
    self.code = dic[@"code"];
    return self;
}
@end
