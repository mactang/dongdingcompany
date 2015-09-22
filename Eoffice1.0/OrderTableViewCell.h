//
//  OrderTableViewCell.h
//  Eoffice1.0
//
//  Created by tangtao on 15/9/20.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell
@property(strong,nonatomic)NSDictionary *dic;
+ (instancetype)cellWithTableView:(UITableView *)tableview;
@end
