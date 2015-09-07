//
//  Mobliejudge.h
//  智慧社区
//
//  Created by apple on 15-4-8.
//  Copyright (c) 2015年 Francis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mobliejudge : NSObject
+ (NSString *)valiMobile:(NSString *)mobile;
+ (BOOL)verifyIDCardNumber:(NSString *)value;
+ (BOOL)isChinese:(NSString *)value;
+ (BOOL)checkChinese:(NSString *)chinese;
+(BOOL)isValidateEmail:(NSString *)email;
@end
