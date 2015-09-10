//
//  LoginViewController.h
//  EOffice
//
//  Created by gyz on 15/7/8.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol logindelegate <NSObject>

-(void)reloadata;

@end
@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,assign)id<logindelegate>delegate;
@end
