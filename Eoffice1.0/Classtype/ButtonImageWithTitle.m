//
//  ButtonImageWithTitle.m
//  315旅游
//
//  Created by Francis on 14-12-17.
//  Copyright (c) 2014年 Francis. All rights reserved.
//

#import "ButtonImageWithTitle.h"

@implementation ButtonImageWithTitle
- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
    }
    
    return self;
    
}

/**
 *  重写按钮文字的大小位子
 *
 *  @param contentRect 按钮大小位置
 *
 *  @return 文字大小位置
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    CGFloat titleW = contentRect.size.width;
    
    CGFloat titleH = 20 ;
    
    CGFloat titleX = 0;
    
    CGFloat titleY = contentRect.size.height-20;
    
    contentRect = (CGRect){{titleX,titleY},{titleW,titleH}};
    
    return contentRect;
}

//更具button的rect设定并返回UIImageView的rect

- (CGRect)imageRectForContentRect:(CGRect)contentRect

{
    CGFloat imageW = contentRect.size.width/10*3;
    
    CGFloat imageH = imageW+2;
    
    CGFloat imageX = (contentRect.size.width-(contentRect.size.width/10*3))/2;
    
    CGFloat imageY = 10;
    
    contentRect = (CGRect){{imageX,imageY},{imageW,imageH}};
    
    return contentRect;
}
@end
