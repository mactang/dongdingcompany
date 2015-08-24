//
//  CMdetailCell.h
//  Eoffice1.0
//
//  Created by gyz on 15/7/13.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CMdetailCell;
@class BigPhotoModel;
@interface CMdetailCell : UITableViewCell
@property(nonatomic, strong)UIImageView *leftImageView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)BigPhotoModel *myModel;
@property(nonatomic,strong)UIButton *myBt;
@property(nonatomic,strong)UIButton *myBt1;
+(CMdetailCell *)cellWithTableView:(UITableView *)tableView;

@end
