//
//  TheSameHeaderView.h
//  Eoffice1.0
//
//  Created by tangtao on 15/11/24.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^HeaderViewClickBlock)(UIButton *button);
@interface TheSameHeaderView : UITableViewHeaderFooterView
-(void)titlelabel:(NSString *)titlestring headerblock:(HeaderViewClickBlock) block;
@property(nonatomic, copy)HeaderViewClickBlock block;
@property(nonatomic,copy)NSString *tieleName;
@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIButton *orderbutton;
@end
