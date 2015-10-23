//
//  BankdetailViewController.h
//  Eoffice1.0
//
//  Created by tangtao on 15/10/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol refreshdatadelegate <NSObject>

-(void)refreshdatalist;

@end
@interface BankdetailViewController : UIViewController
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,assign)id<refreshdatadelegate>delegate;
@end
