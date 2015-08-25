//
//  OrderStateModel.h
//  Eoffice1.0
//
//  Created by gyz on 15/8/24.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderStateModel : NSObject
@property (copy,nonatomic) NSString *dealTime;
@property (copy,nonatomic) NSString *status;
@property (copy,nonatomic) NSString *remark;




+(OrderStateModel *)modelWithDic:(NSDictionary *)dic;
-(id)initWithDic:(NSDictionary *)dic;
@end
