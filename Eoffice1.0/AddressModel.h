//
//  AddressModel.h
//  Eoffice1.0
//
//  Created by gyz on 15/8/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
@property (copy,nonatomic) NSString *receiver;
@property (copy,nonatomic) NSString *fullAddress;
@property (copy,nonatomic) NSString *address;
@property (copy,nonatomic) NSString *addressId;
@property (copy,nonatomic) NSString *telphone;
@property (copy,nonatomic) NSString *post;



+(AddressModel *)modelWithDic:(NSDictionary *)dic;
-(id)initWithDic:(NSDictionary *)dic;

@end
