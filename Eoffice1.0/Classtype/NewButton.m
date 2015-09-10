//
//  NewButton.m
//  Eoffice1.0
//
//  Created by gyz on 15/9/10.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "NewButton.h"

@implementation NewButton

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
    
    contentRect = (CGRect){{titleX-3,titleY+3},{titleW+10,titleH+25}};
    
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
