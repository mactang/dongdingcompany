//
//  classifyDetailaModel.m
//  Eoffice1.0
//
//  Created by gyz on 15/9/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "classifyDetailaModel.h"

@implementation classifyDetailaModel

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
    
    CGFloat titleH = 0 ;
    
    CGFloat titleX = (contentRect.size.width-(contentRect.size.width/10*3))/2+10;
    
    CGFloat titleY = 0;
    
    contentRect = (CGRect){{titleX-30,titleY+8},{titleW+80,titleH+20}};
    
    return contentRect;
}

//更具button的rect设定并返回UIImageView的rect

- (CGRect)imageRectForContentRect:(CGRect)contentRect

{
    CGFloat imageW = contentRect.size.width/10*3;
    
    CGFloat imageH = imageW+2;
    
    CGFloat imageX = (contentRect.size.width-(contentRect.size.width/10*3))/2-10;
    
    CGFloat imageY = 10;
    
    contentRect = (CGRect){{imageX-45,imageY-5},{imageW+10,imageH+10}};
    
    return contentRect;
}


@end
