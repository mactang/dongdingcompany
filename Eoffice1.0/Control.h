//
//  Control.h
//  Eoffice1.0
//
//  Created by gyz on 15/7/13.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Control;
typedef void(^block)(Control *button);
@interface Control : UIButton
+(Control *)buttonWithFrame:(CGRect)frame
                        font:(int)size
                       title:(NSString *)title
                        type:(UIButtonType)type
             backgroundImage:(NSString *)backgroundImage
                       image:(NSString *)image
                    andBlock:(block)myBlock;
@end

@interface UIImageView (ZKControl)
+(UIImageView *)imageViewWithFrame:(CGRect)frame image:(NSString *)image;
@end

@interface UILabel (ZKControl)
+(UILabel *)labelWithFrame:(CGRect)frame title:(NSString *)title font:(int)size;

+(UILabel *)boldLabelWithFrame:(CGRect)frame title:(NSString *)title font:(int)size;
@end