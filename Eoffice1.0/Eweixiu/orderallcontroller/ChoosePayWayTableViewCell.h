//
//  ChoosePayWayTableViewCell.h
//  Eoffice1.0
//
//  Created by tangtao on 15/12/2.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol choosePaydelegate <NSObject>

-(void)buttondelegate:(UIButton *)button;

@end
@interface ChoosePayWayTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *picimageview;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *chooseButton;
@property(nonatomic,strong)NSDictionary *dictionary;
@property(nonatomic,assign)NSInteger buttontag;
@property(nonatomic,assign)id<choosePaydelegate>delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableview;
@end
