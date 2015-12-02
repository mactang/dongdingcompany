//
//  ButtonHeaderController.h
//  Eoffice1.0
//
//  Created by tangtao on 15/11/25.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AppointmentDelegate <NSObject>

-(void)chooseAddressed;

@end
@interface ButtonHeaderController : UITableViewHeaderFooterView
@property(nonatomic,copy)NSString *sectionstring;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,assign)id<AppointmentDelegate>delegate;
@end
