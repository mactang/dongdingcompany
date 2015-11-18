//
//  UIAlertView+AlerViewBlocks.h
//  AlertViewBlocks
//
//  Created by RIMI on 14-7-25.
//  Copyright (c) 2014年 RIMI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (AlerViewBlocks) <UIAlertViewDelegate>

/**
 *  弹出一个提示框
 *
 *  @param title   提示框的标题
 *  @param msg     描述
 *  @param confirm 确认按钮标题
 *  @param cancel  取消按钮标题
 *  @param blocks  点击按钮会调用此代码块
 */

+(void)errorcode:(NSInteger)code blocks:(void (^)(NSInteger index))blocks;;
@end
