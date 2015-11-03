//
//  MainBanner.h
//  Eoffice1.0
//
//  Created by gyz on 15/11/2.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainBanner : NSObject
@property (nonatomic,strong)NSString *imgurl;
@property (nonatomic,strong)NSString *imgdescription;
@property (nonatomic,strong)NSString *hrefAddress;

+(MainBanner *)modelWithDic:(NSDictionary *)dic;
-(id)initWithDic:(NSDictionary *)dic;
@end
