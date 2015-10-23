//
//  AddBankcardController.h
//  Eoffice1.0
//
//  Created by tangtao on 15/10/16.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol addbankdelegate <NSObject>

-(void)reloadlist;

@end
@interface AddBankcardController : UIViewController
@property(nonatomic,assign)id<addbankdelegate>delegate;
@property(nonatomic,assign)BOOL sucess;
@end
