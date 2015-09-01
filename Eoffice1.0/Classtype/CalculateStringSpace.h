//
//  CalculateStringSpace.h
//  315酒店
//
//  Created by Francis on 15-1-26.
//  Copyright (c) 2015年 Francis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculateStringSpace : NSObject
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constraintSize:(CGSize)constrainSize;
@end
