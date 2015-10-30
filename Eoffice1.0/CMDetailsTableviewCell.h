//
//  CMDetailsTableviewCell.h
//  Eoffice1.0
//
//  Created by tangtao on 15/10/30.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class detailsModel;
@interface CMDetailsTableviewCell : UITableViewCell
@property(nonatomic,strong)detailsModel *model;
@property(nonatomic,assign)NSInteger indexpathsection;
+ (instancetype)cellWithTableView:(UITableView *)tableview cellnumber:(NSInteger )cellnumber;
@end
