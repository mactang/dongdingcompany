//
//  MainBanner.m
//  Eoffice1.0
//
//  Created by gyz on 15/11/2.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "MainBanner.h"

@implementation MainBanner
+(MainBanner *)modelWithDic:(NSDictionary *)dic{
    
    return [[MainBanner alloc]initWithDic:dic];
}
-(id)initWithDic:(NSDictionary *)dic{
    
    self.imgurl = dic[@"imgurl"];
    self.imgdescription = dic[@"imgdescription"];
    self.hrefAddress = dic[@"hrefAddress"];
    
    return self;
}
@end
