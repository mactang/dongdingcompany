//
//  CMDimageTableViewCell.h
//  Eoffice1.0
//
//  Created by tangtao on 15/10/30.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class detailsModel;
@interface CMDimageTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableview;
@property(nonatomic,strong)detailsModel *model;
@end
