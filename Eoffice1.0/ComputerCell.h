//
//  ComputerCell.h
//  EOffice
//
//  Created by gyz on 15/7/10.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class detailsModel;
@interface ComputerCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UILabel *detailmessage;
@property(nonatomic ,strong)UILabel *price;
@property(nonatomic,strong)detailsModel *model;
@end
