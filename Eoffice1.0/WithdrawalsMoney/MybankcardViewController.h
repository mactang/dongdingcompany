//
//  MybankcardViewController.h
//  Eoffice1.0
//
//  Created by tangtao on 15/10/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol bankcardelegate <NSObject>
-(void)choosebankcard:(NSDictionary *)dic;
@end
@interface MybankcardViewController : UIViewController
@property(nonatomic,assign)BOOL sucess;
@property(nonatomic,assign)id<bankcardelegate>delegate;
@end
