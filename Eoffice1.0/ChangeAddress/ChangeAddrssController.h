//
//  ChangeAddrssController.h
//  Eoffice1.0
//
//  Created by gyz on 15/8/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol reloadAddressdelegate <NSObject>
-(void)reloadAddress;
-(void)delegateaddress:(NSString *)addressid;
@end
@interface ChangeAddrssController : UIViewController
-(instancetype)initwithtitle:(NSDictionary *)dicdata;
@property(nonatomic,assign)id<reloadAddressdelegate>delegate;
@end
