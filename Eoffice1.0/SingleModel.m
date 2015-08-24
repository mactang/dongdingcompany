//
//  SingleModel.m
//  Eoffice1.0
//
//  Created by gyz on 15/8/6.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "SingleModel.h"

@implementation SingleModel
//1.声明一个静态的对象指针
static SingleModel *singleModel = nil;
+(SingleModel *)sharedSingleModel{
    //2.线程安全
    @synchronized(self){
        if (singleModel == nil) {
            //3.创建对象
            singleModel = [[SingleModel alloc]init];
        }
    }
    //4.返回对象
    return singleModel;
}

//重新allocWithZone：方法（保证任何情况下都只能生成唯一的对象）
+(id)allocWithZone:(struct _NSZone *)zone{
    if (singleModel == nil) {
        singleModel = [super allocWithZone:zone];
        
    }
    return singleModel;
}


@end
