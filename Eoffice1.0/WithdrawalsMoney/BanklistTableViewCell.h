//
//  BanklistTableViewCell.h
//  Eoffice1.0
//
//  Created by tangtao on 15/10/19.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol buttondelegate <NSObject>

-(void)cellbutton:(UIButton *)button;

@end
@interface BanklistTableViewCell : UITableViewCell
@property(nonatomic,assign)NSInteger cellNo;
@property(nonatomic,strong)NSMutableDictionary *dic;
@property(nonatomic,strong)UILabel *addbankcrdlabel;
@property(nonatomic,strong)UILabel *addbanklabel;
@property(nonatomic,strong)UIImageView *picimageview;
@property(nonatomic,strong)UILabel *banklabel;
@property(nonatomic,strong)UILabel *bankNo;
@property(nonatomic,strong)UIButton *cellbutton;
@property(nonatomic,assign)id<buttondelegate>delegate;
@end
