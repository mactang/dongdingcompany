//
//  CategoryBig.h
//  Eoffice1.0
//
//  Created by gyz on 15/8/4.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryBig : NSObject
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *MProductMedcategoryId;
@property (copy,nonatomic) NSString *adClientId;
@property (copy,nonatomic) NSString *adOrgId;
@property (copy,nonatomic) NSString *created;
@property (copy,nonatomic) NSString *createdby;
@property (copy,nonatomic) NSString *description;
@property (copy,nonatomic) NSString *isactive;
@property (copy,nonatomic) NSString *MProductCategoryId;

@property (copy,nonatomic) NSString *updated;

@property (copy,nonatomic) NSString *updatedby;
@property (copy,nonatomic) NSString *value;



+(CategoryBig *)modelWithDic:(NSDictionary *)dic;
-(id)initWithDic:(NSDictionary *)dic;
@end
