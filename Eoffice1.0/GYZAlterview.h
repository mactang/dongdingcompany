//
//  XWAlterview.h
//  new
//
//  Created by chinat2t on 14-11-6.
//  Copyright (c) 2014年 chinat2t. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYZAlterview ;
@interface GYZAlterview : UIView
- (id)initWithTitle:(NSString *)title
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle;

- (void)show;
@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
//点击左右按钮都会触发该消失的block
@property (nonatomic, copy) dispatch_block_t dismissBlock;

+(GYZAlterview*)showmessage:(NSString *)message subtitle:(NSString *)subtitle cancelbutton:(NSString *)cancle;
@end


