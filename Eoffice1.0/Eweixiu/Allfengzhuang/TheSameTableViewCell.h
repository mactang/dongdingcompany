//
//  TheSameTableViewCell.h
//  Eoffice1.0
//
//  Created by tangtao on 15/11/24.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheSameTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableview;
@property(nonatomic,copy)NSString *titlestring;
@property(nonatomic,strong)UILabel *titlelabel;
@end
