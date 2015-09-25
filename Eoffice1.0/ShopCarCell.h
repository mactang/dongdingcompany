//
//  ShopCarCell.h
//  Eoffice1.0
//
//  Created by gyz on 15/9/25.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopCarModel;
@interface ShopCarCell : UITableViewCell

@property(nonatomic, strong)ShopCarModel *myModel;
@property(nonatomic, strong)UIButton *chooseBtn;
@property(nonatomic, strong)UIImageView *ImageView;
@property(nonatomic, strong)UILabel *nameLB;
@property(nonatomic, strong)UILabel *priceLB;
@property(nonatomic, strong)UILabel *countBL;
+ (ShopCarCell *)cellWithTableView:(UITableView *)tableView;
@end
