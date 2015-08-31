//
//  ChangeModel.h
//  Eoffice1.0
//
//  Created by tangtao on 15/8/26.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangeModel : NSObject
/**
 * 所在地区
 */
@property (nonatomic,copy) NSString *distrit;
/**
 * 标记
 */
@property (nonatomic,assign) NSInteger indexNumber;
/**
 * 街道
 */
@property (nonatomic,copy) NSString *street;
/**
 * 详细地址
 */
@property (nonatomic,copy) NSString *detailAddress;
/**
 * 收货人姓名
 */
@property (nonatomic,copy) NSString *receiverName;
/**
 * 手机号码
 */
@property (nonatomic,copy) NSString *phoneNumber;
/**
 * 邮编
 */
@property (nonatomic,copy) NSString *postNumber;
/**
 * 是否默认地址
 */
@property(nonatomic,copy) NSString *isdefault;
@end
