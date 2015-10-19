//
//  RcommendBackModel.h
//  Eoffice1.0
//
//  Created by gyz on 15/10/16.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RcommendBackModel : NSObject
@property (nonatomic,strong)NSString *code;
@property (nonatomic,strong)NSString *totalAmount;
@property (nonatomic,strong)NSString *buyCount;
@property (nonatomic,strong)NSString *registerCount;
+(RcommendBackModel *)modelWithDic:(NSDictionary *)dic;
-(id)initWithDic:(NSDictionary *)dic;
@end
