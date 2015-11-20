//
//  OrderAddressViewController.h
//  Eoffice1.0
//
//  Created by gyz on 15/9/7.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol messagedelegate <NSObject>
-(void)newaddressrelaod;
@end
@interface OrderAddressViewController : UIViewController
@property(nonatomic,assign)id<messagedelegate>delegate;
@end
