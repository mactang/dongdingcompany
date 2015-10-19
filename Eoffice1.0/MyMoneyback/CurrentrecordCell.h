//
//  CurrentrecordCell.h
//  Eoffice1.0
//
//  Created by tangtao on 15/10/14.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentrecordCell : UITableViewCell
@property(nonatomic,strong)UILabel *namelabel;
@property(nonatomic,strong)UILabel *moneylabel;
@property(nonatomic,strong)UILabel *timelabel;
@property(nonatomic,strong)UIView *lineview;
@property(nonatomic,strong)UIView *seconedview;
@property(nonatomic,strong)NSMutableDictionary *dic;
@end
