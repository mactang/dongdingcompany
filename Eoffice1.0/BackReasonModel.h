//
//  BackReasonModel.h
//  Eoffice1.0
//
//  Created by gyz on 15/8/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackReasonModel : NSObject
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *reasonId;




+(BackReasonModel *)modelWithDic:(NSDictionary *)dic;
-(id)initWithDic:(NSDictionary *)dic;
@end
