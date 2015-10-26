//
//  detailsModel.m
//  Eoffice1.0
//
//  Created by gyz on 15/8/6.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "detailsModel.h"

@implementation detailsModel
+(detailsModel *)modelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.price = dic[@"price"];
        self.wGoodsId = dic[@"wgoodsId"];
        self.imgUrl = dic[@"imgUrl"];
        self.productId = dic[@"productId"];
        self.bparterId = dic[@"bparterId"];
        self.name = dic[@"name"];
        self.data = dic[@"data"];
        self.version = dic[@"version"];
        self.goodsImgUrl = dic[@"goodsImgUrl"];
        self.detaiImgUrl = dic[@"detaiImgUrl"];
    }
    
    return self;
}
@end
