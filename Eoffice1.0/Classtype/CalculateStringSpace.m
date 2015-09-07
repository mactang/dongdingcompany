//
//  CalculateStringSpace.m
//  315酒店
//
//  Created by Francis on 15-1-26.
//  Copyright (c) 2015年 Francis. All rights reserved.
//

#import "CalculateStringSpace.h"
@implementation CalculateStringSpace
+(CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constraintSize:(CGSize)constrainSize
{
    CGSize size;
    CGRect rect = [string boundingRectWithSize:constrainSize
                                       options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading |
                   NSStringDrawingTruncatesLastVisibleLine
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    size = rect.size;
    return size;
}
@end
