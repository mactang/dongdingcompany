//
//  RecommCodeGenerator.h
//  Eoffice1.0
//
//  Created by gyz on 15/10/14.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommCodeGenerator : NSObject
+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size;
@end
