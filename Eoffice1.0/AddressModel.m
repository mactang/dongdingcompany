//
//  AddressModel.m
//  Eoffice1.0
//
//  Created by gyz on 15/8/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel
+(AddressModel *)modelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.receiver = dic[@"receiver"];
        self.fullAddress = dic[@"fullAddress"];
        self.address = dic[@"address"];
        self.addressId = dic[@"addressId"];
        self.telphone = dic[@"telphone"];
        self.post = dic[@"post"];
    }
    return self;
}

@end
