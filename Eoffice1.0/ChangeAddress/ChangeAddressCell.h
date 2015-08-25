//
//  ChangeAddressCell.h
//  Eoffice1.0
//
//  Created by tangtao on 15/8/25.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeAddressCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableview indexpthnumber:(NSInteger)number;
@property(copy,nonatomic)NSString *message;
@property(copy,nonatomic)NSString *detailstring;
@end
