//
//  OrederManagerCell.h
//  Eoffice1.0
//
//  Created by gyz on 15/9/7.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;
@interface OrederManagerCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableview;
@property(nonatomic,strong)AddressModel *model;
@property(nonatomic,assign)NSInteger buttontag;

@end
