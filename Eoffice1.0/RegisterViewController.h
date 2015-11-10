//
//  RegisterViewController.h
//  Eoffice1.0
//
//  Created by gyz on 15/7/28.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountDownButton.h"
@protocol registerdelegate <NSObject>

-(void)LoginReloadata;

@end
@interface RegisterViewController : UIViewController
{

    CountDownButton *_countDownCode;
    
}
@property(nonatomic,assign)id<registerdelegate>delegate;

@end
