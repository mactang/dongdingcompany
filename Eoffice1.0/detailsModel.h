//
//  detailsModel.h
//  Eoffice1.0
//
//  Created by gyz on 15/8/6.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface detailsModel : NSObject
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *wGoodsId;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *bparterId;
@property (nonatomic, strong) NSString *imgUrl;

+(detailsModel *)modelWithDic:(NSDictionary *)dic;
-(id)initWithDic:(NSDictionary *)dic;
@end
