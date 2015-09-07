//
//  PersonInformationModel.m
//  Eoffice1.0
//
//  Created by gyz on 15/8/25.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "PersonInformationModel.h"

@implementation PersonInformationModel
+(PersonInformationModel *)modelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.name = dic[@"name"];
        self.shorname = dic[@"shorname"];
        self.gender = dic[@"gender"];
        self.birthday = dic[@"birthday"];
        
        
    }
    
    return self;
}

@end
