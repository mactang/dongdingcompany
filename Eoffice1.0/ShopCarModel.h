//
//  ShopCarModel.h
//  Eoffice1.0
//
//  Created by gyz on 15/8/13.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCarModel : NSObject
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *Description;
@property (copy,nonatomic) NSString *price;
@property (copy,nonatomic) NSString *count;
@property (copy,nonatomic) NSString *subTotal;
@property (copy,nonatomic) NSString *goodsId;
@property (copy,nonatomic) NSString *cartId;
@property (copy,nonatomic) NSString *cartImg;
@property (copy,nonatomic) NSArray *version;
@property (copy,nonatomic) NSString *maValue;


+(ShopCarModel *)modelWithDic:(NSDictionary *)dic;
-(id)initWithDic:(NSDictionary *)dic;
@end
