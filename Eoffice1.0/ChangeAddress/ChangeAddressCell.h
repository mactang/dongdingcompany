//
//  ChangeAddressCell.h
//  Eoffice1.0
//
//  Created by tangtao on 15/8/25.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChangeModel;
@protocol districtdelegate <NSObject>
-(void)citydelegatemesthd:(UILabel *)district;
-(void)textfieldtext:(NSString *)text texttag:(NSInteger )tagnumber;
-(void)buttonclick:(NSString *)defaultstring;
@end
@interface ChangeAddressCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableview indexpthnumber:(NSInteger)number;
@property(copy,nonatomic)NSString *message;
@property(copy,nonatomic)NSString *detailstring;
@property(assign,nonatomic)NSInteger indexnumber;
@property(strong,nonatomic)ChangeModel *model;
@property(assign,nonatomic)id<districtdelegate>delegate;
@end
