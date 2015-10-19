//
//  BanklistTableViewCell.h
//  Eoffice1.0
//
//  Created by tangtao on 15/10/19.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BanklistTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *picimageview;
@property(nonatomic,strong)UILabel *banklabel;
@property(nonatomic,strong)UILabel *bankNo;
@property(nonatomic,assign)NSInteger cellNo;
@property(nonatomic,assign)NSInteger datacount;
@property(nonatomic,strong)NSMutableDictionary *dic;
@property(nonatomic,strong)UILabel *addbankcrdlabel;
@end
