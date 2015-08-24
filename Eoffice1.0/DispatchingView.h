//
//  DispatchingView.h
//  Eoffice1.0
//
//  Created by gyz on 15/7/22.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DispatchingView;
@interface DispatchingView : UIView
- (id)initWithTitle:(NSString *)title
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle;

- (void)show;
@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
//点击左右按钮都会触发该消失的block
@property (nonatomic, copy) dispatch_block_t dismissBlock;

+(DispatchingView*)showmessage:(NSString *)message subtitle:(NSString *)subtitle cancelbutton:(NSString *)cancle;
@end
