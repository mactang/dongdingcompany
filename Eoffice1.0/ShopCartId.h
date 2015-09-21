//
//  ShopCartId.h
//  Eoffice1.0
//
//  Created by gyz on 15/9/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCartId : NSObject

@property (strong,nonatomic) NSArray *list;





+(ShopCartId *)modelWithDic:(NSDictionary *)dic;
-(id)initWithDic:(NSDictionary *)dic;
@end
