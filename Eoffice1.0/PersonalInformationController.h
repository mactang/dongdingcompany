//
//  PersonalInformationController.h
//  Eoffice1.0
//
//  Created by gyz on 15/7/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol persondelegate <NSObject>

-(void)repeatlogin;
-(void)rePersonInfor;

@end
@interface PersonalInformationController : UIViewController
@property(nonatomic,assign)id<persondelegate>delegate;
@end
