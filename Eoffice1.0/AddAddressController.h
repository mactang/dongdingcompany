//
//  AddAddressController.h
//  Eoffice1.0
//
//  Created by gyz on 15/8/1.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol reloaddelegate <NSObject>
-(void)reloaddata;
@end
@interface AddAddressController : UIViewController
@property(nonatomic,assign)id<reloaddelegate>delegate;
@end
