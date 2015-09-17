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
-(void)reloadshopcart;
@end
@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,assign)id<logindelegate>delegate;
@property(nonatomic,assign)BOOL iflogin;
@end
