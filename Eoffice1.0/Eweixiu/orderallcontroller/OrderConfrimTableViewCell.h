//
//  OrderConfrimTableViewCell.h
//  Eoffice1.0
//
//  Created by tangtao on 15/12/2.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderConfrimTableViewCell : UITableViewCell
@property(nonatomic,strong)NSDictionary *dictionary;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *itemLabel;
@property(nonatomic,assign)BOOL sucess;
@end
