//
//  ImageCarousel.h
//  315Demo
//
//  Created by My_Mac on 14-10-27.
//  Copyright (c) 2014年 My_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ImageCarouselClickBlock)();

@interface ImageCarousel : UIView
- (void)startRefresh;
- (id)initWithFrame:(CGRect)frame andDataSource:(NSArray *)parameter;
- (id)initWithFrame:(CGRect)frame andDataSource:(NSArray *)parameter withClick:(ImageCarouselClickBlock)block;
@end
