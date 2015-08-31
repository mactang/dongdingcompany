//
//  ManageAddressCell.h
//  Eoffice1.0
//
//  Created by tangtao on 15/8/28.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;
@protocol buttondelegate <NSObject>

-(void)buttondelegate:(UIButton *)button;
-(void)delegatedata:(NSInteger )buttontag;

@end
@interface ManageAddressCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableview;
@property(nonatomic,strong)AddressModel *model;
@property(nonatomic,strong)UIButton *clickbutton;
@property(nonatomic,assign)NSInteger buttontag;
@property(nonatomic,assign)id<buttondelegate>delegate;
@end
