//
//  AddressViewController.h
//  Eoffice1.0
//
//  Created by gyz on 15/7/23.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol refreshaddress <NSObject>

-(void)refreshDefault;

@end
@interface AddressViewController : UIViewController
@property(nonatomic,assign)id<refreshaddress>delegate;
@end
